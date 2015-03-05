//
//  BDBaracks.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBaracks.h"

@implementation BDBaracks

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchBarracksMenu" object:nil];
}

- (NSArray *)protoProductsNames {
   return @[@"",@"", @""];
}

@end
