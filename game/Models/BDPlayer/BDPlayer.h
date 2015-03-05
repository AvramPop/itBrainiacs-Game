//
//  BDPlayer.h
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPlayer : NSObject

#pragma mark - Resources

+(NSInteger)goldAmount;
+(void)setGoldAmount:(NSInteger)amount;
+(void)incrementGold;

+(NSInteger)woodAmount;
+(void)setWoodAmount:(NSInteger)amount;
+(void)incrementWood;

+(NSInteger)ironAmount;
+(void)setIronAmount:(NSInteger)amount;
+(void)incrementIron;

+(NSInteger)peopleAmount;
+(void)setPeopleAmount:(NSInteger)amount;
+(void)incrementPeople;

#pragma mark - Units

+(NSInteger)swordsmanNumber;
+(void)setSwordsmanNumber:(NSInteger)amount;
+(void)incrementSwordsman;

+(NSInteger)axemanNumber;
+(void)setAxemanNumber:(NSInteger)amount;
+(void)incrementAxeman;

+(NSInteger)archerNumber;
+(void)setArcherNumber:(NSInteger)amount;
+(void)incrementArcher;

+(NSInteger)wizardNumber;
+(void)setWizardNumber:(NSInteger)amount;
+(void)incrementWizard;

+(NSInteger)spyNumber;
+(void)setSpyNumber:(NSInteger)amount;
+(void)incrementSpy;

+(NSInteger)lightCavaleryNumber;
+(void)setLightCavaleryNumber:(NSInteger)amount;
+(void)incrementLightCavalery;

+(NSInteger)highCavaleryNumber;
+(void)setHighCavaleryNumber:(NSInteger)amount;
+(void)incrementHighCavalery;

+(NSInteger)ramNumber;
+(void)setRamNumber:(NSInteger)amount;
+(void)incrementRam;

+(NSInteger)baloonNumber;
+(void)setBaloonNumber:(NSInteger)amount;
+(void)incrementBaloon;

+(NSInteger)catapultNumber;
+(void)setCatapultNumber:(NSInteger)amount;
+(void)incrementCatapult;
@end
