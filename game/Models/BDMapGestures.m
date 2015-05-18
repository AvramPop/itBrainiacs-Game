//
//  BDMapGestures.m
//  game
//
//  Created by Bogdan Sala on 24/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMapGestures.h"

@interface BDMapGestures()

@property (nonatomic, strong) SKScene *mapScene;
@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end

@implementation BDMapGestures

NSString * const kAnimalNodeName = @"notMovable";

- (instancetype)initWithMap:(SKScene *)map {
    self = [super init];
    if (self) {
        self.mapScene = map;
    }
    
    return self;
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self.mapScene convertPointFromView:touchLocation];
        [self selectNodeForTouch:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([[self.selectedNode name] isEqualToString:kAnimalNodeName]) {
            float scrollDuration = 0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint pos = [self.selectedNode position];
            CGPoint p = CGPointMake(velocity.x * scrollDuration, -velocity.y * scrollDuration);
            
            CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
            newPos = [self boundLayerPos:newPos];
            [self.selectedNode removeAllActions];
            
            SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
            [moveTo setTimingMode:SKActionTimingEaseInEaseOut];
            [self.selectedNode runAction:moveTo];
        }
    }
}

- (void)handleZoomFrom:(UIPinchGestureRecognizer *)recognizer {
    SKSpriteNode *background = [self.delegate backgroundNode];
    
    CGPoint anchorPoint = [recognizer locationInView:recognizer.view];
    anchorPoint = [self.mapScene convertPointFromView:anchorPoint];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        // No code needed for zooming...
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint anchorPointInMySkNode = [background convertPoint:anchorPoint fromNode:self.mapScene];
        CGFloat scale = background.xScale * recognizer.scale;
        
        scale = MAX(0.55, scale);
        scale = MIN(2, scale);
        
        [background setScale:scale];
        
        CGPoint mySkNodeAnchorPointInScene = [self.mapScene convertPoint:anchorPointInMySkNode fromNode:background];
        CGPoint translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene);
        
        background.position = [self boundLayerPos:CGPointAdd(background.position, translationOfAnchorInScene)];
        recognizer.scale = 1.0;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        // No code needed for zooming...
        //here we should make the animation
    }
}


- (void)panForTranslation:(CGPoint)translation {
    
    CGPoint position = [self.selectedNode position];
    if([[self.selectedNode name] isEqualToString:kAnimalNodeName]) {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [[self.delegate backgroundNode] setPosition:[self boundLayerPos:newPos]];
    } else {
        [self.selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    SKSpriteNode *background =[self.delegate backgroundNode];

    CGSize winSize = self.mapScene.size;
    CGPoint retval = newPos;
    
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -background.size.width + winSize.width);
    retval.y = MIN(retval.y, 0);
    retval.y = MAX(retval.y, -background.size.height + winSize.height);
    
    return retval;
}

#pragma mark - animations 

- (void)selectNodeForTouch:(CGPoint)touchLocation {

    SKSpriteNode *touchedNode = (SKSpriteNode *)[self.mapScene nodeAtPoint:touchLocation];
    if(![self.selectedNode isEqual:touchedNode]) {
        [self.selectedNode removeAllActions];
        [self.selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
        self.selectedNode = touchedNode;
        if(![[touchedNode name] isEqualToString:kAnimalNodeName]) {
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
                                                      [SKAction rotateByAngle:0.0 duration:0.1],
                                                      [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
            [self.selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
    }
}

#pragma mark - helper

CGPoint mult(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x * s, v.y * s);
}

CGPoint CGPointAdd(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

CGPoint CGPointSubtract(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

float degToRad(float degree) {
    return degree / 180.0f * M_PI;
}

@end
