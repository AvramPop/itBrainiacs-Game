//
//  BDTown.m
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDTown.h"

@interface BDTown()

@end

@implementation BDTown

- (instancetype)initWithPosition:(CGPoint)point imageName:(NSString *)imageName andType:(BDTownType)type {
    self = [super initWithImageNamed:imageName];
    if (self) {
        self.type = type;
        self.position = point;
        self.buildings = [NSMutableArray array];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"townWasTouched" object:nil userInfo:@{@"town" : self}];
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:self.type forKey:@"type"];
    NSData *buildingData = [NSKeyedArchiver archivedDataWithRootObject:self.buildings];
    [aCoder encodeObject:buildingData forKey:@"arrayOfBuildings"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    self.type = [aDecoder decodeIntForKey:@"type"];
    NSData *buildingData = [aDecoder decodeObjectForKey:@"arrayOfBuildings"];
    self.buildings = [NSKeyedUnarchiver unarchiveObjectWithData:buildingData];
    
    self.userInteractionEnabled = YES;
    
    
    return self;
}


@end