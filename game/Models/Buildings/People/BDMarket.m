//
//  BDMarket.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMarket.h"

@implementation BDMarket

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"market";
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}
- (NSArray *)protoProductsNames {
    return @[@"",@"", @""];
}

- (NSString *)realName{
    return @"market";
}

@end
