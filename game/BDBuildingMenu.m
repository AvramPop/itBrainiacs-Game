//
//  BDBuildingMenu.m
//  game
//
//  Created by Bogdan Sala on 20/03/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBuildingMenu.h"
#import "BDBuilding.h"

@interface BDBuildingMenu()

@property (nonatomic, strong) UIImageView   *icon;
@property (nonatomic, strong) UIButton      *upgrade;
@property (nonatomic, strong) NSArray       *products;

@end

@implementation BDBuildingMenu

- (instancetype)initWithBuilding:(BDBuilding *)building andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.building = building;
       
        UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];

        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 160)];
        self.icon.backgroundColor = [UIColor blueColor];
        
        CGFloat buttonsX = CGRectGetMaxX(self.icon.frame) + 15;
        UILabel *goldLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, self.icon.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        goldLabel.text = [NSString stringWithFormat:@"Gold"];
        UILabel *woodLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, CGRectGetMaxY(goldLabel.frame), 60, self.icon.frame.size.height / 4)];
        woodLabel.text = [NSString stringWithFormat:@"Wood"];
        UILabel *ironLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, CGRectGetMaxY(woodLabel.frame), 60, self.icon.frame.size.height / 4)];
        ironLabel.text = [NSString stringWithFormat:@"Iron"];
        UILabel *peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, CGRectGetMaxY(ironLabel.frame), 60, self.icon.frame.size.height / 4)];
        peopleLabel.text = [NSString stringWithFormat:@"People"];

        buttonsX = CGRectGetMaxX(goldLabel.frame);
        UILabel *goldValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, goldLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        goldValue.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.building.goldCost];
        UILabel *woodValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, woodLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        woodValue.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.building.woodCost];
        UILabel *ironValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, ironLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        ironValue.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.building.ironCost];
        UILabel *peopleValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, peopleLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        peopleValue.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.building.peopleCost];

        CGFloat originY = CGRectGetMaxY(self.icon.frame) + 20;
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(self.icon.frame.origin.x, originY, self.frame.size.width - 100, self.frame.size.height - originY - 50)];
        container.backgroundColor = [UIColor greenColor];
        
        CGFloat upgradeButtonX = (self.frame.size.width - container.frame.size.width) / 2;
        self.upgrade = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - upgradeButtonX - 180, self.icon.frame.origin.y, 180, 75)];
        [self.upgrade setTitle:@"Upgrade" forState:UIControlStateNormal];
        self.upgrade.backgroundColor =[UIColor blueColor];
        [self.upgrade addTarget:self action:@selector(upgradeBuilding:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *timeImage = [UIImage imageNamed:@"TimeIcon"];
        UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.upgrade.frame.origin.x, CGRectGetMaxY(self.upgrade.frame) + 20, self.upgrade.frame.size.width / 3, self.upgrade.frame.size.width / 3)];
        timeIcon.image = timeImage;
        
        UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIcon.frame) + 5, timeIcon.frame.origin.y, 2 * timeIcon.frame.size.width, timeIcon.frame.size.height)];
        timeValue.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.building.timeCost];
        
        [self addSubview:self.icon];
        [self addSubview:self.upgrade];
        [self addSubview:container];
        [self addSubview:goldLabel];
        [self addSubview:woodLabel];
        [self addSubview:ironLabel];
        [self addSubview:peopleLabel];
        [self addSubview:timeIcon];
        [self addSubview:timeValue];
        [self addSubview:goldValue];
        [self addSubview:woodValue];
        [self addSubview:ironValue];
        [self addSubview:peopleValue];
        [self addSubview:exitButton];
    }
    return self;
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

- (void)upgradeBuilding:(UIButton *)button {
    [self.delegate buildingMenu:self didTouchUpdateButton:button];
}

- (BDBuilding *)buildingModel {
    return self.building;
}
@end
