//
//  BDUnitInfo.m
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDUnitInfo.h"

@implementation BDUnitInfo

- (instancetype)initWithFrame:(CGRect)frame andUnit:(BDUnit *)unit {
    self = [super initWithFrame:frame];
    if (self) {
        self.unit = unit;
    }
    return self;
}

@end
