//
//  GameScene.m
//  game
//
//  Created by Bogdan Sala on 29/01/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMap.h"
#import "BDBuilding.h"
#import "BDMapGestures.h"

@interface BDMap() <BDMapGesturesDelegate>

@property (nonatomic, strong) SKSpriteNode *addedNode;
@property (nonatomic, assign) NSArray      *cacheBuild;
@property (nonatomic, strong) SKSpriteNode *background;


@property (nonatomic, strong) BDMapGestures *mapGestures;
@end

@implementation BDMap


- (instancetype)initWithSize:(CGSize)aSize andBuildings:(NSMutableArray *)array sceneSize:(CGSize)totalSize {
    self = [self initWithSize:aSize];
    if (self) {
        self.cacheBuild = array;
        self.backgroundSize = totalSize;
    }
    return self;
}

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
        self.mapGestures = [[BDMapGestures alloc] initWithMap:self];
        self.mapGestures.delegate = self;
    }
    return self;
}

- (void)addBuilding:(BDBuilding *)building {
    int uid = building.uid;
    CGPoint tileScreenCoordinate = [self getTileCoordonateFromId:uid];
    building.position = tileScreenCoordinate;
    building.zPosition = 10;
    [self.background addChild:building];
    [self.buildings addObject:building];
    [self.mapDelegate didFinishAddingBuilding:building toMap:self];
}

- (CGPoint)getTileCoordonateFromId:(int)uid {
    int i = 0;

    int tileHeight = 44;
    int tileWidth = 57;
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    for (int y = - tileHeight / 2; y <= height; y = y + tileHeight / 2) {
        for (int x = (y % tileHeight == 0 ? 0 : -tileWidth / 2); x < width; x = x + tileWidth) {
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

-(void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:_mapGestures action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:_mapGestures action:@selector(handleZoomFrom:)];
    [[self view] addGestureRecognizer:pinchGestureRecognizer];
    
    UIImage *image = [self steachBackgroundImages];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:image]];
    [background setAnchorPoint:CGPointZero];
    background.name = kAnimalNodeName;
    background.zPosition = -1;
    
    [self addChild:background];
    
    self.background = background;
        for (BDBuilding *building in self.cacheBuild) {
        [self addBuilding:building];
    }
}

- (UIImage *)steachBackgroundImages {
    
    int x, y;
    UIImage *tile1 = [UIImage imageNamed:@"tileset1.png"];
    UIImage *tile2 = [UIImage imageNamed:@"tileset2.png"];
    
    self.tileSize = tile1.size;
    
    int tileWidth = self.tileSize.width;
    int tileHeight = self.tileSize.height;
    
    UIImage *finalImage = [[UIImage alloc] init];
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 self.backgroundSize.width,
                                                 self.backgroundSize.height,
                                                 CGImageGetBitsPerComponent(tile1.CGImage),
                                                 0, //auto computed
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    int i = 0;
    
#ifdef TouchDebug
    UIFont *helvetica11 = [UIFont fontWithName:@"Helvetica" size:9];
#endif
    for (y = - tileHeight / 2; y <= self.backgroundSize.height; y = y + tileHeight / 2) {
        for (x = (y % tileHeight == 0 ? 0 : -tileWidth / 2); x < self.backgroundSize.width; x = x + tileWidth) {
            UIImage *currentImage;
            if (y % tileHeight == 0){
                currentImage = tile1;
            } else {
                currentImage = tile2;
            }
            CGRect frame = CGRectMake(x, y, tileWidth, tileHeight);
#ifdef TouchDebug
            if (currentImage == tile1) {
                currentImage = [self drawText:[NSString stringWithFormat:@"%d", i] withFont:helvetica11 inImage:currentImage];
            } else {
                currentImage = [self drawText:[NSString stringWithFormat:@"%d", i] withFont:helvetica11 inImage:currentImage];;
            }
#endif
            CGContextDrawImage(context, frame, currentImage.CGImage);
            i++;
        }
    }
    
    CGImageRef mergeResult  = CGBitmapContextCreateImage(context);
    finalImage = [[UIImage alloc] initWithCGImage:mergeResult];
    CGContextRelease(context);
    CGImageRelease(mergeResult);
    
    return finalImage;
    
}


- (SKSpriteNode *)backgroundNode {
    return self.background;
}

@end
