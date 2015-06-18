//
//  BDAxeman.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDAxeman.h"

@implementation BDAxeman

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Axeman";
        self.imageName = @"axeman";
    }
    return self;
}


+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDAxeman";
    return product;
}

@end
