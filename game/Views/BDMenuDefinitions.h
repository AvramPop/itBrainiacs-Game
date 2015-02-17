//
//  BDMenuDefinitions.h
//  game
//
//  Created by Bogdan Sala on 13/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    //People Menu
    BDMenuItemHouse,
    BDMenuItemMarket,
    BDMenuItemHeadquarters,
    BDMenuItemUniversity,
    //Resources Menu
    BDMenuItemWoodCamp,
    BDMenuItemGoldMine,
    BDMenuItemIronMine,
    //Army Menu
    BDMenuItemBarcks,
    BDMenuItemStable,
    BDMenuItemWorkshop,
} BDMenuItemKey;

typedef enum {
    BDMenuSectionMain,
    BDMenuSectionResorcesBuildings,
    BDMenuSectionPeopleBuildings,
    BDMenuSectionArmyBuildings,
    //Units
    BDMenuSectionPeopleUnits,
    BDMenuSectionArmyUnits,    
} BDMenuSectionKey;

@protocol BDMenuItem <NSObject>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconName;

@property (nonatomic, assign, readonly) NSInteger key;

@end