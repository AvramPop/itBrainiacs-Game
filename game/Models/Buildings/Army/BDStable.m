//
//  BDStable.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDStable.h"
#import "BDPlayer.h"
#import "BDTown.h"

@implementation BDStable

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"stable";
        [self parse:[self getJsonDictionary]];
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    if ([protoProduct.protoProductName isEqualToString:@"BDStableUpgrade"]) {
        self.level++;
        [self parse:[self getJsonDictionary]];
    } else {
        [self runAction:[SKAction playSoundFileNamed:@"finished-unit.m4r" waitForCompletion:NO]];
        if ([protoProduct.protoProductName isEqualToString:@"BDLightCavalery"]){
            [[BDPlayer currentPlayer] currentTown].lightCavaleryCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDSpy"]){
            [[BDPlayer currentPlayer] currentTown].spyCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDHighCavalery"]){
            [[BDPlayer currentPlayer] currentTown].highCavaleryCount++;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
    [self.protoProducts removeObject:protoProduct];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDStableUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}


@end
