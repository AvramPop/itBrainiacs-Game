//
//  BDMenuItem.h
//  game
//
//  Created by Bogdan Sala on 12/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDMenuDefinitions.h"

@interface BDMenuItem : NSObject <BDMenuItem>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *className;

@property (nonatomic, assign) BDMenuItemKey itemKey;

+ (instancetype)emptyMenuItem;

- (NSInteger)key;

@end
