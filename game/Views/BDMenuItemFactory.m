//
//  BDMenuItemFactory.m
//  game
//
//  Created by Bogdan Sala on 12/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMenuItemFactory.h"

@implementation BDMenuItemFactory

#pragma mark - People Menu

+ (BDMenuItem *)menuItemHouse {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"ClanCastle1";
    peopleItem.className = @"BDHouse";
    peopleItem.itemKey = BDMenuItemHouse;
    
    return peopleItem;
}

+ (BDMenuItem *)menuItemMarket {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"Resources";
    peopleItem.iconName = nil;
    peopleItem.className = @"BDMarket";
    peopleItem.itemKey = BDMenuItemMarket;

    return peopleItem;
}

+ (BDMenuItem *)menuItemHeadquaters {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Headquarters1";
    peopleItem.className = @"BDHeadquarters";
    peopleItem.itemKey = BDMenuItemHeadquarters;
    
    return peopleItem;
}

+ (BDMenuItem *)menuItemUniversity {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Laboratory1";
    peopleItem.className = @"BDUniversity";
    peopleItem.itemKey = BDMenuItemUniversity;
    
    return peopleItem;
}

#pragma mark = Resources Menu
+ (BDMenuItem *)menuItemWoodCamp {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Builder_Hut";
    peopleItem.className = @"BDWoodCamp";
    peopleItem.itemKey = BDMenuItemWoodCamp;

    return peopleItem;
}

+ (BDMenuItem *)menuItemGoldMine {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Gold_Mine1";
    peopleItem.className = @"BDGoldMine";
    peopleItem.itemKey = BDMenuItemGoldMine;

    return peopleItem;
}

+ (BDMenuItem *)menuItemIronMine {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Dark_Elixir_Drill1";
    peopleItem.className = @"BDIronMine";
    peopleItem.itemKey = BDMenuItemIronMine;

    return peopleItem;
}

#pragma mark - Army Menu
+ (BDMenuItem *)menuItemBaracks {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Army_Camp1";
    peopleItem.className = @"BDBaracks";
    peopleItem.itemKey = BDMenuItemBarcks;

    return peopleItem;
}

+ (BDMenuItem *)menuItemStable {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"";
    peopleItem.iconName = @"Barracks1";
    peopleItem.className = @"BDStable";
    peopleItem.itemKey = BDMenuItemStable;

    return peopleItem;
}

+ (BDMenuItem *)menuItemWorkshop {
    BDMenuItem *peopleItem = [[BDMenuItem alloc] init];
    peopleItem.title = @"Resources";
    peopleItem.iconName = nil;
    peopleItem.className = @"BDWorkshop";
    peopleItem.itemKey = BDMenuItemWorkshop;

    return peopleItem;
}

@end
