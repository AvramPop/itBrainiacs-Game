//
//  BDMenuSectionFactory.h
//  game
//
//  Created by Bogdan Sala on 17/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDMenuSection.h"

@interface BDMenuSectionFactory : NSObject

#pragma mark - Main Menu
+ (BDMenuSection *)mainMenuSection;

#pragma mark - Main Menu SubSections
+ (BDMenuSection *)peopleMenuSection;
+ (BDMenuSection *)armyMenuSection;
+ (BDMenuSection *)resourcesMenuSection;

@end
