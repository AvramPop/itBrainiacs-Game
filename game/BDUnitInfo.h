//
//  BDUnitInfo.h
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDUnit.h"

@interface BDUnitInfo : UIView

@property (nonatomic, strong) BDUnit *unit;

- (instancetype)initWithFrame:(CGRect)frame andUnit:(BDUnit *)unit;

@end
