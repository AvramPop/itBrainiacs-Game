//
//  BDTown.m
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDTown.h"

@interface BDTown()

@end

@implementation BDTown

- (instancetype)initWithPosition:(CGPoint)point imageName:(NSString *)imageName andType:(BDTownType)type {
    self = [super initWithImageNamed:imageName];
    if (self) {
        self.type = type;
        self.position = point;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"townWasTouched" object:nil userInfo:@{@"town" : self}];
}

@end