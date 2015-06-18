#import "BDWarLogic.h"
#import "BDSquad.h"
#import "BDTown.h"

#import "BDRam.h"
#import "BDBaloon.h"
#import "BDArcher.h"
#import "BDAxeman.h"
#import "BDLightCavalery.h"
#import "BDWizard.h"
#import "BDHighCavalery.h"
#import "BDCatapult.h"
#import "BDSpy.h"
#import "BDSwordsman.h"

@interface BDWarLogic ()

@property (nonatomic, assign)double distance;
@property (nonatomic, assign)double defendingBonus;
@property (nonatomic, assign)double attackingBonus;


@property(nonatomic, strong) NSMutableArray                *attackingTroopsOriginal;
@property(nonatomic, strong) NSMutableArray                *defendingTroopsOriginal;

@end


@implementation BDWarLogic

- (instancetype)initWithAttackingTroops:(NSArray *)attacArray defendingTroops:(NSArray *)defArray andDistance:(double)distance {
    self = [super init];
    if (self) {
        self.attackingTroops = attacArray;
        self.defendingTroops = defArray;
        
        self.attackingTroopsOriginal = [NSMutableArray array];
        for (BDSquad *attackingUnit in self.attackingTroops) {
            BDSquad *squad = [[BDSquad alloc] initWithUnit:attackingUnit.unit andCount:attackingUnit.count];
            [self.attackingTroopsOriginal addObject:squad];
        }
        
        self.defendingTroopsOriginal = [NSMutableArray array];
        for (BDSquad *attackingUnit in self.defendingTroops) {
            BDSquad *squad = [[BDSquad alloc] initWithUnit:attackingUnit.unit andCount:attackingUnit.count];
            [self.defendingTroopsOriginal addObject:squad];
        }

        self.distance = distance;
        self.attackingBonus = 1.25;
        self.defendingBonus = 0.85;
    }
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeOfTravel] target:self selector:@selector(attack) userInfo:nil repeats: NO];
    [myTimer fire];
    
    return self;
}

-(NSInteger)soldiersKilledBy:(NSInteger)amountOfAttackingSoldiers ofKind:(BDUnit *)attackingTroopsType defendedBy:(NSInteger)amountOfDefendingSoldiers ofKind:(BDUnit *)defendingTroopsType {
    float rap = (float)amountOfAttackingSoldiers / (float)amountOfDefendingSoldiers;
    float lifePlusDef = defendingTroopsType.defense + defendingTroopsType.life;
    NSInteger delta = lifePlusDef - attackingTroopsType.attack * rap;
    if (delta < defendingTroopsType.life){
        return amountOfDefendingSoldiers;
    }
    
    float a = delta / (float)defendingTroopsType.life;
    return a;
}

- (BOOL)ckeckIfAllAreDead:(NSArray *)troops{
    for (BDSquad* key in troops){
        if(key.count){
            return NO;
        }
    }
    return YES;
}

- (void)attack {
    NSLog(@"the war has begun");
    NSInteger deffendersKiled, attackersKiled;

    if ([self checkIfWarIsOver]) {
        return [self finalStandings];
    }
    
    for (BDSquad *attackingUnit in self.attackingTroops) {
        if (attackingUnit.count) {
            BDSquad *defendingUnit = [self findWarUnit:attackingUnit.unit.favouriteTarget inArray:self.defendingTroops];
            if(!defendingUnit){
                defendingUnit = [self randomSquadFromArray:self.defendingTroops];
            }
            deffendersKiled = [self soldiersKilledBy:attackingUnit.count ofKind:attackingUnit.unit defendedBy:defendingUnit.count ofKind:defendingUnit.unit] * self.defendingBonus;
            deffendersKiled = MIN(deffendersKiled, defendingUnit.count);
            attackersKiled = [self soldiersKilledBy:defendingUnit.count ofKind:defendingUnit.unit defendedBy:attackingUnit.count ofKind:attackingUnit.unit] * self.attackingBonus;
            attackersKiled = MIN(attackersKiled, attackingUnit.count);
            defendingUnit.count -= deffendersKiled;
            attackingUnit.count -= attackersKiled;

            if ([attackingUnit.unit isKindOfClass:[BDSwordsman class]]) {
                [[BDPlayer currentPlayer] currentTown].swordsmanCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].swordsmanCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDAxeman class]]) {
                [[BDPlayer currentPlayer] currentTown].axemanCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].axemanCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDLightCavalery class]]) {
                [[BDPlayer currentPlayer] currentTown].lightCavaleryCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].lightCavaleryCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDRam class]]) {
                [[BDPlayer currentPlayer] currentTown].ramCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].ramCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDHighCavalery class]]) {
                [[BDPlayer currentPlayer] currentTown].highCavaleryCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].highCavaleryCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDSpy class]]) {
                [[BDPlayer currentPlayer] currentTown].spyCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].spyCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDBaloon class]]) {
                [[BDPlayer currentPlayer] currentTown].baloonCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].baloonCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDWizard class]]) {
                [[BDPlayer currentPlayer] currentTown].wizardCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].wizardCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDArcher class]]) {
                [[BDPlayer currentPlayer] currentTown].archerCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].archerCount = defendingUnit.count;
            } else if ([attackingUnit.unit isKindOfClass:[BDCatapult class]]) {
                [[BDPlayer currentPlayer] currentTown].catapultCount = attackingUnit.count;
                [[BDPlayer adversaryPlayer] currentTown].catapultCount = defendingUnit.count;
            }
        }
    }
    
    if (![self checkIfWarIsOver]) {
        NSInteger s = 0;
        for (BDSquad* defUnit in self.defendingTroops) {
			if(defUnit.count) s++;
        }
        for (BDSquad *attackingUnit in self.attackingTroops) {
            if(attackingUnit.count){
                BDSquad *defendingUnit = [self randomSquadFromArray:self.defendingTroops];
                deffendersKiled = [self soldiersKilledBy:attackingUnit.count ofKind:attackingUnit.unit defendedBy:defendingUnit.count ofKind:defendingUnit.unit] * self.defendingBonus;
                attackersKiled = [self soldiersKilledBy:defendingUnit.count ofKind:defendingUnit.unit defendedBy:attackingUnit.count ofKind:attackingUnit.unit] * self.attackingBonus;
                defendingUnit.count -= deffendersKiled;
                [[BDPlayer adversaryPlayer] currentTown].swordsmanCount = defendingUnit.count;
                attackingUnit.count -= attackersKiled;
                [[BDPlayer currentPlayer] currentTown].swordsmanCount = attackingUnit.count;

            }
        }
    }
    
    return [self finalStandings];
}

