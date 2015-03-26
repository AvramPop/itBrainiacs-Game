//
//  BDBuildingInfoParser.m
//  game
//
//  Created by Bogdan Sala on 26/03/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBuildingInfoParser.h"

@implementation BDBuildingInfoParser

- (instancetype)initWithString:(NSString *)jsonString{
    self = [super init];
    if(self){
        NSError *error;
        self.dictionary = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSString *theName = self.dictionary[@"name"];
        NSString *value = self.dictionary[@"title"];
        NSArray *array= self.dictionary[@"level"];
        NSDictionary *level0 = array[0];
        NSDictionary *level1 = array[1];
        NSString *value1 = level0[@"name"];
        NSLog(@"the name is : %@", self.dictionary);
    }
    return self;
}

@end
