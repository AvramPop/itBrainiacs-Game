//
//  BDTown.h
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class BDPlayer;

typedef enum {
    BDTownTypeBarbarian,
    BDTownTypeHuman
} BDTownType;

@interface BDTown : SKSpriteNode

@property (nonatomic, strong) BDPlayer          *owner;
@property (nonatomic, assign) BDTownType        type;
@property (nonatomic, strong) NSMutableArray    *buildings;

@property (nonatomic, assign) double gold;
@property (nonatomic, assign) double wood;
@property (nonatomic, assign) double iron;

@property (nonatomic, assign) NSInteger people;
//
@property (nonatomic, assign) NSInteger swordsmanCount;
@property (nonatomic, assign) NSInteger axemanCount;
@property (nonatomic, assign) NSInteger archerCount;
@property (nonatomic, assign) NSInteger wizardCount;
@property (nonatomic, assign) NSInteger spyCount;
@property (nonatomic, assign) NSInteger lightCavaleryCount;
@property (nonatomic, assign) NSInteger highCavaleryCount;
@property (nonatomic, assign) NSInteger ramCount;
@property (nonatomic, assign) NSInteger baloonCount;
@property (nonatomic, assign) NSInteger catapultCount;

- (instancetype)initWithPosition:(CGPoint)point imageName:(NSString *)imageName andType:(BDTownType)type;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

- (void)addBuilding:(id)building;
- (void)removeBuilding:(id)building;
- (id)buildingAtIndex:(NSInteger)index;

@end