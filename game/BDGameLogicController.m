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

@interface BDGameLogicController()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) BDMap *map;

@end

@implementation BDGameLogicController

- (instancetype)initWithMap:(BDMap *)map {
    self = [super init];
    if(self){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkTimer:) userInfo:nil repeats:YES];
        [self.timer fire];
        self.map = map;
    }
    return self;
}

- (void)checkTimer:(NSTimer *)timer{
    NSDate *date = [[NSDate alloc] init];
    NSArray *buildings = self.map.buildings;
    BOOL hasResourcesUpdate = NO;
    for (BDBuilding *BDB in buildings) {
        NSArray *protoProducts = [NSArray arrayWithArray:BDB.protoProducts];
        for (BDProtoProduct *product in protoProducts) {
            if ([date compare:product.timeStamp] == NSOrderedDescending) {
                if (product.isResource) {
                    hasResourcesUpdate = YES;
                    if ([product.protoProductName compare:@"BDGold"] == NSOrderedSame) {
                        [BDPlayer currentPlayer].gold++;
                    } else if ([product.protoProductName compare:@"BDIron"] == NSOrderedSame) {
                        [BDPlayer currentPlayer].iron++;
                    } else if ([product.protoProductName compare:@"BDWood"] == NSOrderedSame) {
                        [BDPlayer currentPlayer].wood++;
                    }
                } else {
                    if ([product.protoProductName compare:@"BDHeadquartersUpgrade"] == NSOrderedSame) {
                        //
                    }
                    //the product is not a resource is a unit or a building of something else.
                }
                [product.delegate didFinishCreatingProtoProduct:product];
            }
        }
    }
    
    if (hasResourcesUpdate) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateResourcesUI" object:nil];
    }
}

- (bool)hasEnoughResourcesFor:(BDBuilding *)building{
#ifdef DebugEnabled
    return YES;
#endif
    return [BDPlayer currentPlayer].gold >= building.goldCost &&
    [BDPlayer currentPlayer].wood >= building.woodCost &&
    [BDPlayer currentPlayer].iron >= building.ironCost &&
    [BDPlayer currentPlayer].people >= building.peopleCost;

}


- (void)buildingMenu:(BDBuildingMenu *)menu didTouchUpdateButton:(UIButton *)button withConfirmationBlock:(void(^)())confBlock {
    
    if([self hasEnoughResourcesFor:menu.building] ) {
        [self.delegate gameLogicController:self requestUpdateForBuilding:menu.building withConfirmationBlock:^void{
            [BDPlayer currentPlayer].gold -= menu.building.goldCost;
            [BDPlayer currentPlayer].wood -= menu.building.woodCost;
            [BDPlayer currentPlayer].iron -= menu.building.ironCost;
            [BDPlayer currentPlayer].people -= menu.building.peopleCost;
            
            BDProtoProduct *proto = [BDHeadquarters upgradeProtoProduct];
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
        [BDPlayer currentPlayer].people += ((BDHouse *)building).peopleProduced;
    }
}

@end

