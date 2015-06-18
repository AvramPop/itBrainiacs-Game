//
//  BDWoodCamp.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDWoodCamp.h"

@implementation BDWoodCamp

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"woodCamp";
        BDProtoProduct *protoWood = [[BDProtoProduct alloc] init];
        protoWood.protoProductName = @"BDWood";
        protoWood.type = ProtoProductTypeResource;
        protoWood.delegate = self;
        
        [self parse:[self getJsonDictionary]];

        self.protoProducts = [NSMutableArray arrayWithObject:protoWood];
    }
    return self;
}

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchWoodCamp" object:nil];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.productionPerHour forKey:@"productionPerHour"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    self.productionPerHour = [aDecoder decodeIntegerForKey:@"productionPerHour"];
    
    return self;
}

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    NSArray *levels = dictionary[@"Level"];
    self.productionPerHour = [(NSNumber *)(levels[self.level][@"productionPerHour"]) intValue];
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    if ([protoProduct.protoProductName isEqualToString:@"BDWoodCampUpgrade"]) {
        self.level++;
        [self parse:[self getJsonDictionary]];
        [self.protoProducts removeObject:protoProduct];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
    }
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDWoodCampUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

@end
