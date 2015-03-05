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
        protoWood.isResource = YES;
        self.protoProducts = [NSMutableArray arrayWithObject:protoWood];
    }
    return self;
}

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchWoodCamp" object:nil];
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {}

- (NSArray *)protoProductsNames {
    return @[@"BDWood"];
}

@end
