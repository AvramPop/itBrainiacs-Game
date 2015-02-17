//
//  TouchDetector.m
//  GameTest
//
//  Created by Bogdan Sala on 23/12/14.
//  Copyright (c) 2014 Telenav. All rights reserved.
//

#import "TouchDetector.h"

typedef enum {
    UpLightRightStart,
    UpDarkRightStart,
    UpLightLeftStart,
    UpDarkLeftStart
} TileArragement;


@interface TouchDetector()

@property (nonatomic, assign) int numberOfInnerTiles;
@property (nonatomic, assign) int numberOfOuterTiles;
@property (nonatomic, assign) CGSize tileSize;
@property (nonatomic, assign) CGSize screenSize;

@end

@implementation TouchDetector

- (instancetype)initWithScreenSize:(CGSize)screenSize andTileSize:(CGSize)tileSize {
    self = [super init];
    if (self) {
        self.tileSize = tileSize;
        self.screenSize = screenSize;
        self.numberOfInnerTiles = (screenSize.width + tileSize.width/2) / tileSize.width + 1;
        self.numberOfOuterTiles = (screenSize.width / tileSize.width) + 1;
    }
    return self;
}

- (int)getTileIdAtPosition:(CGPoint)position {
    int indexOuterLayer = [self getIndexForOuterLayerFromPosition:position];
    int indexInnerLayer = [self getIndexForInnerLayerFromPosition:position];

    TileArragement tilesArrangement = [self getTilesArragement:position];

    CGFloat dx = [self touchPointValue:position relativToTileArrangement:tilesArrangement];
    
    switch (tilesArrangement) {
        case UpLightLeftStart:
        case UpLightRightStart:
            return (dx < 0) ? indexInnerLayer : indexOuterLayer;
            break;
        case UpDarkRightStart:
        case UpDarkLeftStart:
            return (dx < 0) ? indexOuterLayer : indexInnerLayer;
            break;
        default:
            return (dx < 0) ? indexOuterLayer : indexInnerLayer;
    }
}

- (int)getIndexForInnerLayerFromPosition:(CGPoint)position {
    int i = position.x / self.tileSize.width;
    int j = position.y / self.tileSize.height;
    
    int innerIndex = j * self.numberOfInnerTiles + i + 1 + (j + 1) * self.numberOfOuterTiles;
    
    return innerIndex;
}

- (int)getIndexForOuterLayerFromPosition:(CGPoint)position {
    CGFloat halfTileW = self.tileSize.width * 0.5;
    CGFloat halfTileH = self.tileSize.height * 0.5;
    
    int x1 = position.x + halfTileW;
    int y1 = position.y + halfTileH;

    int i = x1 / self.tileSize.width;
    int j = y1 / self.tileSize.height;
    
    int outerIndex = j * self.numberOfOuterTiles + i + j * self.numberOfInnerTiles;
    
    return outerIndex;
}

- (CGFloat)touchPointValue:(CGPoint)position relativToTileArrangement:(TileArragement)tileArrangement {
    CGFloat halfTileW = self.tileSize.width * 0.5;
    CGFloat halfTileH = self.tileSize.height * 0.5;
    int i, j;

    i = position.x / halfTileW;
    j = position.y / halfTileH;
    
    if (tileArrangement == UpDarkRightStart || tileArrangement == UpLightRightStart) {
        CGPoint A, C;
        
        A.x = i * halfTileW;
        A.y = j * halfTileH;
        
        C.x = i * halfTileW + halfTileW;
        C.y = j * halfTileH + halfTileH;
        
        return (CGFloat)(position.x - A.x)/(C.x - A.x) - (CGFloat)(position.y - A.y)/(C.y - A.y);
    } else {
        CGPoint B, D;
        
        B.x = i * halfTileW + halfTileW;
        B.y = j * halfTileH;
        
        D.x = i * halfTileW;
        D.y = j * halfTileH + halfTileH;
        
        return (CGFloat)(position.x - B.x)/(D.x - B.x) - (CGFloat)(position.y - B.y)/(D.y - B.y);
    }
}


- (TileArragement)getTilesArragement:(CGPoint)position {
    int i = position.x / (self.tileSize.width * 0.5);
    int j = position.y / (self.tileSize.height * 0.5);
    TileArragement arragement;
    
    if (i % 2 == j % 2){
        if (i % 2 == 0){
            arragement = UpLightLeftStart;
        } else {
            arragement = UpDarkLeftStart;
        }
    } else if (i % 2 != 0) {
        arragement = UpLightRightStart;
    } else {
        arragement = UpDarkRightStart;
    }

    return arragement;
}

@end

