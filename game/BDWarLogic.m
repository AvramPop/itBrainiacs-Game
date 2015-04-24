#import "BDWarLogic.h"


@interface BDWarLogic ()

@end


@implementation BDWarLogic

- (instancetype)initWithAttackingTroops:(NSMutableDictionary *)attacDictionary defendingTroops:(NSMutableDictionary *)defDictionary {
    self = [super init];
    if (self) {
        self.attackingTroops = attacDictionary;
        self.defendingTroops = defDictionary;
    }
    
    return self;
}

-(NSInteger)soldiersKilledBy:(NSInteger)amountOfAttackingSoldiers ofKind:(BDUnit *)attackingTroopsType defendedBy:(NSInteger)amountOfDefendingSoldiers ofKind:(BDUnit *)defendingTroopsType {
    float rap = amountOfAttackingSoldiers / amountOfDefendingSoldiers;
    float a = amountOfDefendingSoldiers / rap;
    if ((defendingTroopsType.defense - rap * attackingTroopsType.attack) < defendingTroopsType.life * -1){
        return amountOfDefendingSoldiers;
    }
    else if ((defendingTroopsType.defense - rap * attackingTroopsType.attack) < 0){
        return (((defendingTroopsType.defense - rap * attackingTroopsType.attack) * -1) / defendingTroopsType.life) * a;
    }
    else return 0;
}

- (BOOL)ckeckIfAllAreDead:(NSDictionary *)troops{
    for (NSString* key in troops){
        id value = [troops objectForKey:key];
        if(value){
            return YES;
        }
    }
    return NO;
}


-(void)attack{
    NSInteger a, b;
	for (NSString* key in self.attackingTroops) {
		id value = self.attackingTroops[key];
		if(value){
            a = [self soldiersKilledBy:[self.attackingTroops[key] integerValue] ofKind:nil defendedBy:0 ofKind:((BDUnit *)self.defendingTroops[key]).favouriteTarget];
            b = [self soldiersKilledBy:0 ofKind:((BDUnit *)self.defendingTroops[key]).favouriteTarget defendedBy:[self.attackingTroops[key] integerValue] ofKind:nil];
			self.defendingTroops[key] = [NSNumber numberWithInteger:[self.defendingTroops[key] integerValue] - a];
			self.attackingTroops[key] = [NSNumber numberWithInteger:[self.attackingTroops[key] integerValue] - b];
		}	
	}
	if([self ckeckIfAllAreDead:self.attackingTroops] == YES || [self ckeckIfAllAreDead:self.defendingTroops] == YES) {
        NSLog(@"the war is over");
        if([self ckeckIfAllAreDead:self.attackingTroops] == YES) {
			NSLog(@"defenders won");
			self.amountOfStolenResources = 0;
		}
        else {
			NSLog(@"attackers won");
			[self getAmountOfStolenResourcesByTroops:self.attackingTroops];
		}
    } else{
        NSInteger r , s = 0;
        id value;
        NSInteger s1 = 0, s2 = 0;
        for (NSString* key in self.defendingTroops) {
			value = [self.defendingTroops objectForKey:key];
			if(value) s++;
        }
        
        for (NSString* key in self.attackingTroops) {
			value = [self.attackingTroops objectForKey:key];
            if(value){
                r = arc4random_uniform(s - 1);
                a = [self soldiersKilledBy:[self.attackingTroops[key] integerValue] ofKind:nil defendedBy:0 ofKind:((BDUnit *)self.defendingTroops[key]).favouriteTarget];
                b = [self soldiersKilledBy:0 ofKind:((BDUnit *)self.defendingTroops[key]).favouriteTarget defendedBy:[self.attackingTroops[key] integerValue] ofKind:0];
                self.defendingTroops[key] = [NSNumber numberWithInteger:[self.defendingTroops[key] integerValue] - a];
                self.attackingTroops[key] = [NSNumber numberWithInteger:[self.attackingTroops[key] integerValue] - b];
            }
        }

		NSLog(@"Final standings: ");
		for (NSString* key in self.attackingTroops) {
			s1 += ((BDUnit *)self.attackingTroops[key].attack + (BDUnit *)self.attackingTroops[key].defense + (BDUnit *)self.attackingTroops[key].health) * self.attackingTroops[key];
		}
		for (NSString* key in self.defendingTroops) {
			s1 += ((BDUnit *)self.defendingTroops[key].attack + (BDUnit *)self.defendingTroops[key].defense + (BDUnit *)self.defendingTroops[key].health) * self.defendingTroops[key];
		}
        if(s1 > s2){
			self.winner = [stringW	withFormat @"attackers"];
			[self getAmountOfStolenResourcesByTroops:self.attackingTroops];
		}
        else {
			self.winner = [stringWithFormat @"defenders"];
			self.amountOfStolenResources = 0;
		}
	}
}

-(void)getAmountOfStolenResourcesByTroops(NSDictionary *)troops{
	for (NSString* key in troops) {
		value = [troops objectForKey:key];
		self.amountOfStolenResources += value * (BDUnit *)self.troops[key].carryCapacity;
	}
}

@end