//
//  BDPlayer.m
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDPlayer.h"

static NSInteger amountOfGold;

static NSInteger amountOfWood;

static NSInteger amountOfIron;

static NSInteger amountOfPeople;
///
static NSInteger swordsmanNumber;

static NSInteger axemanNumber;

static NSInteger archerNumber;

static NSInteger wizardNumber;

static NSInteger spyNumber;

static NSInteger lightCavaleryNumber;

static NSInteger highCavaleryNumber;

static NSInteger ramNumber;

static NSInteger baloonNumber;

static NSInteger catapultNumber;

@implementation BDPlayer

#pragma mark - Resources

+(NSInteger)goldAmount {
    return amountOfGold;
}
+(void)setGoldAmount:(NSInteger)amount {
    amountOfGold = amount;
}
+(void)incrementGold {
    amountOfGold++;
}


+(NSInteger)woodAmount {
    return amountOfWood;
}
+(void)setWoodAmount:(NSInteger)amount {
    amountOfWood = amount;
}
+(void)incrementWood {
    amountOfWood++;
}

+(NSInteger)ironAmount {
    return amountOfIron;
}
+(void)setIronAmount:(NSInteger)amount {
    amountOfIron = amount;
}
+(void)incrementIron {
    amountOfIron++;
}

+(NSInteger)peopleAmount {
    return amountOfPeople;
}
+(void)setPeopleAmount:(NSInteger)amount {
    amountOfPeople = amount;
}
+(void)incrementPeople{
    amountOfPeople++;
}

#pragma mark - Units

+(NSInteger)swordsmanNumber {
    return swordsmanNumber;
}
+(void)setSwordsmanNumber:(NSInteger)amount {
    swordsmanNumber = amount;
}
+(void)incrementSwordsman{
    swordsmanNumber++;
}

+(NSInteger)axemanNumber {
    return axemanNumber;
}
+(void)setAxemanNumber:(NSInteger)amount {
    axemanNumber = amount;
}
+(void)incrementAxeman {
    axemanNumber++;
}

+(NSInteger)archerNumber {
    return archerNumber;
}
+(void)setArcherNumber:(NSInteger)amount {
    archerNumber = amount;
}
+(void)incrementArcher {
    archerNumber++;
}

+(NSInteger)wizardNumber {
    return wizardNumber;
}
+(void)setWizardNumber:(NSInteger)amount {
    wizardNumber = amount;
}
+(void)incrementWizard {
    wizardNumber++;
}

+(NSInteger)spyNumber {
    return spyNumber;
}
+(void)setSpyNumber:(NSInteger)amount {
    spyNumber = amount;
}
+(void)incrementSpy {
    spyNumber++;
}

+(NSInteger)lightCavaleryNumber {
    return lightCavaleryNumber;
}
+(void)setLightCavaleryNumber:(NSInteger)amount {
    lightCavaleryNumber = amount;
}
+(void)incrementLightCavalery {
    lightCavaleryNumber++;
}

+(NSInteger)highCavaleryNumber {
    return highCavaleryNumber;
}
+(void)setHighCavaleryNumber:(NSInteger)amount {
    highCavaleryNumber = amount;
}
+(void)incrementHighCavalery {
    highCavaleryNumber++;
}

+(NSInteger)ramNumber {
    return ramNumber;
}
+(void)setRamNumber:(NSInteger)amount {
    ramNumber = amount;
}
+(void)incrementRam {
    ramNumber++;
}

+(NSInteger)baloonNumber {
    return baloonNumber;
}
+(void)setBaloonNumber:(NSInteger)amount {
    baloonNumber = amount;
}
+(void)incrementBaloon {
    baloonNumber++;
}

+(NSInteger)catapultNumber {
    return catapultNumber;
}
+(void)setCatapultNumber:(NSInteger)amount {
    catapultNumber = amount;
}
+ (void)incrementCatapult {
    catapultNumber++;
}

@end
