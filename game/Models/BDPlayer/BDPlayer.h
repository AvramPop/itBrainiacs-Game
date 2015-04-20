//
//  BDPlayer.h
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPlayer : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger gold;
@property (nonatomic, assign) NSInteger wood;
@property (nonatomic, assign) NSInteger iron;
@property (nonatomic, assign) NSInteger people;
//
@property (nonatomic, assign) NSInteger swordsmanNumber;
@property (nonatomic, assign) NSInteger axemanNumber;
@property (nonatomic, assign) NSInteger archerNumber;
@property (nonatomic, assign) NSInteger wizardNumber;
@property (nonatomic, assign) NSInteger spyNumber;
@property (nonatomic, assign) NSInteger lightCavaleryNumber;
@property (nonatomic, assign) NSInteger highCavaleryNumber;
@property (nonatomic, assign) NSInteger ramNumber;
@property (nonatomic, assign) NSInteger baloonNumber;
@property (nonatomic, assign) NSInteger catapultNumber;

+ (BDPlayer *)currentPlayer;
+ (void)setCurrentPlayer:(BDPlayer *)aPlayer;

+ (BDPlayer *)adversaryPlayer;
+ (void)setAdversaryPlayer:(BDPlayer *)aPlayer;

@end
