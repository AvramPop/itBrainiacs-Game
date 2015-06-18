//
//  BDWizard.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDWizard.h"

@implementation BDWizard

- (instancetype)init{
    self = [super init];
    if(self){
        self.name = @"Wizard";
        self.imageName = @"wizard";
    }
    return self;
}


+ (BDProtoProduct *)protoProduct {
    BDProtoProduct *product = [[BDProtoProduct alloc] init];
    product.protoProductName = @"BDWizzard";
    return product;
}

@end
