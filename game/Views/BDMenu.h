//
//  BDMenu.h
//  game
//
//  Created by Bogdan Sala on 12/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDMenuItem.h"
#import "BDMenuSection.h"

@protocol BDMenuDelegate;

@interface BDMenu : UIView

@property (nonatomic, weak) id<BDMenuDelegate> delegate;
@property (nonatomic, strong) BDMenuSection *dataSource;
@property (nonatomic, assign, readonly) BOOL isOpen;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)menuWillAppearAnimated:(BOOL)animated;
- (void)menuDidAppearAnimated:(BOOL)animated;

- (void)menuWillDissappearAnimated:(BOOL)animated;
- (void)menuDidDissapearAnimated:(BOOL)animated;

- (void)reloadDataSource;

@end

@protocol BDMenuDelegate <NSObject>

- (void)menu:(BDMenu *)menu didSelectMenuItem:(BDMenuItem *)menuItem;
- (void)menu:(BDMenu *)menu didSelectMenuSection:(BDMenuSection *)menuItem;

@end