//
//  BDMapGestures.h
//  game
//
//  Created by Bogdan Sala on 24/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol BDMapGesturesDelegate;

@interface BDMapGestures : NSObject

extern NSString * const kAnimalNodeName;

@property (nonatomic, assign) id<BDMapGesturesDelegate> delegate;

- (instancetype)initWithMap:(SKScene *)map;

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer;
- (void)handleZoomFrom:(UIPinchGestureRecognizer *)recognizer;

@end


@protocol BDMapGesturesDelegate <NSObject>

- (SKSpriteNode *)backgroundNode;

@end