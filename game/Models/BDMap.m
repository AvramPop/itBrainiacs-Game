//
//  GameScene.m
//  game
//
//  Created by Bogdan Sala on 29/01/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMap.h"
#import "BDBuilding.h"

@interface BDMap()

@property (nonatomic, strong) SKSpriteNode *addedNode;

@end


@implementation BDMap


- (void)prepareToAddNode:(SKSpriteNode *)addNode {
    self.addedNode = addNode;
}

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:1.0 blue:0.2 alpha:1.0];
        
        int tileHeight = 44;
        int tileWidth = 57;
        self.tileSize = CGSizeMake(tileWidth, tileHeight);
        
        self.touchDetector = [[TouchDetector alloc] initWithScreenSize:size  andTileSize:self.tileSize];
        self.physicsWorld.contactDelegate = self;
        self.buildings = [NSMutableArray array];
        
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:backgroundImage]];
    background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    background.zPosition = -1;
    [self addChild:background];

}

- (void)addBuilding:(BDBuilding *)building {
    int uid = building.uid;
    CGPoint tileScreenCoordinate = [self getTileCoordonateFromId:uid];
    building.position = tileScreenCoordinate;
    [self addChild:building];
    [self.buildings addObject:building];
    

}

- (CGPoint)getTileCoordonateFromId:(int)uid {
    int i = 0;

    int tileHeight = self.tileSize.height;
    int tileWidth = self.tileSize.width;
    
    for (int y = - tileHeight / 2; y <= self.view.frame.size.height; y = y + tileHeight / 2) {
        for (int x = (y % tileHeight == 0 ? 0 : -tileWidth / 2); x < self.view.frame.size.width; x = x + tileWidth) {
            if (uid == i) {
                return CGPointMake(x+tileWidth/2, y+tileHeight/4);
            }
            i++;
        }
    }
    return CGPointMake(0, 0);
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if (self.addedNode) {
        BDBuilding *building = (BDBuilding *)self.addedNode;
        building.uid = [self.touchDetector getTileIdAtPosition:location];
        if (!building.name) {
            building.name = [NSString stringWithFormat:@"thisIsMySprite%d", building.uid]; // set the name for your sprite
        }
        building.userInteractionEnabled = YES;
        
        [self addBuilding:building];
        self.addedNode = nil;
    } else {
        SKNode *node = [self nodeAtPoint:location];
        if (node) {
            NSLog(@"%@", node.name);
        }
    }
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    NSLog(@"Hit");
    [projectile removeFromParent];
    [monster removeFromParent];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
}

@end
