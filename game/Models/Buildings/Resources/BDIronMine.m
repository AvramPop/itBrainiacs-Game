//
//  BDIronMine.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDIronMine.h"

@implementation BDIronMine

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"ironMine";
        BDProtoProduct *protoIron = [[BDProtoProduct alloc] init];
        protoIron.protoProductName = @"BDIron";
        protoIron.isResource = YES;
        self.protoProducts = [NSMutableArray arrayWithObject:protoIron];
    }
    return self;
}

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchIronMine" object:nil];
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {}

+ (BDProtoProduct *)upgradeProtoProduct {
    return nil;
}

- (NSArray *)protoProductsNames {
    return @[@"BDIron"];
}

@end
