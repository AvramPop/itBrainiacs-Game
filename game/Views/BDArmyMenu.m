//
//  BDArmyMenu.m
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDArmyMenu.h"
#import "BDAttackMapViewController.h"

@interface BDArmyMenu ()
@end

@implementation BDArmyMenu

- (instancetype)initWithFrame:(CGRect)frame andPlayer:(BDPlayer *)player{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];
        
        self.player = player;

        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:17.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];

        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(65, 54, 300, 150)];
        message.text = [NSString stringWithFormat:@"Your army, my lord"];
        message.font = font;
        message.textColor = color;
        
        UILabel *swordsmanLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 164, 300, 44)];
        swordsmanLabel.text = [NSString stringWithFormat:@"Swordsmans: %ld", (long)[self.player currentTown].swordsmanCount];
        swordsmanLabel.font = font;
        swordsmanLabel.textColor = color;
        
        UILabel *axemanLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(swordsmanLabel.frame), 300, 44)];
        axemanLabel.text = [NSString stringWithFormat:@"Axemans: %ld", (long)[self.player currentTown].axemanCount];
        axemanLabel.font = font;
        axemanLabel.textColor = color;
        
        UILabel *archerLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(axemanLabel.frame), 300, 44)];
        archerLabel.text = [NSString stringWithFormat:@"Archers: %ld", (long)[self.player currentTown].archerCount];
        archerLabel.font = font;
        archerLabel.textColor = color;
        
        UILabel *lightCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(archerLabel.frame), 300, 44)];
        lightCavaleryLabel.text = [NSString stringWithFormat:@"Light Cavalery: %ld", (long)[self.player currentTown].lightCavaleryCount];
        lightCavaleryLabel.font = font;
        lightCavaleryLabel.textColor = color;
        
        UILabel *heavyCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(lightCavaleryLabel.frame), 300, 44)];
        heavyCavaleryLabel.text = [NSString stringWithFormat:@"Heavy Cavalery: %ld", (long)[self.player currentTown].highCavaleryCount];
        heavyCavaleryLabel.font = font;
        heavyCavaleryLabel.textColor = color;
        
        UILabel *wizardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(heavyCavaleryLabel.frame), 300, 44)];
        wizardLabel.text = [NSString stringWithFormat:@"Wizards: %ld", (long)[self.player currentTown].wizardCount];
        wizardLabel.font = font;
        wizardLabel.textColor = color;
        
        UILabel *ramLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(wizardLabel.frame), 300, 44)];
        ramLabel.text = [NSString stringWithFormat:@"Rams: %ld", (long)[self.player currentTown].ramCount];
        ramLabel.font = font;
        ramLabel.textColor = color;
        
        UILabel *catapultLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(ramLabel.frame), 300, 44)];
        catapultLabel.text = [NSString stringWithFormat:@"Catapults: %ld", (long)[self.player currentTown].catapultCount];
        catapultLabel.font = font;
        catapultLabel.textColor = color;
        
        UILabel *baloonLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(catapultLabel.frame), 300, 44)];
        baloonLabel.text = [NSString stringWithFormat:@"Baloons: %ld", (long)[self.player currentTown].baloonCount];
        baloonLabel.font = font;
        baloonLabel.textColor = color;
        
        self.warButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 180, CGRectGetMaxY(self.frame) - 75, 180, 75)];
        [self.warButton setTitle:@"WAR!" forState:UIControlStateNormal];
        self.warButton.backgroundColor = [UIColor redColor];
        [self.warButton addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
        [self.warButton.titleLabel setFont:font];
        
        UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];
        [exitButton.titleLabel setFont:font];
        
        [self addSubview:exitButton];
        [self addSubview:message];
        [self addSubview:swordsmanLabel];
        [self addSubview:axemanLabel];
        [self addSubview:archerLabel];
        [self addSubview:lightCavaleryLabel];
        [self addSubview:heavyCavaleryLabel];
        [self addSubview:wizardLabel];
        [self addSubview:ramLabel];
        [self addSubview:catapultLabel];
        [self addSubview:baloonLabel];

        [self addSubview:self.warButton];
    }
    return self;
}

-(void)goToMap:(UIButton *)button {
    UINavigationController *a = self.controller;
    BDAttackMapViewController *attackVC = [[BDAttackMapViewController alloc] init];
    [a pushViewController:attackVC animated:YES];
    [self removeFromSuperview];
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

@end
