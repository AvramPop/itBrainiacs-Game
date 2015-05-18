//
//  BDStable.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDStable.h"
#import "BDPlayer.h"

@implementation BDStable

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"stable";
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)protoProductsNames {
    return @[@"",@"", @""];
}


- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    [self.protoProducts removeObject:protoProduct];
    [BDPlayer currentPlayer].swordsmanCount++;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateBuildingUI" object:nil userInfo:@{@"BDProtoProduct":protoProduct}];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDStableUpgrade";
    proto.isResource = NO;
    
    return proto;
}


@end
