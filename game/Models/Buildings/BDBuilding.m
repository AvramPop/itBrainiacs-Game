//
//  IBBuilding.m
//  game
//
//  Created by Bogdan Sala on 04/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBuilding.h"
#import "BDBuildingInfoParser.h"

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
    [self runAction:[SKAction playSoundFileNamed:@"tap-building.m4a" waitForCompletion:NO]];
    [self reactToTouch];
}

- (void)reactToTouch {
    NSDictionary *dictionaryBuilding = [self getJsonDictionary];
    if (dictionaryBuilding) {
        [self parse:dictionaryBuilding];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buildingWasTouched" object:self];
}

- (NSDictionary *)getJsonDictionary {
    NSLog(@"building %@", self.name);
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.name ofType:@"json"];
    if (path) {
        NSString *dataStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        NSDictionary *dictionaryBuilding = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        return dictionaryBuilding;
    }
    return nil;
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    [self.protoProducts removeObject:protoProduct];
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.level forKey:@"level"];
    [aCoder encodeObject:self.protoProducts forKey:@"protoProducts"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }

    self.level = [aDecoder decodeIntForKey:@"level"];
    self.protoProducts = [aDecoder decodeObjectForKey:@"protoProducts"];
    
    for (BDProtoProduct *protoProduct in self.protoProducts) {
        protoProduct.delegate = self;
    }
    self.userInteractionEnabled = YES;
    
    return self;
}

- (void)parse:(NSDictionary *)dictionary{
    NSArray *levels = dictionary[@"Level"];
    NSDictionary *currentLevel = levels[self.level];
    self.maxLevel = levels.count;
    NSDictionary *cost = currentLevel[@"Cost"];
    self.goldCost = [cost[@"goldCost"] integerValue];
    self.woodCost = [cost[@"woodCost"] integerValue];
    self.ironCost = [cost[@"ironCost"] integerValue];
    self.peopleCost = [cost[@"peopleCost"] integerValue];
    self.timeCost = [cost[@"timeCost"] integerValue];
    self.iconName = currentLevel[@"backgroundImage"];
    self.availableProtoProducts = currentLevel[@"products"];
    [self changeImage:[UIImage imageNamed:self.iconName]];
    self.buildingDescription = dictionary[@"Description"];
    self.points = [currentLevel[@"points"] integerValue];
}

- (BOOL)isUpgrading {
    return [self.protoProducts containsObject:[self.class upgradeProtoProduct]];
}

- (void)changeImage:(UIImage *)image {
    self.texture = [SKTexture textureWithImage:image];
}

@end



