//
//  BDBaracks.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBaracks.h"

@implementation BDBaracks

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchBarracksMenu" object:nil];
}

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"barracks";
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)protoProductsNames {
   return @[@"",@"", @""];
}

+ (BDProtoProduct *)upgradeProtoProduct {
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDBaracksUpgrade";
    proto.isResource = NO;
    
    return proto;
}

@end
