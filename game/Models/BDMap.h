//
//  GameScene.h
//  game
//

//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BDTown.h"

@protocol BDMapProtocol;
@class BDBuilding;

@interface BDMap : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode      *player;
@property (nonatomic, assign) CGSize            tileSize;
@property (nonatomic, strong) BDTown            *town;
@property (nonatomic, strong) id<BDMapProtocol> mapDelegate;
@property (nonatomic, assign) CGSize            backgroundSize;

- (instancetype)initWithSize:(CGSize)aSize andTown:(BDTown *)town sceneSize:(CGSize)totalSize;


- (void)prepareToAddNode:(SKSpriteNode *)addNode;

@end


@protocol BDMapProtocol <NSObject>

- (void)didFinishAddingBuilding:(BDBuilding *)building toMap:(BDMap *)map;

@end
