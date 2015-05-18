//
//  BDWarUnit.m
//  game
//
//  Created by Bogdan Sala on 24/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDSquad.h"

@implementation BDSquad

-(instancetype)initWithUnit:(BDUnit *)unit andCount:(NSInteger)count{
    self = [super init];
    if(self){
        self.unit = unit;
        self.count = count;
    }
    return self;
}
@end
