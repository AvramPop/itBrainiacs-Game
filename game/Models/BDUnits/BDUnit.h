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

@property (nonatomic, strong) Class         favouriteTarget;
@property (nonatomic, assign) NSInteger     life;
@property (nonatomic, assign) NSInteger     attack;
@property (nonatomic, assign) NSInteger     defense;
@property (nonatomic, assign) NSInteger     speed;
@property (nonatomic, assign) NSInteger     carryCapacity;
@property (nonatomic, assign) NSInteger     woodCost;
@property (nonatomic, assign) NSInteger     goldCost;
@property (nonatomic, assign) NSInteger     ironCost;
@property (nonatomic, assign) NSInteger     peopleCost;
@property (nonatomic, assign) NSInteger     timeCost;
@property (nonatomic, strong) NSString      *imageName;
@property (nonatomic, strong) NSString      *name;

@end