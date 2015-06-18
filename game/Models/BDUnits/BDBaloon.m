//
//  BDBaloon.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBaloon.h"

@implementation BDBaloon

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Baloon";
        self.imageName = @"baloon";
    }
    return self;
}

+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDBaloon";
    return product;
}

@end
