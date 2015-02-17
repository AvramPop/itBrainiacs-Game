//
//  IBBuilding.h
//  game
//
//  Created by Bogdan Sala on 04/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BDBuilding : SKSpriteNode

@property (nonatomic, assign) int uid;

@property (nonatomic, assign) int level;


- (void)reactToTouch;
- (instancetype)initWithLevel:(int) level;

@end
