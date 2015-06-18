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
    self.name = [aDecoder decodeObjectForKey:@"name"];
#warning please fill the archive with all the properties
   
    NSData *townData = [aDecoder decodeObjectForKey:@"arrayOfTowns"];
    self.arrayOfTowns = [NSKeyedUnarchiver unarchiveObjectWithData:townData];
    for (BDTown *town in self.arrayOfTowns) {
        town.owner = self;
    }
    self.points = [aDecoder decodeIntegerForKey:@"points"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
#warning please fill the archive with all the properties
    [aCoder encodeObject:self.name forKey:@"name"];
    NSData *townData = [NSKeyedArchiver archivedDataWithRootObject:self.arrayOfTowns];
    [aCoder encodeObject:townData forKey:@"arrayOfTowns"];
    [aCoder encodeInteger:self.points forKey:@"points"];
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

- (BDTown *)currentTown {
    return self.arrayOfTowns[0];
}

@end
