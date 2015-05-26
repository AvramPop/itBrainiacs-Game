#import <Foundation/Foundation.h>

#import "BDUnit.h"
#import "BDPlayer.h"

@interface BDWarLogic : NSObject
///key ->BDUnit
///value ->NSNumber - (number of bdunit type)
@property(nonatomic, strong) NSArray                *attackingTroops;
@property(nonatomic, strong) NSArray                *defendingTroops;
@property(nonatomic, assign) NSInteger              amountOfStolenResources;
@property(nonatomic, strong) NSString               *winner;
@property(nonatomic, strong) BDPlayer	       	    *player;

- (instancetype)initWithAttackingTroops:(NSArray *)attacDictionary defendingTroops:(NSArray *)defDictionary;

@end