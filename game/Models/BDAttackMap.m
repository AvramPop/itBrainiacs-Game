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
            [self populateMapWithTownsWithSize:totalSize];
        } else {
            self.cachedTowns = array;
        }
        self.backgroundSize = totalSize;
        self.mapGestures = [[BDMapGestures alloc] initWithMap:self];
        self.mapGestures.delegate = self;
        self.mapGestures.enableObjectsDragging = NO;
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
    [self.mapGestures setZoomToMax];
}

- (void)addTown:(BDTown *)town {
    [town removeFromParent];
    [self.background addChild:town];
    town.userInteractionEnabled = YES;

}

- (SKSpriteNode *)backgroundNode {
    return self.background;
}

- (void)populateMapWithTownsWithSize:(CGSize)aSize {
    self.cachedTowns = [NSMutableArray array];
    for (BDTown *town in [BDPlayer currentPlayer].arrayOfTowns) {
        [self.cachedTowns addObject:town];
    }
    //aici le generezi trebuie sa le adaugi pe harta acum
    for(int i = 0; i < 10; i++){
        NSInteger x, y;
        x = [self randomFloatBetween:aSize.width/5.0 and:aSize.width*4.0/5.0];
        y = [self randomFloatBetween:aSize.height/5.0 and:aSize.height*4.0/5.0];
       
        BDPlayer *player = [[BDPlayer alloc] init];
        player.name = [NSString stringWithFormat:@"Barbarian%d", arc4random_uniform(1000)];
        BDTown *town = [[BDTown alloc] initWithPosition:CGPointMake(x, y) imageName:@"BarbarianTownHall1" andType:BDTownTypeBarbarian];
        town.name = [NSString stringWithFormat:@"BarbarianTown(%ld, %ld)", x, y];
        player.arrayOfTowns = @[town];
        town.owner = player;
//        player.swordsmanCount = arc4random_uniform(i*20);
//        player.axemanCount = arc4random_uniform(i*20);
//        player.archerCount = arc4random_uniform(i*20);
//        player.wizardCount = arc4random_uniform(i*20);
//        player.spyCount = arc4random_uniform(i*20);
//        player.lightCavaleryCount = arc4random_uniform(i*20);
//        player.highCavaleryCount = arc4random_uniform(i*20);
//        player.archerCount = arc4random_uniform(i*20);
//        player.ramCount = arc4random_uniform(i*20);
//        player.baloonCount = arc4random_uniform(i*20);
//        player.catapultCount = arc4random_uniform(i*20);
        [player currentTown].swordsmanCount = arc4random_uniform(5);
        [player currentTown].gold = 1000;
        [player currentTown].iron = 1000;
        [player currentTown].wood = 1000;

        [self.cachedTowns addObject:town];
    }
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@end