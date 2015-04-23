//
//  BDUnit.h
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDProtoProduct.h"

@interface BDUnit : NSObject <BDProtoProduct>

@property (nonatomic, strong) BDUnit        *favouriteTarget;
@property (nonatomic, assign) NSInteger     life;
@property (nonatomic, assign) NSInteger     attack;
@property (nonatomic, assign) NSInteger     defense;
@property (nonatomic, assign) NSInteger     speed;
@property (nonatomic, assign) NSInteger     carryCapacity;

@end