//
//  UIButton+Block.m
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton_Block

- (void)setActionTouchUpInside:(void(^)())block {
    _actionTouchUpInside = block;
    [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)doTouchUpInside:(UIButton *)button {
    self.actionTouchUpInside();
}

@end
