//
//  BDGameLogicController.m
//  game
//
//  Created by Bogdan Sala on 23/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDGameLogicController.h"
#import "BDBuilding.h"
#import "BDProtoProduct.h"
#import "BDPlayer.h"

@interface BDGameLogicController()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) BDMap *map;

@end

@implementation BDGameLogicController

- (instancetype)initWithMap:(BDMap *)map {
    self = [super init];
    if(self){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkTimer:) userInfo:nil repeats:YES];
        [self.timer fire];
        self.map = map;
    }
    return self;
}

- (void)checkTimer:(NSTimer *)timer{
    NSDate *date = [[NSDate alloc] init];
    NSArray *buildings = self.map.buildings;
    BOOL hasResourcesUpdate = NO;
    for (BDBuilding *BDB in buildings) {
        NSArray *protoProducts = [NSArray arrayWithArray:BDB.protoProducts];
        for (BDProtoProduct *product in protoProducts) {
            if ([date compare:product.timeStamp] == NSOrderedDescending) {
                if (product.isResource) {
                    hasResourcesUpdate = YES;
                    if ([product.protoProductName compare:@"BDGold"] == NSOrderedSame) {
                        [BDPlayer incrementGold];
                    } else if ([product.protoProductName compare:@"BDIron"] == NSOrderedSame) {
                        [BDPlayer incrementIron];
                    } else if ([product.protoProductName compare:@"BDWood"] == NSOrderedSame) {
                        [BDPlayer incrementWood];
                    }
                } else {
                    //the product is not a resource is a unit or a building of something else.
                }
                [product.delegate didFinishCreatingProtoProduct:product];
            }
        }
    }
    
    if (hasResourcesUpdate) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldUpdateResourcesUI" object:nil];
    }
}

@end

