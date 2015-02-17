//
//  TouchDetector.h
//  GameTest
//
//  Created by Bogdan Sala on 23/12/14.
//  Copyright (c) 2014 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchDetector : NSObject

- (instancetype)initWithScreenSize:(CGSize)screenSize andTileSize:(CGSize)tileSize;
- (int)getTileIdAtPosition:(CGPoint)position;

@end
