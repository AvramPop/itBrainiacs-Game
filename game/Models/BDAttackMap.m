//
//  BDAttackMap.m
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//
#import "BDMap.h"
#import "BDBuilding.h"
#import "BDMapGestures.h"
#import "BDAttackMap.h"
#import "BDPlayer.h"
#import "BDAttackMenu.h"

@interface BDAttackMap()<BDMapGesturesDelegate>

@property (nonatomic, strong) SKSpriteNode      *addedNode;
@property (nonatomic, strong) NSMutableArray    *cachedTowns;
@property (nonatomic, strong) SKSpriteNode      *background;
@property (nonatomic, strong) BDMapGestures     *mapGestures;

@end

@implementation BDAttackMap

- (instancetype)initWithSize:(CGSize)aSize andTowns:(NSMutableArray *)array sceneSize:(CGSize)totalSize {
    self = [self initWithSize:aSize];
    if (self) {
        if(!array || ![array count]){
            [self populateMapWithTowns];
        } else {
            self.cachedTowns = array;
        }
        self.backgroundSize = totalSize;
        self.mapGestures = [[BDMapGestures alloc] initWithMap:self];
        self.mapGestures.delegate = self;
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    NSError *err = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"mapBackground.png"];
    NSData *data = [NSData dataWithContentsOfFile:filePath
                                          options:NSDataReadingUncached
                                            error:&err];
    UIImage *image = [UIImage imageWithData:data];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:image]];
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:_mapGestures action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:_mapGestures action:@selector(handleZoomFrom:)];
    [[self view] addGestureRecognizer:pinchGestureRecognizer];
    
    [background setAnchorPoint:CGPointZero];
    background.name = kAnimalNodeName;
    background.zPosition = -1;
    
    [self addChild:background];
    
    self.background = background;
    
    for (BDTown *building in self.cachedTowns) {
        [self addTown:building];
    }
}

- (void)addTown:(BDTown *)town {
    [self.background addChild:town];
    town.userInteractionEnabled = YES;

}

- (SKSpriteNode *)backgroundNode {
    return self.background;
}

- (void)openAttackMenuForTown:(BDTown *)town{
    BDAttackMenu *menu = [[BDAttackMenu alloc] initWithPlayer:self.player andFrame:CGRectMake(100, 100, self.frame.size.width - 200, self.frame.size.height - 200) andTargetTown:town];
    //sa pui culoare la attackMenu!!!!
}

- (void)populateMapWithTowns {
    self.cachedTowns = [NSMutableArray array];
    //aici le generezi trebuie sa le adaugi pe harta acum
    for(int i = 0; i < 10; i++){
        NSInteger x, y;
        x = arc4random_uniform(1000);
        y = arc4random_uniform(1000);
        
        BDPlayer *player = [[BDPlayer alloc] init];
        player.swordsmanCount = arc4random_uniform(i*20);
        player.axemanCount = arc4random_uniform(i*20);
        player.archerCount = arc4random_uniform(i*20);
        player.wizardCount = arc4random_uniform(i*20);
        player.spyCount = arc4random_uniform(i*20);
        player.lightCavaleryCount = arc4random_uniform(i*20);
        player.highCavaleryCount = arc4random_uniform(i*20);
        player.archerCount = arc4random_uniform(i*20);
        player.ramCount = arc4random_uniform(i*20);
        player.baloonCount = arc4random_uniform(i*20);
        player.catapultCount = arc4random_uniform(i*20);

        BDTown *town = [[BDTown alloc] initWithPosition:CGPointMake(x, y) imageName:@"Headquarters1" andType:BDTownTypeBarbarian];
        town.owner = player;
        [self.cachedTowns addObject:town];
    }
}

@end