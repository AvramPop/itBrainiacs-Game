//
//  BDHouse.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDHouse.h"
#import "BDBuildingInfoParser.h"
#import "BDPlayer.h"

@implementation BDHouse

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"house";
        
        BDProtoProduct *protoPeople = [[BDProtoProduct alloc] init];
        protoPeople.protoProductName = @"BDPeople";
        protoPeople.type = ProtoProductTypeResource;
        protoPeople.delegate = self;
        
        self.protoProducts = [NSMutableArray arrayWithObject:protoPeople];
        [self parse:[self getJsonDictionary]];
    }
    return self;
}

-(void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    if ([protoProduct.protoProductName isEqualToString:@"BDHouseUpgrade"]) {
        self.level++;
        [self parse:[self getJsonDictionary]];
        [[BDPlayer currentPlayer] currentTown].people += self.peopleProduced;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
    }
    [self.protoProducts removeObject:protoProduct];
}

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    NSArray *levels = dictionary[@"Level"];
    self.peopleProduced = [(NSNumber *)(levels[self.level][@"peopleProduced"]) intValue];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDHouseUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

@end
