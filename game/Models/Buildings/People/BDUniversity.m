//
//  BDUniversity.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDUniversity.h"

@implementation BDUniversity

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"university";
        self.protoProducts = [NSMutableArray array];
        [self parse:[self getJsonDictionary]];
    }
    return self;
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDUniversityUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

@end
