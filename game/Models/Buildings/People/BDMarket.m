//
//  BDMarket.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMarket.h"

@implementation BDMarket

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"market";
        
        BDProtoProduct *protoMerchants = [[BDProtoProduct alloc] init];
        protoPeople.protoProductName = @"BDMerchants";
        protoPeople.type = ProtoProductTypeResource;
        protoPeople.delegate = self;
        
        self.protoProducts = [NSMutableArray arrayWithObject:protoMerchants];
        [self parse:[self getJsonDictionary]];
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDMarketUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    NSArray *levels = dictionary[@"Level"];
    self.merchantsProduced = [(NSNumber *)(levels[self.level][@"merchantsProduced"]) intValue];
}

@end
