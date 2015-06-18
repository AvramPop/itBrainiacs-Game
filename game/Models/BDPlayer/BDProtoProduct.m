//
//  BDProtoProduct.m
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDProtoProduct.h"

@implementation BDProtoProduct

+ (instancetype)protoProductWithProtoProduct:(BDProtoProduct *)proto {
    BDProtoProduct *protop = [[self alloc] init];
    protop.timeStamp = proto.timeStamp;
    protop.protoProductName = proto.protoProductName;
    protop.type = proto.type;
    protop.delegate = proto.delegate;
    
    return protop;
}

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
        self.type = [aDecoder decodeBoolForKey:@"type"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.timeStamp forKey:@"timeStamp"];
    [aCoder encodeObject:self.protoProductName forKey:@"protoProductName"];
    [aCoder encodeBool:self.type forKey:@"type"];
}


-(BOOL)isEqual:(id)object{
    if([object class] == self.class) {
        BDProtoProduct *proto = object;
        if (self.type == proto.type  &&
            [proto.protoProductName isEqualToString:self.protoProductName] &&
            ([self.timeStamp isEqualToDate:proto.timeStamp]||self.type == ProtoProductTypeUpgrade)) {
            return YES;
        }
    }
    return NO;
}

@end
