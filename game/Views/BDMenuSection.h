//
//  BDMenuSection.h
//  game
//
//  Created by Bogdan Sala on 17/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDMenuItem.h"

@interface BDMenuSection : NSObject <BDMenuItem, NSFastEnumeration>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconName;

@property (nonatomic, assign) BDMenuSectionKey sectionKey;

- (instancetype)initWithArray:(NSArray *)array;

+ (BDMenuSection *)emptySection;

- (NSInteger)key;

- (NSInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (NSEnumerator *)objectEnumerator;

- (id)objectAtIndexedSubscript:(NSUInteger)idx NS_AVAILABLE(10_8, 6_0);

@end
