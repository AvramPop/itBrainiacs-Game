//
//  BDWall.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDWall.h"

@implementation BDWall


- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"wall";
        [self parse:[self getJsonDictionary]];
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDWallUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

@end
