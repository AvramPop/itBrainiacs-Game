//
//  BDMenuSection.m
//  game
//
//  Created by Bogdan Sala on 17/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMenuSection.h"

@interface BDMenuSection ()

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation BDMenuSection

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.title = @"emptyItem";
        self.iconName = @"Elixir1";
        self.itemsArray = array;
    }
    return self;
}

+ (BDMenuSection *)emptySection {
    BDMenuSection *item = [[BDMenuSection alloc] init];
    return item;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@, iconName:%@", self.title, self.iconName];
}

- (NSInteger)key {
    return self.sectionKey;
}

// ns array like methods

- (id)objectAtIndex:(NSUInteger)index {
    return [self.itemsArray objectAtIndex:index];
}

- (NSEnumerator *)objectEnumerator {
    return [self.itemsArray objectEnumerator];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [self.itemsArray countByEnumeratingWithState:state objects:buffer count:len];
}

- (NSInteger)count {
    return self.itemsArray.count;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self.itemsArray objectAtIndexedSubscript:idx];
}

@end
