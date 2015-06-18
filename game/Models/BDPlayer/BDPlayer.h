//
//  BDPlayer.h
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDTown.h"


@interface BDPlayer : NSObject <NSCoding>

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, strong) NSArray   *arrayOfTowns;
@property (nonatomic, assign) NSInteger numberOfReports;
@property (nonatomic, assign) NSInteger numberOfUnreadReports;

- (BDTown *)currentTown;

+ (BDPlayer *)currentPlayer;
+ (void)setCurrentPlayer:(BDPlayer *)aPlayer;

+ (BDPlayer *)adversaryPlayer;
+ (void)setAdversaryPlayer:(BDPlayer *)aPlayer;

@end
