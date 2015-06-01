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
#import "BDSwordsman.h"
#import "BDSquad.h"
#import "BDLightCavalery.h"
#import "BDAxeman.h"
#import "BDArcher.h"
#import "BDHighCavalery.h"
#import "BDSpy.h"
#import "BDWizard.h"
#import "BDRam.h"
#import "BDCatapult.h"
#import "BDBaloon.h"

@interface BDAttackMenu()

@property (nonatomic, strong) UIButton          *support;
@property (nonatomic, strong) UIButton          *attack;
@property (nonatomic, strong) NSMutableArray    *attackingTroops;
@property (nonatomic, strong) NSMutableArray    *textFields;
@property (nonatomic, strong) BDPlayer          *player;
@property (nonatomic, strong) BDTown            *defendingTown;

@property (nonatomic, strong) NSArray *units;

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
        
        self.units = @[[BDSwordsman new], [BDLightCavalery new], [BDRam new],
                               [BDAxeman new], [BDHighCavalery new], [BDCatapult new],
                               [BDArcher new], [BDWizard new], [BDBaloon new]];
        
        NSArray *unitNames = @[@[@"Swordsman:", @"Light Cavalery: ", @"Ram: "],
                               @[@"Axeman: ", @"Heavy Cavalery: ", @"Catapult: "],
                               @[@"Archer: ", @"Wizard: ", @"Baloon: "]];
        NSArray *unitNumber = @[@[@(self.player.swordsmanCount), @(self.player.lightCavaleryCount), @(self.player.ramCount)],
                               @[@(self.player.axemanCount), @(self.player.highCavaleryCount), @(self.player.catapultCount)],
                               @[@(self.player.archerCount), @(self.player.wizardCount), @(self.player.baloonCount)]];
        self.textFields = [NSMutableArray array];
        
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
        
        UIButton *attackButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, self.frame.size.height - 100, 100, 100)];
        [attackButton setTitle:@"ATTACK" forState:UIControlStateNormal];
        attackButton.backgroundColor = [UIColor redColor];
        [attackButton addTarget:self action:@selector(attackTown:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:targetLabel];
        [self addSubview:targetTown];
        [self addSubview:ownerLabel];
        [self addSubview:ownerPlayer];
        [self addSubview:exitButton];
        [self addSubview:attackButton];
    }
    
    return self;
}
         
- (void)attackTown:(UIButton *)button {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES!", nil];
    [alert show];
}
         
- (void)supportTown:(UIButton *)button {
    /**/
}
        
- (void)addTotalValue:(NSInteger)value toUnit:(NSInteger)unit {
    
}
         
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.firstOtherButtonIndex == buttonIndex) {
        
        NSMutableArray *def = [NSMutableArray  array];
        
        self.attackingTroops = [NSMutableArray array];
        for (UITextField *textField in self.textFields) {
            BDSquad *squad = [[BDSquad alloc] init];
            squad.unit = self.units[textField.tag];
            squad.count = [textField.text integerValue];
            [self.attackingTroops addObject:squad];

            //naspa dar aste e... deocamdata
            [def addObject:squad];
        }
        BDSquad *sq = [BDSquad new];
        sq.unit = [BDSwordsman new];
        sq.count = self.defendingTown.owner.swordsmanCount;
        [def removeObjectAtIndex:0];
        [def insertObject:sq atIndex:0];

        
        BDWarLogic *attacklogic = [[BDWarLogic alloc] initWithAttackingTroops:self.attackingTroops defendingTroops:def andDistance:[self getDistanceBetweenTownA:self.player.arrayOfTowns[0] andTownB:self.defendingTown]];
        attacklogic.defendingTroops = [NSArray array];
    }
    [self didTouchExitButton];
}

- (NSInteger)getDistanceBetweenTownA:(BDTown *)townA andTownB:(BDTown *)townB {
    NSInteger x = (townB.position.x - townA.position.x) * (townB.position.x - townA.position.x);
    NSInteger y = (townB.position.y - townA.position.y) * (townB.position.y - townA.position.y);
    return sqrt(x * x + y * y);
}

- (void)didTouchExitButton{
    [self removeFromSuperview];
}

@end

