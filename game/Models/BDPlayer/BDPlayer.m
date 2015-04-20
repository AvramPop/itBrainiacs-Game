//
//  BDPlayer.m
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDPlayer.h"

static BDPlayer *currentPlayer;
static BDPlayer *adversaryPlayer;

@implementation BDPlayer

- (id)initWithCoder:(NSCoder *)aDecoder {
    self.gold = [aDecoder decodeIntegerForKey:@"amountOfGold"];
    self.wood = [aDecoder decodeIntegerForKey:@"amountOfWood"];
    self.iron = [aDecoder decodeIntegerForKey:@"amountOfIron"];
    self.people = [aDecoder decodeIntegerForKey:@"amountOfPeople"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.gold forKey:@"amountOfGold"];
    [aCoder encodeInteger:self.wood forKey:@"amountOfWood"];
    [aCoder encodeInteger:self.iron forKey:@"amountOfIron"];
    [aCoder encodeInteger:self.people forKey:@"amountOfPeople"];
}

+ (BDPlayer *)currentPlayer {
    if (currentPlayer == nil) {
        currentPlayer = [[BDPlayer alloc] init];
    }
    
    return currentPlayer;
}

+ (void)setCurrentPlayer:(BDPlayer *)aPlayer {
    currentPlayer = aPlayer;
}

+ (BDPlayer *)adversaryPlayer {
    return adversaryPlayer;
}

+ (void)setAdversaryPlayer:(BDPlayer *)aPlayer {
    adversaryPlayer = aPlayer;
}

@end
