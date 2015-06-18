//
//  BDSwordsman.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDSwordsman.h"

@implementation BDSwordsman

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Swordsman";
        self.imageName = @"Barbarian1";
    }
    return self;
}


+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDSwordsman";
    return product;
}

@end
