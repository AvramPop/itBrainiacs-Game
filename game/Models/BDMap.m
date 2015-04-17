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
@property (nonatomic, assign) NSArray *cacheBuild;

@end


@implementation BDMap

- (instancetype)initWithSize:(CGSize)aSize andBuildings:(NSMutableArray *)array {
    self = [self initWithSize:aSize];
    if (self) {
        self.cacheBuild = array;
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
    building.zPosition = 10;
    [self addChild:building];
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

-(void)didMoveToView:(SKView *)view {
    UIImage *image = [self steachBackgroundImagesForOrientation:UIInterfaceOrientationPortrait];
    self.backgroundImage = image;
    for (BDBuilding *building in self.cacheBuild) {
        [self addBuilding:building];
    }
}

- (UIImage *)steachBackgroundImagesForOrientation:(UIInterfaceOrientation)orientation {
    
    int x, y;
    UIImage *tile1 = [UIImage imageNamed:@"tileset1.png"];
    UIImage *tile2 = [UIImage imageNamed:@"tileset2.png"];
    
    self.tileSize = tile1.size;
    
    int tileWidth = self.tileSize.width;
    int tileHeight = self.tileSize.height;
    
    UIImage *finalImage = [[UIImage alloc] init];
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 CGRectGetWidth(self.view.frame),
                                                 CGRectGetHeight(self.view.frame),
                                                 CGImageGetBitsPerComponent(tile1.CGImage),
                                                 0, //auto computed
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    int i = 0;
    
#ifdef TouchDebug
    UIFont *helvetica11 = [UIFont fontWithName:@"Helvetica" size:9];
#endif
    for (y = - tileHeight / 2; y <= self.view.frame.size.height; y = y + tileHeight / 2) {
        for (x = (y % tileHeight == 0 ? 0 : -tileWidth / 2); x < self.view.frame.size.width; x = x + tileWidth) {
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

- (UIImage *)drawText:(NSString *)text withFont:(UIFont *)font inImage:(UIImage*)image {
    //initialize the text randering context variables (text size, font, frame, alignment)
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName:font,
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    CGSize size = [text sizeWithAttributes:attributes];
    CGRect textRect = CGRectMake(frame.origin.x + floorf((frame.size.width - size.width) / 1.5),
                                 frame.origin.y + floorf((frame.size.height - size.height) / 4),
                                 size.width,
                                 size.height);
    //render image in context after that rander text => text on image
    UIGraphicsBeginImageContext(frame.size);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), true);
    [image drawInRect:CGRectMake(0,0,frame.size.width,frame.size.height)];
    [text drawInRect:textRect withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
