//
//  BDMenuSectionFactory.m
//  game
//
//  Created by Bogdan Sala on 17/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMenuSectionFactory.h"
#import "BDMenuItemFactory.h"

@implementation BDMenuSectionFactory

#pragma mark - main menu

+ (BDMenuSection *)mainMenuSection {
    BDMenuSection *section = [[BDMenuSection alloc] initWithArray:@[[BDMenuItem emptyMenuItem],
                                                                    [BDMenuSectionFactory peopleMenuSection],
                                                                    [BDMenuSectionFactory resourcesMenuSection],
                                                                    [BDMenuSectionFactory armyMenuSection],
                                                                    [BDMenuItem emptyMenuItem]]];
    
    section.title = nil;
    section.iconName = nil;
    section.sectionKey = BDMenuSectionMain;
    return section;
}

#pragma mark - Main Menu SubSections

+ (BDMenuSection *)peopleMenuSection {
    BDMenuSection *section = [[BDMenuSection alloc] initWithArray:@[[BDMenuItem emptyMenuItem],
                                                                    [BDMenuItemFactory menuItemHouse],
                                                                    [BDMenuItemFactory menuItemHeadquaters],
                                                                    [BDMenuItemFactory menuItemMarket],
                                                                    [BDMenuItemFactory menuItemUniversity],
                                                                    [BDMenuItem emptyMenuItem]]];
    section.title = @"People";
    section.iconName = nil;
    section.sectionKey = BDMenuSectionPeopleBuildings;
    return section;
}

+ (BDMenuSection *)armyMenuSection {
    BDMenuSection *section = [[BDMenuSection alloc] initWithArray:@[[BDMenuItem emptyMenuItem],
                                                                    [BDMenuItemFactory menuItemBaracks],
                                                                    [BDMenuItemFactory menuItemStable],
                                                                    [BDMenuItemFactory menuItemWorkshop],
                                                                    [BDMenuItem emptyMenuItem]]];
    section.title = @"Army";
    section.iconName = nil;
    section.sectionKey = BDMenuSectionArmyBuildings;
    return section;
}

+ (BDMenuSection *)resourcesMenuSection {
    BDMenuSection *section = [[BDMenuSection alloc] initWithArray:@[[BDMenuItem emptyMenuItem],
                                                                    [BDMenuItemFactory menuItemWoodCamp],
                                                                    [BDMenuItemFactory menuItemGoldMine],
                                                                    [BDMenuItemFactory menuItemIronMine],
                                                                    [BDMenuItem emptyMenuItem]]];
    section.title = @"Resources";
    section.iconName = nil;
    section.sectionKey = BDMenuSectionResorcesBuildings;
    return section;
}

@end
