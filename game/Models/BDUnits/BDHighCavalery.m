//
//  BDHighCavalery.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDHighCavalery.h"

@implementation BDHighCavalery

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"HighCavalery";
        self.imageName = @"heavycav";
    }
    return self;
}

+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDHighCavalery";
    return product;
}

@end
