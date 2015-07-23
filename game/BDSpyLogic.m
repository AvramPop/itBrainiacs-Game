#import "BDSpyLogc.h"

@interface BDSpyLogc ()

@property(nonatomic, assign) NSInteger numberOfAttackingSpies;
@property(nonatomic, assign) NSInteger numberOfDefendingSpies;

@end

@implementation BDSpyLogc

- (instancetype)initWithAttackingSpies:(NSInteger *)numberOfAttackingSpies defendingSpies:(NSInteger *)numberOfDefendingSpies andDistance:(double)distance {
    self = [super init];
    if (self) {
        self.numberOfAttackingSpies = numberOfAttackingSpies;
        self.numberOfDefendingSpies = numberOfDefendingSpies;
    }
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeOfTravel] target:self selector:@selector(attack) userInfo:nil repeats: NO];
    [myTimer fire];
    
    return self;
}

- (void)attack {
    
}

- (NSInteger)timeOfTravel{
    return /*speed of spies*/;
}

- (void)balanceArmies{

}

@end



