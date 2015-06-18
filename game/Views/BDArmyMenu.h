//
//  BDArmyMenu.h
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDPlayer.h"

@interface BDArmyMenu : UIView

@property(nonatomic, strong) BDPlayer *player;
@property(nonatomic, strong) UIButton *questButton;
@property(nonatomic, strong) UIButton *warButton;

@property (nonatomic, strong) UINavigationController *controller;

- (instancetype)initWithFrame:(CGRect)frame andPlayer:(BDPlayer *)player;

@end
