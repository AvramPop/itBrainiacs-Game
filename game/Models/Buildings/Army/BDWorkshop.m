//
//  BDWorkshop.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDWorkshop.h"
#import "BDPlayer.h"

@implementation BDWorkshop

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"workshop";
        [self parse:[self getJsonDictionary]];
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    if ([protoProduct.protoProductName isEqualToString:@"BDWorkshopUpgrade"]) {
        self.level++;
        [self parse:[self getJsonDictionary]];
    } else {
        [self runAction:[SKAction playSoundFileNamed:@"finished-unit.m4r" waitForCompletion:NO]];
        if ([protoProduct.protoProductName isEqualToString:@"BDRam"]){
            [[BDPlayer currentPlayer] currentTown].ramCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDBaloon"]){
            [[BDPlayer currentPlayer] currentTown].baloonCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDCatapult"]){
            [[BDPlayer currentPlayer] currentTown].catapultCount++;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
    [self.protoProducts removeObject:protoProduct];
}


+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDWorkshopUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;}

@end
