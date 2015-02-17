//
//  BDHeadquarters.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDHeadquarters.h"

@implementation BDHeadquarters

- (instancetype)init {
    self = [super initWithImageNamed:@"Headquarters1"];
    if (self) {
        self.name = @"headquarters";
    }
    return self;
}

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchHeadQuartersMenu" object:nil];
}

@end