- (BOOL)checkIfWarIsOver {
    if([self ckeckIfAllAreDead:self.attackingTroops]) {
        self.amountOfStolenResources = 0;
        return YES;
    } else if ([self ckeckIfAllAreDead:self.defendingTroops]) {
        [self getAmountOfStolenResourcesByTroops];
        return YES;
    }
    return NO;
}

- (void)finalStandings {
    NSInteger s1 = 0, s2 = 0;

    NSLog(@"Final standings: ");
    for (BDSquad* attUnit in self.attackingTroops) {
        s1 += (attUnit.unit.attack + attUnit.unit.defense + attUnit.unit.life) * attUnit.count;
    }
    for (BDSquad *defUnit in self.defendingTroops) {
        s2 += (defUnit.unit.attack + defUnit.unit.defense + defUnit.unit.life) * defUnit.count;
    }
    if(s1 > s2){
        self.winner = @"attackers";
        [self getAmountOfStolenResourcesByTroops];
    }
    else {
        self.winner = @"defenders";
        self.amountOfStolenResources = 0;
    }
    NSLog(@"%@ have won %ld resources", self.winner, self.amountOfStolenResources);
    
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeOfTravel] target: self selector:@selector(balanceEverithing) userInfo: nil repeats: NO];
    [myTimer fire];
}


-(void)getAmountOfStolenResourcesByTroops{
	for (BDSquad* unit in self.attackingTroops) {
		self.amountOfStolenResources += unit.count * unit.unit.carryCapacity;
	}
}

- (BDSquad *)findWarUnit:(Class)unit inArray:(NSArray *)array {
    for (BDSquad *warUnit in array) {
        if ([warUnit.unit isKindOfClass:unit]) {
            return warUnit;
        }
    }
    return nil;
}

- (NSInteger)timeOfTravel{
    NSInteger speed = 0, c = 0;
    for (BDSquad *attackingUnit in self.attackingTroops) {
        speed += attackingUnit.unit.speed * attackingUnit.count;
        c += attackingUnit.count;
    }
    return self.distance * speed / c;
}

- (void)balanceEverithing {
    [self balanceResources];
    [self balanceArmies];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishWAR" object:nil userInfo:@{@"resources":@(self.amountOfStolenResources),
                                                                                                     @"armyAttacking":self.attackingTroopsOriginal,
                                                                                                     @"armyReturning":self.attackingTroops,
                                                                                                     @"winner" : self.winner}];
}

- (void)balanceResources {
    [[BDPlayer currentPlayer] currentTown].gold += self.amountOfStolenResources;
    [[BDPlayer currentPlayer] currentTown].wood += self.amountOfStolenResources;
    [[BDPlayer currentPlayer] currentTown].iron += self.amountOfStolenResources;
    
    [[BDPlayer adversaryPlayer] currentTown].gold -= self.amountOfStolenResources;
    [[BDPlayer adversaryPlayer] currentTown].wood -= self.amountOfStolenResources;
    [[BDPlayer adversaryPlayer] currentTown].iron -= self.amountOfStolenResources;
}

- (void)balanceArmies{
}

- (BDSquad *)randomSquadFromArray:(NSArray *)array {
    NSMutableArray *filteredArray = [NSMutableArray array];
    for (BDSquad *squad in array) {
        if (squad.count) {
            [filteredArray addObject:squad];
        }
    }
    
    if (filteredArray.count) {
        NSInteger integer = arc4random_uniform((unsigned int )filteredArray.count - 1);
        return filteredArray[integer];
    }
    
    return nil;
}

@end



