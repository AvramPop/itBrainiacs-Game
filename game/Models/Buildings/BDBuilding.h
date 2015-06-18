//
//  IBBuilding.h
//  game
//
//  Created by Bogdan Sala on 04/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BDProtoProduct.h"

@interface BDBuilding : SKSpriteNode <BDProtoProduct, NSCoding>

@property (nonatomic, assign) NSInteger         level;
@property (nonatomic, assign) NSInteger         maxLevel;

@property (nonatomic, strong) NSArray           *availableProtoProducts;
@property (nonatomic, strong) NSMutableArray    *protoProducts;
@property (nonatomic, assign) NSInteger         goldCost;
@property (nonatomic, assign) NSInteger         woodCost;
@property (nonatomic, assign) NSInteger         ironCost;
@property (nonatomic, assign) NSInteger         peopleCost;
@property (nonatomic, assign) NSInteger         timeCost;
@property (nonatomic, strong) NSString          *iconName;
@property (nonatomic, strong) NSString          *buildingDescription;
@property (nonatomic, assign) NSInteger         points;

- (BOOL)isUpgrading;
- (void)reactToTouch;
- (instancetype)initWithLevel:(int)level;
- (NSDictionary *)getJsonDictionary;

- (void)changeImage:(UIImage *)image;

@end
