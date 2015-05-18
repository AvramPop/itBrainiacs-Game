//
//  BDWarUnit.h
//  game
//
//  Created by Bogdan Sala on 24/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDUnit.h"

@interface BDSquad : NSObject

@property (nonatomic, strong) BDUnit *unit;
@property (nonatomic) NSInteger count;

-(instancetype)initWithUnit:(BDUnit *)unit andCount:(NSInteger)count;

@end
