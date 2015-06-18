//
//  BDReportMenu.m
//  game
//
//  Created by Bogdan Sala on 17/06/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDReportMenu.h"
#import "BDSquad.h"

@interface BDReportMenu ()

@end

@implementation BDReportMenu

- (instancetype)initWithFrame:(CGRect)frame andDictionary:(NSDictionary *)userInfo {
    self = [super initWithFrame:frame];
    if(self) {
        NSArray *arrayAtacking = userInfo[@"armyAttacking"];
        NSArray *arrayReturning = userInfo[@"armyReturning"];
        NSString *winner = userInfo[@"winner"];
        NSNumber *stolenRes = [userInfo objectForKey:@"resources"];
        NSInteger a = [stolenRes integerValue];

        self.backgroundColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];
        
        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:17.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];
        
        UILabel *winnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame), 10, 300, 35)];
        if([winner isEqualToString:@"attackers"]){
            winnerLabel.text = @"You have won!";
        } else {
            winnerLabel.text = @"You have lost :(";
        }
        winnerLabel.font = [UIFont fontWithName:@"Supercell-magic" size:25.0];
        winnerLabel.textColor = color;
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 600, 150)];
        message.text = [NSString stringWithFormat:@"Stolen resources: %ld", a];
        message.font = font;
        message.textColor = color;
        
        UILabel *went = [[UILabel alloc] initWithFrame:CGRectMake(300, 120, 70, 45)];
        went.text = @"Went";
        went.font = font;
        went.textColor = color;
        
        UILabel *came = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(went.frame) + 15, 120, 300, 44)];
        came.text = @"Returned";
        came.font = font;
        came.textColor = color;
        
        BDSquad *sa = arrayAtacking[0];
        BDSquad *sr = arrayReturning[0];
        
        UILabel *swordsmanLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 164, 600, 44)];
        swordsmanLabel.text = [NSString stringWithFormat:@"Swordsmans:            %ld                %ld", sa.count, sr.count];
        swordsmanLabel.font = font;
        swordsmanLabel.textColor = color;
        
        sa = arrayAtacking[3];
        sr = arrayReturning[3];
        
        UILabel *axemanLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(swordsmanLabel.frame), 600, 44)];
        axemanLabel.text = [NSString stringWithFormat:@"Axemans:                   %ld                 %ld", sa.count, sr.count];
        axemanLabel.font = font;
        axemanLabel.textColor = color;
        
        sa = arrayAtacking[6];
        sr = arrayReturning[6];
        
        UILabel *archerLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(axemanLabel.frame), 600, 44)];
        archerLabel.text = [NSString stringWithFormat:@"Archers:                    %ld                %ld",sa.count, sr.count];
        archerLabel.font = font;
        archerLabel.textColor = color;
        
        sa = arrayAtacking[1];
        sr = arrayReturning[1];
        
        UILabel *lightCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(archerLabel.frame), 600, 44)];
        lightCavaleryLabel.text = [NSString stringWithFormat:@"Light Cavalery:         %ld                %ld",sa.count, sr.count];
        lightCavaleryLabel.font = font;
        lightCavaleryLabel.textColor = color;
        
        sa = arrayAtacking[4];
        sr = arrayReturning[4];
        
        UILabel *heavyCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(lightCavaleryLabel.frame), 600, 44)];
        heavyCavaleryLabel.text = [NSString stringWithFormat:@"Heavy Cavalery:        %ld               %ld",sa.count, sr.count];
        heavyCavaleryLabel.font = font;
        heavyCavaleryLabel.textColor = color;
        
        sa = arrayAtacking[7];
        sr = arrayReturning[7];
        
        UILabel *wizardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(heavyCavaleryLabel.frame), 600, 44)];
        wizardLabel.text = [NSString stringWithFormat:@"Wizards:                     %ld                %ld",sa.count, sr.count];
        wizardLabel.font = font;
        wizardLabel.textColor = color;
        
        sa = arrayAtacking[2];
        sr = arrayReturning[2];
        
        UILabel *ramLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(wizardLabel.frame), 600, 44)];
        ramLabel.text = [NSString stringWithFormat:@"Rams:                           %ld               %ld",sa.count, sr.count];
        ramLabel.font = font;
        ramLabel.textColor = color;
        
        sa = arrayAtacking[5];
        sr = arrayReturning[5];
        
        UILabel *catapultLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(ramLabel.frame), 600, 44)];
        catapultLabel.text = [NSString stringWithFormat:@"Catapults:                   %ld               %ld", sa.count, sr.count];
        catapultLabel.font = font;
        catapultLabel.textColor = color;
        
        sa = arrayAtacking[8];
        sr = arrayReturning[8];
        
        UILabel *baloonLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(catapultLabel.frame), 600, 44)];
        baloonLabel.text = [NSString stringWithFormat:@"Baloons:                      %ld                %ld", sa.count, sr.count];
        baloonLabel.font = font;
        baloonLabel.textColor = color;
        
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
        [self addSubview:winnerLabel];
        [self addSubview:went];
        [self addSubview:came];
    }
    return self;
}


- (void)didTouchExitButton{
    [self removeFromSuperview];
}

@end
