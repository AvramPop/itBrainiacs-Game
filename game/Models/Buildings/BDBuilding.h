//
//  IBBuilding.h
//  game
//
//  Created by Bogdan Sala on 04/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BDProtoProduct.h"

@interface BDBuilding : SKSpriteNode <BDProtoProduct, NSCoding>

@property (nonatomic, assign) int uid;

@property (nonatomic, assign) int level;

@property (nonatomic, strong) NSMutableArray *protoProducts;

- (void)reactToTouch;
- (instancetype)initWithLevel:(int)level;
- (NSArray *)protoProductsNames;

@end
