//
//  BDArmyMenu.m
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDArmyMenu.h"

@implementation BDArmyMenu

- (instancetype)initWithFrame:(CGRect)frame andPlayer:(BDPlayer *)player{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor blueColor];
        
        self.player = player;
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(65, 54, 300, 150)];
        message.text = [NSString stringWithFormat:@"Your army, my lord"];
        [message setFont:[UIFont fontWithName:@"Tom's Handwriting" size:60]];
        
        UILabel *swordsmanLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 164, 130, 44)];
        swordsmanLabel.text = [NSString stringWithFormat:@"Swordsmans: "];
        UILabel *swordsmanCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(swordsmanLabel.frame), swordsmanLabel.frame.origin.y, 130, 44)];
        swordsmanCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.swordsmanCount];
        
        UILabel *axemanLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(swordsmanLabel.frame), 130, 44)];
        axemanLabel.text = [NSString stringWithFormat:@"Axemans: "];
        UILabel *axemanCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(axemanLabel.frame), axemanLabel.frame.origin.y, 130, 44)];
        axemanCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.axemanCount];
        
        UILabel *archerLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(axemanLabel.frame), 130, 44)];
        archerLabel.text = [NSString stringWithFormat:@"Archers: "];
        UILabel *archerCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(archerLabel.frame), archerLabel.frame.origin.y, 130, 44)];
        archerCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.archerCount];
        
        UILabel *lightCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(archerLabel.frame), 130, 44)];
        lightCavaleryLabel.text = [NSString stringWithFormat:@"Light Cavalery: "];
        UILabel *lightCavaleryCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lightCavaleryLabel.frame), lightCavaleryLabel.frame.origin.y, 130, 44)];
        lightCavaleryCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.lightCavaleryCount];
        
        UILabel *heavyCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(lightCavaleryLabel.frame), 130, 44)];
        heavyCavaleryLabel.text = [NSString stringWithFormat:@"Heavy Cavalery: "];
        UILabel *heavyCavaleryCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(heavyCavaleryLabel.frame), heavyCavaleryLabel.frame.origin.y, 130, 44)];
        heavyCavaleryCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.highCavaleryCount];
        
        UILabel *wizardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(heavyCavaleryLabel.frame), 130, 44)];
        wizardLabel.text = [NSString stringWithFormat:@"Wizards: "];
        UILabel *wizardCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wizardLabel.frame), wizardLabel.frame.origin.y, 130, 44)];
        wizardCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.wizardCount];
        
        UILabel *ramLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(wizardLabel.frame), 130, 44)];
        ramLabel.text = [NSString stringWithFormat:@"Rams: "];
        UILabel *ramCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ramLabel.frame), ramLabel.frame.origin.y, 130, 44)];
        ramCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.ramCount];
        
        UILabel *catapultLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(ramLabel.frame), 130, 44)];
        catapultLabel.text = [NSString stringWithFormat:@"Catapults: "];
        UILabel *catapultCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(catapultLabel.frame), catapultLabel.frame.origin.y, 130, 44)];
        catapultCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.catapultCount];
        
        UILabel *baloonLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(catapultLabel.frame), 130, 44)];
        baloonLabel.text = [NSString stringWithFormat:@"Baloons: "];
        UILabel *baloonCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(baloonLabel.frame), baloonLabel.frame.origin.y, 130, 44)];
        baloonCount.text = [NSString stringWithFormat:@"%ld", (long)self.player.baloonCount];
        
        self.warButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 180, CGRectGetMaxY(self.frame) - 75, 180, 75)];
        [self.warButton setTitle:@"WAR!" forState:UIControlStateNormal];
        self.warButton.backgroundColor =[UIColor redColor];
        [self.warButton addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];
        
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
        [self addSubview:swordsmanCount];
        [self addSubview:axemanCount];
        [self addSubview:archerCount];
        [self addSubview:lightCavaleryCount];
        [self addSubview:heavyCavaleryCount];
        [self addSubview:wizardCount];
        [self addSubview:ramCount];
        [self addSubview:catapultCount];
        [self addSubview:baloonCount];
        [self addSubview:self.warButton];
    }
    return self;
}


-(void)goToMap:(UIButton *)button{
  //  BDAttackMap *map =  [[BDAttackMap alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

@end
