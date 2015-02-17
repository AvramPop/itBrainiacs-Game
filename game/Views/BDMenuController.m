//
//  BDMenuController.m
//  game
//
//  Created by Bogdan Sala on 13/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMenuController.h"
#import "BDMenuDefinitions.h"

#import "BDMenu.h"
#import "BDMenuSectionFactory.h"

@interface BDMenuController()<BDMenuDelegate>

@property (nonatomic, strong) BDMenu        *menu;
@property (nonatomic, strong) UIView        *decoratedView;

@property (nonatomic, assign) BDMenuSectionKey    menuType;

@end

@implementation BDMenuController

- (instancetype)initWithDecoratedView:(UIView *)decoratedView withMenuFrame:(CGRect)frame {
    self = [super init];
    if (self){
        self.menu = [[BDMenu alloc] initWithFrame:frame];
        self.menu.delegate = self;
        
        self.decoratedView = decoratedView;
        [self.decoratedView addSubview:self.menu];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTouchMainMenu:) name:@"didTouchHeadQuartersMenu" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTouchBaracksMenu:) name:@"didTouchBarracksMenu" object:nil];
    }
    
    return self;
}

- (void)didTouchMainMenu:(id)sender {
    if (!self.menu.isOpen) {
        self.menuType = BDMenuSectionMain;
        self.menu.dataSource = [self getDataSourceForMenuType:self.menuType];
        [self menuOpenAnimation];
    } else {
        [self menuCloseAnimation];
    }
}

- (void)didTouchBaracksMenu:(id)sender {
    if (!self.menu.isOpen) {
        self.menuType = BDMenuSectionPeopleUnits;
        self.menu.dataSource = [self getDataSourceForMenuType:self.menuType];
        [self menuOpenAnimation];
    } else {
        [self menuCloseAnimation];
    }
}

- (BDMenuSection *)getDataSourceForMenuType:(BDMenuSectionKey)menuType {
    switch (menuType) {
        case BDMenuSectionMain:
            return [BDMenuSectionFactory mainMenuSection];
            break;
        case BDMenuSectionArmyBuildings:
            return [BDMenuSectionFactory armyMenuSection];
            break;
        case BDMenuSectionPeopleBuildings:
            return [BDMenuSectionFactory peopleMenuSection];
            break;
        case BDMenuSectionResorcesBuildings:
            return [BDMenuSectionFactory resourcesMenuSection];
            break;
        default:
            return nil;
            break;
    }
}

- (void)resetMenuType {
    self.menuType = BDMenuSectionMain;
    self.menu.dataSource = [self getDataSourceForMenuType:self.menuType];
}

- (void)menuCloseAnimation {
    [self.menu menuWillDissappearAnimated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.menu.frame = CGRectOffset(self.menu.frame, 0, 100);
    } completion:^(BOOL finished) {
        [self.menu menuDidDissapearAnimated:YES];
    }];
}

- (void)menuOpenAnimation {
    [self.menu menuWillAppearAnimated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.menu.frame = CGRectOffset(self.menu.frame, 0, -100);
    } completion:^(BOOL finished) {
        [self.menu menuDidAppearAnimated:YES];
    }];
}

#pragma mark - BDMenuDelegate

- (void)menu:(BDMenu *)menu didSelectMenuSection:(BDMenuSection *)menuItem {
    self.menuType = menuItem.sectionKey;
    self.menu.dataSource = [self getDataSourceForMenuType:self.menuType];
    [self.menu reloadDataSource];
}

- (void)menu:(BDMenu *)menu didSelectMenuItem:(BDMenuItem *)menuItem {
    if (self.menu.isOpen) {
        [self menuCloseAnimation];
    }
    [self resetMenuType];

    [self.delegate menu:self didSelectBuilding:[self createBuildingFormMenuItem:menuItem]];
}

#pragma mark - Private

- (BDBuilding *)createBuildingFormMenuItem:(BDMenuItem *)item {
    NSString *className = item.className;
    return [[NSClassFromString(className) alloc] initWithImageNamed:item.iconName];
}

@end