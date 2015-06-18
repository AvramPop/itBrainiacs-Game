//
//  BDArcher.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDArcher.h"

@implementation BDArcher

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Archer";
        self.imageName = @"archer";
    }
    return self;
}

+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDArcher";
    return product;
}

@end
