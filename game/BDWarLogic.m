#import "BDWarLogic.h"
#import "BDSquad.h"

@interface BDWarLogic ()

@property (nonatomic, assign)double distance;

@end


@implementation BDWarLogic

- (instancetype)initWithAttackingTroops:(NSArray *)attacDictionary defendingTroops:(NSArray *)defDictionary andDistance:(double)distance {
    self = [super init];
    if (self) {
        self.attackingTroops = attacDictionary;
        self.defendingTroops = defDictionary;
        self.distance = distance;
    }
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeOfTravel] target:self selector:@selector(attack) userInfo:nil repeats: NO];
    [myTimer fire];
    
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

- (BOOL)ckeckIfAllAreDead:(NSArray *)troops{
    for (BDSquad* key in troops){
        if(!key.count){
            return NO;
        }
    }
    return YES;
}

- (void)attack {
    NSLog(@"the war has begun");
    NSInteger deffendersKiled, attackersKiled;
	for (BDSquad *attackingUnit in self.attackingTroops) {
        BDSquad *defendingUnit = [self findWarUnit:attackingUnit.unit.favouriteTarget inArray:self.defendingTroops];
        deffendersKiled = [self soldiersKilledBy:attackingUnit.count ofKind:attackingUnit.unit defendedBy:defendingUnit.count ofKind:defendingUnit.unit];
        attackersKiled = [self soldiersKilledBy:defendingUnit.count ofKind:defendingUnit.unit defendedBy:attackingUnit.count ofKind:attackingUnit.unit];
        defendingUnit.count -= deffendersKiled;
        attackingUnit.count -= attackersKiled;
	}
	if([self ckeckIfAllAreDead:self.attackingTroops] == YES || [self ckeckIfAllAreDead:self.defendingTroops] == YES) {
        NSLog(@"the war is over");
        if([self ckeckIfAllAreDead:self.attackingTroops] == YES) {
			NSLog(@"defenders won");
			self.amountOfStolenResources = 0;
		}
        else {
			NSLog(@"attackers won");
			[self getAmountOfStolenResourcesByTroops];
		}
    } else{
        NSInteger randomNumber , s = 0;
        NSInteger s1 = 0, s2 = 0;
        for (BDSquad* defUnit in self.defendingTroops) {
			if(defUnit.count) s++;
        }
        for (BDSquad *attackingUnit in self.attackingTroops) {
            if(attackingUnit.count){
                randomNumber = arc4random_uniform((unsigned int )(s - 1));
                BDSquad *defendingUnit = self.defendingTroops[randomNumber];
                deffendersKiled = [self soldiersKilledBy:attackingUnit.count ofKind:attackingUnit.unit defendedBy:defendingUnit.count ofKind:defendingUnit.unit];
                attackersKiled = [self soldiersKilledBy:defendingUnit.count ofKind:defendingUnit.unit defendedBy:attackingUnit.count ofKind:attackingUnit.unit];
                defendingUnit.count -= deffendersKiled;
                attackingUnit.count -= attackersKiled;
            }
        }

		NSLog(@"Final standings: ");
		for (BDSquad* attUnit in self.attackingTroops) {
			s1 += (attUnit.unit.attack + attUnit.unit.defense + attUnit.unit.life) * attUnit.count;
		}
        for (BDSquad *defUnit in self.defendingTroops) {
            s1 += (defUnit.unit.attack + defUnit.unit.defense + defUnit.unit.life) * defUnit.count;
        }
        if(s1 > s2){
            self.winner = [NSString stringWithFormat: @"attackers"];
			[self getAmountOfStolenResourcesByTroops];
		}
        else {
            self.winner = [NSString stringWithFormat: @"defenders"];
			self.amountOfStolenResources = 0;
		}
        NSLog(@"%@", self.winner);
	}
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeOfTravel] target: self selector:@selector(incrementPlayerResources) userInfo: nil repeats: NO];
    [myTimer fire];
}

-(void)getAmountOfStolenResourcesByTroops{
	for (BDSquad* unit in self.attackingTroops) {
		self.amountOfStolenResources += unit.count * unit.unit.carryCapacity;
	}
}

- (BDSquad *)findWarUnit:(BDUnit *)unit inArray:(NSArray *)array {
    for (BDSquad *warUnit in array) {
        if ([warUnit.unit isKindOfClass:[unit class]]) {
            return warUnit;
        }
    }
    return nil;
}

- (NSInteger)timeOfTravel{
    NSInteger speed = 0, c = 0;
    for (BDSquad *attackingUnit in self.attackingTroops){
        speed += attackingUnit.unit.speed * attackingUnit.count;
        c += attackingUnit.count;
    }
    return self.distance * speed / c;
}

- (void) incrementPlayerResources{
    self.player.gold += self.amountOfStolenResources;
    self.player.wood += self.amountOfStolenResources;
    self.player.iron += self.amountOfStolenResources;
}

@end



