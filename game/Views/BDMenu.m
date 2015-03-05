//
//  BDMenu.m
//  game
//
//  Created by Bogdan Sala on 12/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMenu.h"

#import "BDMenuItem.h"
#import "BDMenuSection.h"

@interface BDMenu ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) BOOL isOpen;

@end

@implementation BDMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor redColor];
        self.buttons = [NSMutableArray array];
        self.isOpen = NO;
    }
    return self;
}

- (void)menuWillAppearAnimated:(BOOL)animated {
    [self createMenuFromDataSource];
    [self populateMenuFromDataSource];
}

- (void)menuDidAppearAnimated:(BOOL)animated {
    self.isOpen = YES;
}

- (void)menuWillDissappearAnimated:(BOOL)animated {

}

- (void)menuDidDissapearAnimated:(BOOL)animated {
    self.isOpen = NO;
    [self removeAllButtons];
}

- (void)reloadDataSource {
    [self createMenuFromDataSource];
    [self populateMenuFromDataSource];
}

- (void)createMenuFromDataSource {
    UIButton *aButton;
    //if there are not enough buttons
    for (long i = self.buttons.count; i < self.dataSource.count; i++) {
        aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];

        [self.buttons addObject:aButton];
        [self addSubview:aButton];
    }
    
    for (long i = self.dataSource.count; i < self.buttons.count; i++) {
        UIButton *aButton = self.buttons[i];
        [aButton setHidden:YES];
    }
}

- (void)populateMenuFromDataSource {
    float ratio = 1.0 / self.dataSource.count;
    
    for (int i = 0 ; i < self.dataSource.count; i++) {
        id<BDMenuItem> item = self.dataSource[i];
        UIButton *aButton = self.buttons[i];
        aButton.frame = CGRectMake(self.frame.size.width * ratio * i, 0, self.frame.size.width * ratio, self.frame.size.height);
        aButton.tag = i;
        [aButton setHidden:NO];
        
        if (![item.title isEqual:@"emptyItem"]) {
          
            if (![item.title isEqual:@""]) {
                [aButton setTitle:item.title forState:UIControlStateNormal];
            }
            
            if (item.iconName && ![item.iconName isEqual:@""]) {
                [aButton setImage:[UIImage imageNamed:item.iconName] forState:UIControlStateNormal];
            }
        } else {
            [aButton setTitle:@"" forState:UIControlStateNormal];
            [aButton setImage:nil forState:UIControlStateNormal];
        }
    }
}

- (void)removeAllButtons {
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];
}

- (void)menuItemSelected:(id)sender {
    UIButton *theSender = (UIButton *)sender;
    id item = self.dataSource[theSender.tag];
    if ([item isKindOfClass:[BDMenuSection class]]) {
        BDMenuSection *section = (BDMenuSection *)item;
        [self.delegate menu:self didSelectMenuSection:section];
    } else {
        BDMenuItem *itemMenu = (BDMenuItem *)item;
        [self.delegate menu:self didSelectMenuItem:itemMenu];
    }

}

@end
