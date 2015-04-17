//
//  BDProtoProduct.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDProtoProduct.h"

@implementation BDProtoProduct

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeStamp = [[NSDate alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.timeStamp = [aDecoder decodeObjectForKey:@"timeStamp"];
        self.protoProductName = [aDecoder decodeObjectForKey:@"protoProductName"];
        self.isResource = [aDecoder decodeBoolForKey:@"isResource"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.timeStamp forKey:@"timeStamp"];
    [aCoder encodeObject:self.protoProductName forKey:@"protoProductName"];
    [aCoder encodeBool:self.isResource forKey:@"isResource"];
}


-(BOOL)isEqual:(id)object{
    if([object class] == self.class && [[object protoProductName] isEqualToString:self.protoProductName]){
        return YES;
    }
    return NO;
}

@end
