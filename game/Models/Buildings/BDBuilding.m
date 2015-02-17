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
    }
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    
    self.backgroundImageName = name;
    
    return self;
}

- (instancetype)initWithLevel:(int)level{
    self = [super init];
    if (self) {
        self.level = level;
    }
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self reactToTouch];
}

- (void)reactToTouch {
    NSLog(@"building %@", self.name);
}



@end
