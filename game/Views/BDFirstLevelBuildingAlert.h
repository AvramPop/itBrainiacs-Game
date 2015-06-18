//
//  BDFirstLevelBuildingAlert.h
//  game
//
//  Created by Bogdan Sala on 17/06/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBuilding.h"

@protocol BDFirstLevelBuildingAlertDelegate <NSObject>

- (void)didAcceptWithResponse:(BOOL)response creationForBuilding:(BDBuilding *)building;

@end

@interface BDFirstLevelBuildingAlert : UIView

@property (nonatomic, strong) BDBuilding *building;
@property (nonatomic, strong) UIButton   *yesButton;
@property (nonatomic, strong) UIButton   *noButton;
@property (nonatomic, assign) BOOL       isCheckedYesButton;

@property (nonatomic, assign) id<BDFirstLevelBuildingAlertDelegate>   delegate;

- (instancetype)initWithFrame:(CGRect)frame andBuilding:(BDBuilding *)building;

@end
