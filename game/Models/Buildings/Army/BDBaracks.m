//
//  BDBaracks.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBaracks.h"
#import "BDPlayer.h"

@implementation BDBaracks


- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"barracks";
        [self parse:[self getJsonDictionary]];
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchBarracksMenu" object:nil];
}


- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    if ([protoProduct.protoProductName isEqualToString:@"BDBaracksUpgrade"]) {
        self.level++;
        [self parse:[self getJsonDictionary]];
    } else {
        [self runAction:[SKAction playSoundFileNamed:@"finished-unit.m4r" waitForCompletion:NO]];
       if ([protoProduct.protoProductName isEqualToString:@"BDSwordsman"]){
            [[BDPlayer currentPlayer] currentTown].swordsmanCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDAxeman"]){
            [[BDPlayer currentPlayer] currentTown].axemanCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDArcher"]){
            [[BDPlayer currentPlayer] currentTown].archerCount++;
        } else if ([protoProduct.protoProductName isEqualToString:@"BDWizard"]){
            [[BDPlayer currentPlayer] currentTown].wizardCount++;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
    [self.protoProducts removeObject:protoProduct];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDBaracksUpgrade";
    proto.type = ProtoProductTypeUpgrade;
    
    return proto;
}

@end
