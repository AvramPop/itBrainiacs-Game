//
//  BDAttackMenu.m
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDAttackMenu.h"
#import "BDUnit.h"
#import "BDPlayer.h"
#import "BDWarLogic.h"
#import "UIButton+Block.h"

@interface BDAttackMenu()

@property (nonatomic, strong) UIButton          *support;
@property (nonatomic, strong) UIButton          *attack;
@property (nonatomic, strong) NSMutableArray    *attackingTroops;
@property (nonatomic, strong) NSMutableArray    *textFields;
@property (nonatomic, strong) BDPlayer          *player;
@property (nonatomic, strong) BDTown            *defendingTown;

@end

@implementation BDAttackMenu

- (instancetype)initWithPlayer:(BDPlayer *)player andFrame:(CGRect)frame andTargetTown:(BDTown *)town {
    self = [super initWithFrame:frame];
    if (self) {
        self.player = player;
        self.defendingTown = town;
        self.backgroundColor = [UIColor blueColor];
        UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 150, 40)];
        targetLabel.text = [NSString stringWithFormat:@"Target: "];
        
        UILabel *targetTown = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(targetLabel.frame), 20, 150, 40)];
        targetLabel.text = town.name;
        
        UILabel *ownerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(targetLabel.frame), 150, 40)];
        targetLabel.text = [NSString stringWithFormat:@"Owner: "];
        
        UILabel *ownerPlayer = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ownerLabel.frame), CGRectGetMaxY(targetLabel.frame), 150, 40)];
        targetLabel.text = town.owner.name;
        
        NSArray *unitNames = @[@[@"Swordsman:", @"Light Cavalery: ", @"Ram: "],
                               @[@"Axeman: ", @"Heavy Cavalery: ", @"Catapult: "],
                               @[@"Archer: ", @"Wizard: ", @"Baloon: "]];
        NSArray *unitNumber = @[@[@(self.player.swordsmanCount), @(self.player.lightCavaleryCount), @(self.player.ramCount)],
                               @[@(self.player.axemanCount), @(self.player.highCavaleryCount), @(self.player.catapultCount)],
                               @[@(self.player.archerCount), @(self.player.wizardCount), @(self.player.baloonCount)]];
        
        for(int i = 0; i < 3; i++) {
            for(int j = 0; j < 3; j++) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j * self.frame.size.width / 3, (i + 2) * self.frame.size.height / 6 , self.frame.size.width / 6, self.frame.size.height / 6)];
                label.text = unitNames[i][j];
                
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), (i + 2) * self.frame.size.height / 6 ,  self.frame.size.width / 12,  self.frame.size.height / 6)];
                [self.textFields addObject:textField];
                textField.tag = i + j*3;

                UIButton_Block *button = [[UIButton_Block alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame), (i + 2) * self.frame.size.height / 6, self.frame.size.width / 12,  self.frame.size.height / 6)];
                __weak typeof(button) wutton = button;
                button.actionTouchUpInside = ^{
                    textField.text = wutton.titleLabel.text;
                };
                NSString *string = [NSString stringWithFormat:@"%@", unitNumber[i][j]];
                [button setTitle:string forState:UIControlStateNormal];
                [self addSubview:label];
                [self addSubview:textField];
                [self addSubview:button];
            }
        }
        
        UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:targetLabel];
        [self addSubview:targetTown];
        [self addSubview:ownerLabel];
        [self addSubview:ownerPlayer];
        [self addSubview:exitButton];
    }
    
    return self;
}
         
- (void)attackTown:(UIButton *)button {
    [[[UIAlertView alloc] initWithTitle:@"Are you sure?" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES!", nil] show];
}
         
- (void)supportTown:(UIButton *)button {
    /**/
}
        
- (void)addTotalValue:(NSInteger)value toUnit:(NSInteger)unit {
}
         
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.cancelButtonIndex == buttonIndex) {

        for (UITextField *textField in self.textFields) {
            self.attackingTroops[textField.tag] = @([textField.text integerValue]);
            
        }
        
        BDWarLogic *attacklogic = [[BDWarLogic alloc] initWithAttackingTroops:self.attackingTroops defendingTroops:[NSArray array]];
        attacklogic.defendingTroops = [NSArray array];
    }
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

@end

