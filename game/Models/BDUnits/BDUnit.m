//
//  BDUnit.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDUnit.h"

@implementation BDUnit

-(instancetype)init{
    self = [super init];
    if(self){
        self.woodCost = 50;
        self.goldCost = 50;
        self.ironCost = 50;
        self.peopleCost = 0;
        self.timeCost = 10;
    }
    return self;
}


-(bool)isEqual:(id)object{
    if([self isKindOfClass:[object class]]){
        BDUnit *unitObj = object;
        if (self.timeCost == unitObj.timeCost &&
            self.woodCost == unitObj.woodCost &&
            self.goldCost == unitObj.goldCost &&
            self.ironCost == unitObj.ironCost &&
            self.peopleCost == unitObj.peopleCost) {
            return YES;
        }
        
    }
    return NO;
}

//-(void)

@end
