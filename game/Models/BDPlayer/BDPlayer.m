//
//  BDPlayer.m
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDPlayer.h"
#import "BDTown.h"
static BDPlayer *currentPlayer;
static BDPlayer *adversaryPlayer;

@implementation BDPlayer

- (id)initWithCoder:(NSCoder *)aDecoder {
    self.gold = [aDecoder decodeIntegerForKey:@"amountOfGold"];
    self.wood = [aDecoder decodeIntegerForKey:@"amountOfWood"];
    self.iron = [aDecoder decodeIntegerForKey:@"amountOfIron"];
    self.people = [aDecoder decodeIntegerForKey:@"amountOfPeople"];
    self.swordsmanCount = [aDecoder decodeIntegerForKey:@"amountOfSwordsman"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
#warning please fill the archive with all the properties
   
    NSData *townData = [aDecoder decodeObjectForKey:@"arrayOfTowns"];
    self.arrayOfTowns = [NSKeyedUnarchiver unarchiveObjectWithData:townData];
    for (BDTown *town in self.arrayOfTowns) {
        town.owner = self;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
#warning please fill the archive with all the properties
    [aCoder encodeInteger:self.gold forKey:@"amountOfGold"];
    [aCoder encodeInteger:self.wood forKey:@"amountOfWood"];
    [aCoder encodeInteger:self.iron forKey:@"amountOfIron"];
    [aCoder encodeInteger:self.people forKey:@"amountOfPeople"];
    [aCoder encodeInteger:self.swordsmanCount forKey:@"amountOfSwordsman"];
    [aCoder encodeObject:self.name forKey:@"name"];
    NSData *townData = [NSKeyedArchiver archivedDataWithRootObject:self.arrayOfTowns];
    [aCoder encodeObject:townData forKey:@"arrayOfTowns"];
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
