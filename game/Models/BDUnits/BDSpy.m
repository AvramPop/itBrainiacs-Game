//
//  BDSpy.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDSpy.h"

@implementation BDSpy

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Spy";
        self.imageName = @"spy";
    }
    return self;
}


+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDSpy";
    return product;
}

@end
