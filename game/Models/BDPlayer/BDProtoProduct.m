//
//  BDProtoProduct.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDProtoProduct.h"

@implementation BDProtoProduct

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeStamp = [[NSDate alloc] init];
    }
    return self;
}

@end
