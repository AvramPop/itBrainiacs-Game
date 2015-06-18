//
//  BDTown.m
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDTown.h"
#import "BDBuilding.h"

@interface BDTown()

@property (nonatomic, strong)NSLock     *lock;

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
    [aCoder encodeInteger:self.gold forKey:@"amountOfGold"];
    [aCoder encodeInteger:self.wood forKey:@"amountOfWood"];
    [aCoder encodeInteger:self.iron forKey:@"amountOfIron"];
    [aCoder encodeInteger:self.people forKey:@"amountOfPeople"];
    
    [aCoder encodeInteger:self.swordsmanCount forKey:@"amountOfSwordsman"];
    [aCoder encodeInteger:self.axemanCount forKey:@"amountOfAxeman"];
    [aCoder encodeInteger:self.archerCount forKey:@"amountOfArcher"];
    [aCoder encodeInteger:self.wizardCount forKey:@"amountOfWizard"];
    [aCoder encodeInteger:self.spyCount forKey:@"amountOfSpy"];
    [aCoder encodeInteger:self.lightCavaleryCount forKey:@"amountOfLightCavalery"];
    [aCoder encodeInteger:self.highCavaleryCount forKey:@"amountOfHighCavalery"];
    [aCoder encodeInteger:self.ramCount forKey:@"amountOfRam"];
    [aCoder encodeInteger:self.baloonCount forKey:@"amountOfBaloon"];
    [aCoder encodeInteger:self.catapultCount forKey:@"amountOfCatapult"];
    
    [aCoder encodeInt:self.type forKey:@"type"];
    
    NSData *buildingData = [NSKeyedArchiver archivedDataWithRootObject:self.buildings];
    [aCoder encodeObject:buildingData forKey:@"arrayOfBuildings"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    self.gold = [aDecoder decodeIntegerForKey:@"amountOfGold"];
    self.wood = [aDecoder decodeIntegerForKey:@"amountOfWood"];
    self.iron = [aDecoder decodeIntegerForKey:@"amountOfIron"];
    self.people = [aDecoder decodeIntegerForKey:@"amountOfPeople"];
    
    self.swordsmanCount = [aDecoder decodeIntegerForKey:@"amountOfSwordsman"];
    self.axemanCount = [aDecoder decodeIntegerForKey:@"amountOfAxeman"];
    self.archerCount = [aDecoder decodeIntegerForKey:@"amountOfArcher"];
    self.wizardCount = [aDecoder decodeIntegerForKey:@"amountOfWizard"];
    self.spyCount = [aDecoder decodeIntegerForKey:@"amountOfSpy"];
    self.lightCavaleryCount = [aDecoder decodeIntegerForKey:@"amountOfLightCavalery"];
    self.highCavaleryCount = [aDecoder decodeIntegerForKey:@"amountOfHighCavalery"];
    self.ramCount = [aDecoder decodeIntegerForKey:@"amountOfRam"];
    self.baloonCount = [aDecoder decodeIntegerForKey:@"amountOfBaloon"];
    self.catapultCount = [aDecoder decodeIntegerForKey:@"amountOfCatapult"];

    self.type = [aDecoder decodeIntForKey:@"type"];
    NSData *buildingData = [aDecoder decodeObjectForKey:@"arrayOfBuildings"];
    self.buildings = [NSKeyedUnarchiver unarchiveObjectWithData:buildingData];
    
    self.userInteractionEnabled = YES;
    
    
    return self;
}

#pragma mark - Thread safe building array operations

- (id)buildingAtIndex:(NSInteger)index { 
    return [self.buildings objectAtIndex:index];
}

- (void)removeBuilding:(id)building {
    [self.buildings removeObject:building];
}

- (void)addBuilding:(id)building {
    [self.buildings addObject:building];
}

@end