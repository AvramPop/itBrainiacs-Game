//
//  BDLightCavalery.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDLightCavalery.h"

@implementation BDLightCavalery

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"LightCavalery";
        self.imageName = @"lightcav";
    }
    return self;
}


+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDLightCavalery";
    return product;
}

@end
