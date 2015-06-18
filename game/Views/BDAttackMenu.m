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
        UIColor *blueColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];
        self.backgroundColor = blueColor;
        
        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:16.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];
        
        UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 450, 40)];
        targetLabel.text = [NSString stringWithFormat:@"Target: %@", town.name];
        targetLabel.font = font;
        targetLabel.textColor = color;
        
        UILabel *ownerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(targetLabel.frame), 450, 40)];
        ownerLabel.text = [NSString stringWithFormat:@"Owner: %@", town.owner.name];
        ownerLabel.font = font;
        ownerLabel.textColor = color;
        
        self.units = @[[BDSwordsman new], [BDLightCavalery new], [BDRam new],
                        [BDAxeman new], [BDHighCavalery new], [BDCatapult new],
                        [BDArcher new], [BDWizard new], [BDBaloon new]];
        
        NSArray *unitNames = @[@[@"Swordsman:", @"Light Cavalery: ", @"Ram: "],
                               @[@"Axeman: ", @"Heavy Cavalery: ", @"Catapult: "],
                               @[@"Archer: ", @"Wizard: ", @"Baloon: "]];
        NSArray *unitNumber = @[@[@([self.player currentTown].swordsmanCount), @([self.player currentTown].lightCavaleryCount), @([self.player currentTown].ramCount)],
                               @[@([self.player currentTown].axemanCount), @([self.player currentTown].highCavaleryCount), @([self.player currentTown].catapultCount)],
                               @[@([self.player currentTown].archerCount), @([self.player currentTown].wizardCount), @([self.player currentTown].baloonCount)]];
        self.textFields = [NSMutableArray array];
        
        double width = self.frame.size.width / 6 - 10;
        font = [UIFont fontWithName:@"Supercell-magic" size:14.0];

        for(int i = 0; i < 3; i++) {
            for(int j = 0; j < 3; j++) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + j * self.frame.size.width / 3, (i + 2) *  self.frame.size.height / 6, width * 1.5, self.frame.size.height / 6)];
                label.text = unitNames[i][j];
                label.font = font;
                label.textColor = color;
                
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), (i + 2) * self.frame.size.height / 6 ,  width/4,  self.frame.size.height / 6)];
                textField.font = font;
                textField.textColor = color;
                [self.textFields addObject:textField];
                textField.tag = j + i*3;

                UIButton_Block *button = [[UIButton_Block alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame), (i + 2) * self.frame.size.height / 6, width/4,  self.frame.size.height / 6)];
                button.titleLabel.font = font;
                button.titleLabel.textColor = color;
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
        exitButton.titleLabel.font = font;
        
        UIButton *attackButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, self.frame.size.height - 100, 100, 100)];
        [attackButton setTitle:@"ATTACK" forState:UIControlStateNormal];
        attackButton.backgroundColor = [UIColor redColor];
        [attackButton addTarget:self action:@selector(attackTown:) forControlEvents:UIControlEventTouchUpInside];
        attackButton.titleLabel.font = font;
        
        [self addSubview:targetLabel];
        [self addSubview:ownerLabel];
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
         
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.firstOtherButtonIndex == buttonIndex) {
        
        NSMutableArray *def = [NSMutableArray  array];
        
        self.attackingTroops = [NSMutableArray array];
        NSInteger counter = 0;
        for (UITextField *textField in self.textFields) {
            BDSquad *squad = [[BDSquad alloc] init];
            squad.unit = self.units[textField.tag];
            squad.count = [textField.text integerValue];
            counter += squad.count;
            [self.attackingTroops addObject:squad];

            //naspa dar aste e... deocamdata
            [def addObject:squad];
        }
        BDSquad *sq = [BDSquad new];
        sq.unit = [BDSwordsman new];
        sq.count = self.defendingTown.swordsmanCount;
        [def removeObjectAtIndex:0];
        [def insertObject:sq atIndex:0];

        if (counter) {
            BDWarLogic *attacklogic = [[BDWarLogic alloc] initWithAttackingTroops:self.attackingTroops defendingTroops:def andDistance:[self getDistanceBetweenTownA:[self.player currentTown] andTownB:self.defendingTown]];
            NSAssert(attacklogic, @"dsfsdaf");
            [self didTouchExitButton];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"Cannot Attack Without Troops" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        }
    }
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

