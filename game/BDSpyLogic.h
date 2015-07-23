#import <Foundation/Foundation.h>

#import "BDSpy.h"
#import "BDTown.h"

@interface BDSpyLogic : NSObject

- (instancetype)initWithAttackingSpies:(NSInteger *)numberOfAttackingSpies defendingSpies:(NSInteger *)numberOfDefendingSpies andDistance:(double)distance;

@end