//
//  BDWorkshop.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDWorkshop.h"

@implementation BDWorkshop

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"workshop";
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)protoProductsNames {
    return @[@"",@"", @""];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDWorkshopUpgrade";
    proto.isResource = NO;
    
    return proto;}

@end
