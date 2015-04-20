//
//  BDGoldMine.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDGoldMine.h"

@implementation BDGoldMine

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"goldMine";
        BDProtoProduct *protoGold = [[BDProtoProduct alloc] init];
        protoGold.protoProductName = @"BDGold";
        protoGold.isResource = YES;
        [self.protoProducts addObject:protoGold];
    }
    return self;
}

- (void)reactToTouch {
    [super reactToTouch];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchGoldMine" object:nil];
}

-(void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    
}

+ (BDProtoProduct *)upgradeProtoProduct {
    return nil;
}

- (NSArray *)protoProductsNames {
    return @[@"BDGold"];
}

@end