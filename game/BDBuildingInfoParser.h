//
//  BDBuildingInfoParser.h
//  game
//
//  Created by Bogdan Sala on 26/03/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBuildingInfoParser : NSObject

@property (nonatomic, strong) NSDictionary *dictionary;

- (instancetype)initWithString:(NSString *)jsonString;

@end
