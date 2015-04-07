//
//  BDGameLogicController.h
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDMap.h"
#import "BDBuildingMenu.h"

@class BDBuilding;
@protocol  BDGameLogicControllerDelegate;

@interface BDGameLogicController : NSObject <BDBuildingDelegate>

@property (nonatomic, assign) id<BDGameLogicControllerDelegate> delegate;

-(instancetype)initWithMap:(BDMap *)map;

@end

@protocol  BDGameLogicControllerDelegate <NSObject>

- (void)gameLogicController:(BDGameLogicController *)gameLogicController requestUpdateForBuilding:(BDBuilding *)building withConfirmationBlock:(void(^)())block;
- (void)gameLogicController:(BDGameLogicController *)gameLogicController notEnoughResourcesForBuilding:(BDBuilding *)building;

@end