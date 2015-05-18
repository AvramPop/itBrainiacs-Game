//
//  BDBuildingMenu.m
//  game
//
//  Created by Bogdan Sala on 20/03/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDBuildingMenu.h"
#import "BDBuilding.h"
#import "BDUnitInfoView.h"
#import "BDSwordsman.h"
#import "BDSquad.h"

@interface BDBuildingMenu() <BDUnitInfoViewDelegate>

@property (nonatomic, strong) UIImageView   *icon;
@property (nonatomic, strong) UIButton      *upgrade;
@property (nonatomic, strong) NSArray       *products;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) UIProgressView *prog;
@end

@implementation BDBuildingMenu

- (instancetype)initWithBuilding:(BDBuilding *)building andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.building = building;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishCreatingProtoProduct:) name:@"shouldUpdateBuildingUI" object:nil];

        UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];

        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 160)];
        self.icon.image = [UIImage imageNamed:building.iconName];
        self.icon.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 150, 40)];
        nameLabel.text = building.name;
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
        goldValue.text = [NSString stringWithFormat:@"%ld", (long)self.building.goldCost];
        UILabel *woodValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, woodLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        woodValue.text = [NSString stringWithFormat:@"%ld", (long)self.building.woodCost];
        UILabel *ironValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, ironLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        ironValue.text = [NSString stringWithFormat:@"%ld", (long)self.building.ironCost];
        UILabel *peopleValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, peopleLabel.frame.origin.y, 60, self.icon.frame.size.height / 4)];
        peopleValue.text = [NSString stringWithFormat:@"%ld", (long)self.building.peopleCost];

        CGFloat originY = CGRectGetMaxY(self.icon.frame) + 20;
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(self.icon.frame.origin.x, originY, self.frame.size.width - 100, self.frame.size.height - originY - 50)];
        container.backgroundColor = [UIColor greenColor];
        BDUnitInfoView *unitView = [[BDUnitInfoView alloc] initWithFrame:CGRectMake(10, 10, container.frame.size.width / 4, container.frame.size.height - 10) andUnit:[[BDSwordsman alloc] init]];
        unitView.delegate = self;
        unitView.backgroundColor = [UIColor yellowColor];
        [container addSubview:unitView];
        
        CGFloat upgradeButtonX = (self.frame.size.width - container.frame.size.width) / 2;
        self.upgrade = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - upgradeButtonX - 180, self.icon.frame.origin.y, 180, 75)];
        [self.upgrade setTitle:@"Upgrade" forState:UIControlStateNormal];
        self.upgrade.backgroundColor =[UIColor blueColor];
        [self.upgrade addTarget:self action:@selector(upgradeBuilding:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.building isUpgrading]){
            [self.upgrade setEnabled:NO];
            self.upgrade.backgroundColor =[UIColor grayColor];
        }
        UIImage *timeImage = [UIImage imageNamed:@"TimeIcon"];
        UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.upgrade.frame.origin.x, CGRectGetMaxY(self.upgrade.frame) + 20, self.upgrade.frame.size.width / 3, self.upgrade.frame.size.width / 3)];
        timeIcon.image = timeImage;
        
        UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIcon.frame) + 5, timeIcon.frame.origin.y, 2 * timeIcon.frame.size.width, timeIcon.frame.size.height)];
        timeValue.text = [NSString stringWithFormat:@"%ld", (long)self.building.timeCost];
        
        UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.upgrade.frame.origin.x, self.upgrade.frame.origin.y - 20, 50, 20)];
        levelLabel.text = [NSString stringWithFormat:@"%ld", (long)self.building.level];
        
        self.prog = [[UIProgressView alloc] initWithFrame:CGRectMake(40, 10, 100, 50)];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkTimer:) userInfo:nil repeats:YES];
        [self.timer fire];
        
        
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
        [self addSubview:nameLabel];
        [self addSubview:levelLabel];
        [self addSubview:self.prog];
    }
    return self;
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

- (void)upgradeBuilding:(UIButton *)button {
    [self.delegate buildingMenu:self didTouchUpdateButton:button withConfirmationBlock:^void {
        [self.upgrade setEnabled:NO];
        self.upgrade.backgroundColor = [UIColor grayColor];
    }];
}

- (void)checkTimer:(NSTimer *)timer{
    NSDate *date = [[NSDate alloc] init];
    if(self.building.protoProducts.count){
        CGFloat a, b;
        BDProtoProduct *proto = (BDProtoProduct *)self.building.protoProducts[0];
        BDUnit *unit = ([[NSClassFromString(proto.protoProductName) alloc] init]);
        a = unit.timeCost;
        b = [date timeIntervalSinceDate:[proto.timeStamp dateByAddingTimeInterval:-unit.timeCost]];
        self.prog.progress = b/a;
    }
}

- (BDBuilding *)buildingModel {
    return self.building;
}

- (void)didIncrementUnit:(BDUnit *)unit{
    [self.building.protoProducts addObject:[self protoProductWithUnit:unit]];
}

-(void)didDecrementUnit:(BDUnit *)unit{
    [self.building.protoProducts removeObject:[self protoProductWithUnit:unit]];

}

- (BDProtoProduct *)protoProductWithUnit:(BDUnit *)unit{
    BDProtoProduct *proto = [[unit class] protoProduct];
    NSDate *date = [NSDate date];
    proto.timeStamp = [date dateByAddingTimeInterval:unit.timeCost];
    proto.isResource = NO;
    proto.delegate = self.building;
    
    return proto;
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    self.prog.progress = 0;
}


@end
