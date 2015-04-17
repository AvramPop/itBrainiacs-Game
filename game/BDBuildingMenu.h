//
//  BDBuildingMenu.h
//  game
//
//  Created by Bogdan Sala on 20/03/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBuilding.h"

@protocol BDBuildingDelegate;

@interface BDBuildingMenu : UIView

@property (nonatomic, assign) id<BDBuildingDelegate> delegate;
@property (nonatomic, strong) BDBuilding            *building;

- (instancetype)initWithBuilding:(BDBuilding *)building andFrame:(CGRect)frame;

@end

@protocol BDBuildingDelegate

- (void)buildingMenu:(BDBuildingMenu *)menu didTouchUpdateButton:(UIButton *)button withConfirmationBlock:(void(^)())confBlock;
    
@end

