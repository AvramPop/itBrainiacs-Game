//
//  BDGameLogicController.m
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDGameLogicController.h"
#import "BDBuilding.h"
#import "BDProtoProduct.h"
#import "BDPlayer.h"
#import "BDBuilding.h"
#import "BDHeadquarters.h"
#import "BDHouse.h"

#import "BDGoldMine.h"
#import "BDIronMine.h"
#import "BDWoodCamp.h"

#import "BDStable.h"

@interface BDGameLogicController()

@property (nonatomic, assign) NSTimeInterval timeToUptade;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) BDMap *map;

@property (nonatomic, assign) BOOL isTimeToSave;

@end

@implementation BDGameLogicController

- (instancetype)initWithMap:(BDMap *)map {
    self = [super init];
    if(self){
        self.timeToUptade = 1;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeToUptade target:self selector:@selector(checkTimer:) userInfo:nil repeats:YES];
        [self.timer fire];
        self.map = map;
    }
    return self;
}

- (void)checkTimer:(NSTimer *)timer{
    NSDate *date = [[NSDate alloc] init];
    NSArray *buildings = self.map.town.buildings;
    BOOL hasResourcesUpdate = NO;
    for (BDBuilding *BDB in buildings) {
        NSArray *protoProducts = BDB.protoProducts;
        for (BDProtoProduct *proto in protoProducts) {
            BDProtoProduct *product = [BDProtoProduct protoProductWithProtoProduct:proto];
            if ([date compare:product.timeStamp] == NSOrderedDescending) {
                if (product.type == ProtoProductTypeResource) {
                    hasResourcesUpdate = YES;
                    double addedValue;
                    if ([product.protoProductName compare:@"BDGold"] == NSOrderedSame) {
                        addedValue = ((BDGoldMine *)product.delegate).productionPerHour/(3600.0/self.timeToUptade);
                        [[BDPlayer currentPlayer] currentTown].gold += addedValue;
                    } else if ([product.protoProductName compare:@"BDIron"] == NSOrderedSame) {
                        addedValue = ((BDIronMine *)product.delegate).productionPerHour/(3600.0/self.timeToUptade);
                        [[BDPlayer currentPlayer] currentTown].iron += addedValue;

                    } else if ([product.protoProductName compare:@"BDWood"] == NSOrderedSame) {
                        addedValue = ((BDWoodCamp *)product.delegate).productionPerHour/(3600.0/self.timeToUptade);
                        [[BDPlayer currentPlayer] currentTown].wood += addedValue;
                    }
                }
                [product.delegate didFinishCreatingProtoProduct:product];
            }
        }
    }
    
    if (hasResourcesUpdate) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateResourcesUI" object:nil];
    }
    
    [self saveInfo];
}

- (bool)hasEnoughResourcesFor:(BDBuilding *)building{
#ifdef DebugEnabled
    return YES;
#else
    return [[BDPlayer currentPlayer] currentTown].gold >= building.goldCost &&
    [[BDPlayer currentPlayer] currentTown].wood >= building.woodCost &&
    [[BDPlayer currentPlayer] currentTown].iron >= building.ironCost &&
    [[BDPlayer currentPlayer] currentTown].people >= building.peopleCost;
#endif
}

- (void)buildingMenu:(BDBuildingMenu *)menu didTouchUpdateButton:(UIButton *)button withConfirmationBlock:(void(^)())confBlock {
    
    if([self hasEnoughResourcesFor:menu.building] ) {
        [self.delegate gameLogicController:self requestUpdateForBuilding:menu.building withConfirmationBlock:^void{
            [[BDPlayer currentPlayer] currentTown].gold -= menu.building.goldCost;
            [[BDPlayer currentPlayer] currentTown].wood -= menu.building.woodCost;
            [[BDPlayer currentPlayer] currentTown].iron -= menu.building.ironCost;
            [[BDPlayer currentPlayer] currentTown].people -= menu.building.peopleCost;
            
            BDProtoProduct *proto = [menu.building.class upgradeProtoProduct];
            proto.delegate = menu.building;
            NSDate *mydate = [NSDate date];
            NSTimeInterval secondsInEightHours = menu.building.timeCost;
            NSDate *dateEightHoursAhead = [mydate dateByAddingTimeInterval:secondsInEightHours];
            proto.timeStamp = dateEightHoursAhead;
            [menu.building.protoProducts addObject:proto];
            confBlock();
        }];
    } else {
        [self.delegate gameLogicController:self notEnoughResourcesForBuilding:menu.building];
    }
}

- (void)didFinishAddingBuilding:(BDBuilding *)building toMap:(BDMap *)map {
    if ([building isKindOfClass:[BDHouse class]]) {
        [[BDPlayer currentPlayer] currentTown].people += ((BDHouse *)building).peopleProduced;
    }
    [BDPlayer currentPlayer].points += building.points;
}

- (void)saveInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *buildingsData = [NSKeyedArchiver archivedDataWithRootObject:[BDPlayer currentPlayer]];
    [userDefaults setObject:buildingsData forKey:@"player"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

