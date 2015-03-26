//
//  GameScene.h
//  game
//

//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TouchDetector.h"

@interface BDMap : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode* player;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, assign) CGSize tileSize;
@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) TouchDetector *touchDetector;

- (instancetype)initWithSize:(CGSize)aSize andBuildings:(NSMutableArray *)array;

- (void)prepareToAddNode:(SKSpriteNode *)addNode;

@end
