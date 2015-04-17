//
//  GameScene.h
//  game
//

//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TouchDetector.h"

@protocol BDMapProtocol;
@class BDBuilding;

@interface BDMap : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode* player;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, assign) CGSize tileSize;
@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) TouchDetector *touchDetector;
@property (nonatomic, strong) id<BDMapProtocol> mapDelegate;


- (instancetype)initWithSize:(CGSize)aSize andBuildings:(NSMutableArray *)array;

- (void)prepareToAddNode:(SKSpriteNode *)addNode;

@end


@protocol BDMapProtocol <NSObject>

- (void)didFinishAddingBuilding:(BDBuilding *)building toMap:(BDMap *)map;

@end
