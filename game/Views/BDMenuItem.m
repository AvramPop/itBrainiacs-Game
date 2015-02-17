//
//  BDMenuItem.m
//  game
//
//  Created by Bogdan Sala on 12/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMenuItem.h"

@implementation BDMenuItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"emptyItem";
        self.iconName = @"Elixir1";
        self.className = @"BDBuilding";
    }
    return self;
}

+ (BDMenuItem *)emptyMenuItem {
    BDMenuItem *item = [[BDMenuItem alloc] init];
    return item;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@, iconName:%@ className:%@", self.title, self.iconName, self.className];
}

- (NSInteger)key {
    return self.itemKey;
}

@end
