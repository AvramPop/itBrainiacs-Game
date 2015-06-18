//
//  BDRam.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDRam.h"

@implementation BDRam

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Ram";
        self.imageName = @"ram";
    }
    return self;
}


+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDRam";
    return product;
}

@end
