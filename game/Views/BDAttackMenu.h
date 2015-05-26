//
//  BDAttackMenu.h
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDPlayer.h"
#import "BDTown.h"

@interface BDAttackMenu : UIView

- (instancetype)initWithPlayer:(BDPlayer *)player andFrame:(CGRect)frame andTargetTown:(BDTown *)town;

@end
