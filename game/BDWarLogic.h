#import <Foundation/Foundation.h>

#import "BDUnit.h"
#import "BDPlayer.h"

@interface BDWarLogic : NSObject

@property(nonatomic, strong) NSMutableDictionary   *attackingTroops;
@property(nonatomic, strong) NSMutableDictionary   *defendingTroops;
@property(nonatomic, assign) NSInteger              amountOfStolenResources;

- (instancetype)initWithAttackingTroops:(NSMutableDictionary *)attacDictionary defendingTroops:(NSMutableDictionary *)defDictionary;

@end