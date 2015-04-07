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
        NSString *name = self.dictionary[@"name"];
        NSString *type = self.dictionary[@"type"];
        NSString *subtype = self.dictionary[@"subtype"];
        NSArray *level = self.dictionary[@"level"];
        NSDictionary *cost = level[0];
        NSLog(@"the name is : %@", name);
        NSLog(@"the type is : %@", type);
        NSLog(@"the subtype is : %@", subtype);
        NSLog(@"the cost is : %@", cost);
    }
    return self;
}

@end
