//
//  BDTown.h
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDPlayer.h"
#import <SpriteKit/SpriteKit.h>

typedef enum {
    BDTownTypeBarbarian,
    BDTownTypeHuman
} BDTownType;

@interface BDTown : SKSpriteNode

@property (nonatomic, strong) BDPlayer      *owner;
@property (nonatomic, assign) BDTownType    type;

- (instancetype)initWithPosition:(CGPoint)point imageName:(NSString *)imageName andType:(BDTownType)type;

@end