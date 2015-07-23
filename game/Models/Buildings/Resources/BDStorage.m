//
//  BDStorage.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDStorage.h"
#import "BDBuildingInfoParser.h"
#import "BDTown.h"

@implementation BDStorage

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"storage";
        [self parse:[self getJsonDictionary]];
    }
    return self;
}

-(void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    if ([protoProduct.protoProductName isEqualToString:@"BDStorageUpgrade"]) {
        self.level++;

        [self parse:[self getJsonDictionary]];
        [BDPlayer currentPlayer] currentTown].resLimit += self.resLimit;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
    }
    [self.protoProducts removeObject:protoProduct];
}

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    NSArray *levels = dictionary[@"Level"];
    self.resLimit = [(NSNumber *)(levels[self.level][@"capacity"]) intValue];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDStorageUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

@end
