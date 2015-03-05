//
//  IBBuilding.m
//  game
//
//  Created by Bogdan Sala on 04/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBuilding.h"

@interface BDBuilding()

@property (nonatomic, strong) NSString *backgroundImageName;

@end


@implementation BDBuilding

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        self.level = 1;
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.backgroundImageName = name;
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithLevel:(int)level{
    self = [super init];
    if (self) {
        self.level = level;
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self reactToTouch];
}

- (void)reactToTouch {
    NSLog(@"building %@", self.name);
}


- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    [self.protoProducts removeObject:protoProduct];
}

- (NSArray *)protoProductsNames {
    return nil;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.uid forKey:@"uid"];
    [aCoder encodeInt:self.level forKey:@"level"];
    [aCoder encodeObject:self.backgroundImageName forKey:@"backgroundImageName"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithImageNamed:[aDecoder decodeObjectForKey:@"backgroundImageName"]];
    if (!self) {
        return nil;
    }
    
    self.uid = [aDecoder decodeIntForKey:@"uid"];
    self.backgroundImageName = [aDecoder decodeObjectForKey:@"backgroundImageName"];
    self.level = [aDecoder decodeIntForKey:@"level"];
    return self;
}

@end
