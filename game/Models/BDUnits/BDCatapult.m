//
//  BDCatapult.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDCatapult.h"

@implementation BDCatapult

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Catapult";
        self.imageName = @"catapult";
    }
    return self;
}

+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDCatapult";
    return product;
}

@end
