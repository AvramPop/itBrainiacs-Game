//
//  BDBuildingMenu.m
//  game
//
//  Created by Bogdan Sala on 20/03/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBuildingMenu.h"

@interface BDBuildingMenu()

@property (nonatomic, strong) UIImageView   *icon;
@property (nonatomic, strong) UIButton      *upgrade;
@property (nonatomic, strong) NSArray       *products;
@property (nonatomic, strong) BDBuilding    *building;

@end

@implementation BDBuildingMenu
//Review:SB plase use cammelCase for all names
//please use one line for one of only  a variable
- (instancetype)initWithBuilding:(BDBuilding *)building andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.building = building;
        UIView *container;
        UIButton *exitButton;
        exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        exitButton.backgroundColor = [UIColor whiteColor];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 160)];
        self.icon.backgroundColor = [UIColor blueColor];
        UIImageView *TimeIcon;
        UILabel *GoldLabel, *WoodLabel, *IronLabel, *PeopleLabel, *GoldValue, *WoodValue, *IronValue, *TimeValue, *PeopleValue;
        CGFloat a = CGRectGetMaxX(self.icon.frame);
        GoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(a + 15, self.icon.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        GoldLabel.text = [NSString stringWithFormat:@"Gold"];
        WoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(a + 15, CGRectGetMaxY(GoldLabel.frame), 60, self.icon.frame.size.height / 4)];
        WoodLabel.text = [NSString stringWithFormat:@"Wood"];
        IronLabel = [[UILabel alloc] initWithFrame:CGRectMake(a + 15, CGRectGetMaxY(WoodLabel.frame), 60, self.icon.frame.size.height / 4)];
        IronLabel.text = [NSString stringWithFormat:@"Iron"];
        PeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(a + 15, CGRectGetMaxY(IronLabel.frame), 60, self.icon.frame.size.height / 4)];
        PeopleLabel.text = [NSString stringWithFormat:@"People"];
        CGFloat originY = CGRectGetMaxY(self.icon.frame) + 20;
        container = [[UIView alloc] initWithFrame:CGRectMake(self.icon.frame.origin.x, originY, self.frame.size.width - 100, self.frame.size.height - originY - 50)];
        container.backgroundColor = [UIColor greenColor];
        CGFloat b = (self.frame.size.width - container.frame.size.width) / 2;
        self.upgrade = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - b - 180, self.icon.frame.origin.y, 180, 75)];
        [self.upgrade setTitle:@"Upgrade" forState:UIControlStateNormal];
        self.upgrade.backgroundColor =[UIColor blueColor];
        [self.upgrade addTarget:self action:@selector(upgradeBuilding) forControlEvents:UIControlEventTouchUpInside];
        UIImage *timeImage;
        timeImage = [UIImage imageNamed:@"TimeIcon"];
        TimeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.upgrade.frame.origin.x, CGRectGetMaxY(self.upgrade.frame) + 20, self.upgrade.frame.size.width / 3, self.upgrade.frame.size.width / 3)];
        TimeIcon.image = timeImage;
        TimeValue = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TimeIcon.frame) + 5, TimeIcon.frame.origin.y, 2 * TimeIcon.frame.size.width, TimeIcon.frame.size.height)];
        TimeValue.text = [NSString stringWithFormat:@"2 H"];
        [self addSubview:self.icon];
        [self addSubview:self.upgrade];
        [self addSubview:container];
        [self addSubview:GoldLabel];
        [self addSubview:WoodLabel];
        [self addSubview:IronLabel];
        [self addSubview:PeopleLabel];
        [self addSubview:TimeIcon];
        [self addSubview:TimeValue];
        [self addSubview:GoldValue];
        [self addSubview:WoodValue];
        [self addSubview:IronValue];
        [self addSubview:PeopleValue];
        [self addSubview:exitButton];
        
    }
    return self;
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

- (void)upgradeBuilding{
    //
}
@end
