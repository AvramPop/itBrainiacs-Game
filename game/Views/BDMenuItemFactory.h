//
//  BDMenuItemFactory.h
//  game
//
//  Created by Bogdan Sala on 12/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDMenuItem.h"

@interface BDMenuItemFactory : NSObject

#pragma mark - People Menu
+ (BDMenuItem *)menuItemHouse;
+ (BDMenuItem *)menuItemMarket;
+ (BDMenuItem *)menuItemHeadquaters;
+ (BDMenuItem *)menuItemUniversity;

#pragma mark - Resources Menu
+ (BDMenuItem *)menuItemWoodCamp;
+ (BDMenuItem *)menuItemGoldMine;
+ (BDMenuItem *)menuItemIronMine;

#pragma mark - Army Menu
+ (BDMenuItem *)menuItemBaracks;
+ (BDMenuItem *)menuItemStable;
+ (BDMenuItem *)menuItemWorkshop;

@end
