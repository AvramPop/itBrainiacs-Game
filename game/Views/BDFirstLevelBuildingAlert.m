//
//  BDFirstLevelBuildingAlert.m
//  game
//
//  Created by Bogdan Sala on 17/06/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDFirstLevelBuildingAlert.h"


@implementation BDFirstLevelBuildingAlert

- (instancetype)initWithFrame:(CGRect)frame andBuilding:(BDBuilding *)building {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.building = building;
        
        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:15.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];
        UIColor *blueColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];
        
        self.backgroundColor = blueColor;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width /2 - 150, 10, 300, 30)];
        name.text = [NSString stringWithFormat:@"%@ cost:", self.building.name];
        name.font = font;
        name.textColor = color;
        name.textAlignment = NSTextAlignmentCenter;
        
        UILabel *gold = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width /2 - 150, CGRectGetMaxY(name.frame) + 15, 300, 30)];
        gold.text = [NSString stringWithFormat:@"Gold: %ld", self.building.goldCost];
        gold.font = font;
        gold.textColor = color;
        gold.textAlignment = NSTextAlignmentCenter;
        UILabel *iron = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width /2 - 150, CGRectGetMaxY(gold.frame) + 2, 300, 30)];
        iron.text = [NSString stringWithFormat:@"Iron: %ld", self.building.ironCost];
        iron.font = font;
        iron.textColor = color;
        iron.textAlignment = NSTextAlignmentCenter;
        UILabel *wood = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width /2 - 150, CGRectGetMaxY(iron.frame) + 2, 300, 30)];
        wood.text = [NSString stringWithFormat:@"Wood: %ld", self.building.woodCost];
        wood.font = font;
        wood.textColor = color;
        wood.textAlignment = NSTextAlignmentCenter;
        UILabel *people = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width /2 - 150, CGRectGetMaxY(wood.frame) + 2, 300, 30)];
        people.text = [NSString stringWithFormat:@"People: %ld", self.building.peopleCost];
        people.font = font;
        people.textColor = color;
        people.textAlignment = NSTextAlignmentCenter;
        self.yesButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 70, self.frame.size.width / 3, 70)];
        [self.yesButton setTitle:@"Build!" forState:UIControlStateNormal];
        [self.yesButton addTarget:self action:@selector(createBuilding) forControlEvents:UIControlEventTouchUpInside];
        self.yesButton.backgroundColor = [UIColor whiteColor];
        self.yesButton.titleLabel.font = font;
        [self.yesButton setTitleColor:color forState:UIControlStateNormal];
        
        self.noButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 2 / 3, self.frame.size.height - 70, self.frame.size.width / 3, 70)];
        [self.noButton setTitle:@"NO" forState:UIControlStateNormal];
        [self.noButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        self.noButton.backgroundColor = [UIColor whiteColor];
        self.noButton.titleLabel.font = font;
        [self.noButton setTitleColor:color forState:UIControlStateNormal];
        
        [self addSubview:self.noButton];
        [self addSubview:self.yesButton];
        [self addSubview:people];
        [self addSubview:gold];
        [self addSubview:iron];
        [self addSubview:wood];
        [self addSubview:name];
    }
    return self;
}

- (void)remove {
    [self removeFromSuperview];
}

- (void)createBuilding {
    [self.delegate didAcceptWithResponse:YES creationForBuilding:self.building];
    self.isCheckedYesButton = YES;
    [self removeFromSuperview];
}

@end
