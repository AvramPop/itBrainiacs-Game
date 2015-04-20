//
//  BDHouse.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDHouse.h"
#import "BDBuildingInfoParser.h"

@implementation BDHouse

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"house";
        BDProtoProduct *protoPeople = [[BDProtoProduct alloc] init];
        protoPeople.protoProductName = @"BDPeople";
        protoPeople.isResource = YES;
        self.protoProducts = [NSMutableArray arrayWithObject:protoPeople];
        [self parse:[self getJsonDictionary]];
    }
    return self;
}

- (NSArray *)protoProductsNames {
    return @[@"BDPeople"];
}

-(void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    
}

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    NSArray *levels = dictionary[@"Level"];
    self.peopleProduced = [(NSNumber *)(levels[self.level][@"popleProduced"]) intValue];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDHouseUpgrade";
    proto.isResource = NO;
    
    return proto;
}

@end
