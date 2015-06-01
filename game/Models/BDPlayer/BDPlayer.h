//
//  BDPlayer.h
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPlayer : NSObject <NSCoding>

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, strong) NSArray   *arrayOfTowns;
//
@property (nonatomic, assign) NSInteger gold;
@property (nonatomic, assign) NSInteger wood;
@property (nonatomic, assign) NSInteger iron;
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

+ (BDPlayer *)currentPlayer;
+ (void)setCurrentPlayer:(BDPlayer *)aPlayer;

+ (BDPlayer *)adversaryPlayer;
+ (void)setAdversaryPlayer:(BDPlayer *)aPlayer;

@end
