//
//  BDHeadquarters.m
//  game
//
//  Created by Bogdan Sala on 05/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDHeadquarters.h"
#import "BDBuildingInfoParser.h"

@implementation BDHeadquarters

- (instancetype)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        self.name = @"headquarters";
        self.protoProducts = [NSMutableArray array];
    }
    return self;
}

- (void)reactToTouch {
//    [super reactToTouch]; display the building menu info
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTouchHeadQuartersMenu" object:nil];
}

- (NSArray *)protoProductsNames {
    return @[@"",@"", @""];
}


+ (BDProtoProduct *)upgradeProtoProduct{
    BDProtoProduct *proto = [[BDProtoProduct alloc] init];
    proto.protoProductName = @"BDHeadquartersUpgrade";
    proto.isResource = NO;
    
    return proto;
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    self.level++;
    [self.protoProducts removeObject:protoProduct];
    NSLog(@"didfinish Upgrade!!!!!!");
}

/*- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
  //parsezi in mod specific
    
    self.name = dictionary[@"name"];
}*/

@end
