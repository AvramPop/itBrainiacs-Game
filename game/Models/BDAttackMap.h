//
//  BDAttackMap.h
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "BDTown.h"

@interface BDAttackMap : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) BDPlayer                      *player;
@property (nonatomic, strong) NSMutableArray                *towns;
@property (nonatomic, assign) CGSize                        backgroundSize;

- (instancetype)initWithSize:(CGSize)aSize andTowns:(NSMutableArray *)array sceneSize:(CGSize)totalSize;

@end
