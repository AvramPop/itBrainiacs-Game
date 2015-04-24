//
//  BDAttackMenu.h
//  game
//
//  Created by Bogdan Sala on 24/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDUnit.h"
#import "BDWarLogic.h"

@interface BDAttackMenu : UIView

@property (nonatomic, strong) NSDictionary  *attackingTroops;

- (instancetype)initWithTroops:(NSDictionary *)troops andFrame:(CGRect)frame andTargetPlayer:(BDPlayer *)target andTargetTown(BDTown *)town;

@end

@protocol 
    /**/
@end

