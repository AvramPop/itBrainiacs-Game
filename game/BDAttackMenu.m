//
//  BDBuildingMenu.m
//  game
//
//  Created by Bogdan Sala on 24/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDAttackMenu.h"
#import "BDUnit.h"
#import "BDPlayer.h"

@interface BDAttackMenu()

@property (nonatomic, strong) UIButton		*support;
@property (nonatomic, strong) UIButton      *attack;

@end

@implementation BDBuildingMenu

- (instancetype)initWithTroops:(NSDictionary *)troops andFrame:(CGRect)frame andTargetPlayer:(BDPlayer *)target andTargetTown(BDTown *)town{
    self = [super initWithFrame:frame];
    if(self) {
		UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Target: "];
		
		UILabel *targetTown = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(targetLabel.frame), 20, 150, 40)];
		targetLabel.text = town.name;
		
		UILabel *ownerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(targetLabel.frame), 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Owner: "];
		
		UILabel *ownerPlayer = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ownerLabel.frame), CGRectGetMaxY(targetLabel.frame), 150, 40)];
		targetLabel.text = target.name;
		
		UILabel *swordsmanLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Swordsman: "];
		
		UILabel *axemanLabel = [[UILabel alloc] initWithFrame:CGRectMake( , , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Axeman: "];
		
		UILabel *archerLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Archer: "];
		
		UILabel *lightCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 20, 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Light Cavalery: "];
		
		UILabel *heavyCavaleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Heavy Cavalery: "];
		
		UILabel *wizardLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Wizard: "];
		
		UILabel *ramLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 20, 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Ram: "];
		
		UILabel *catapultLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Catapult: "];
		
		UILabel *baloonLabel = [[UILabel alloc] initWithFrame:CGRectMake(, , 150, 40)];
		targetLabel.text = [NSString stringWithFormat:@"Baloon: "];
		
		UITextField *swordsmanValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(swordsmanLabel.frame), swordsmanLabel.frame.origin.y, 150, 40)];
		
		UITextField *axemanValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(axemanLabel.frame), axemanLabel.frame.origin.y, 150, 40)];
		
		UITextField *archerValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(archerLabel.frame), archerLabel.frame.origin.y, 150, 40)];
		
		UITextField *lightCavaleryValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lightCavaleryLabel.frame), lightCavaleryLabel.frame.origin.y, 150, 40)];
		
		UITextField *heavyCavaleryValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(heavyCavaleryLabel.frame), heavyCavaleryLabel.frame.origin.y, 150, 40)];
		
		UITextField *wizardValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wizardLabel.frame), wizardLabel.frame.origin.y, 150, 40)];
		
		UITextField *ramValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ramLabel.frame), ramLabel.frame.origin.y, 150, 40)];
		
		UITextField *catapultValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(catapultLabel.frame), catapultLabel.frame.origin.y, 150, 40)];
		
		UITextField *baloonValueField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(baloonLabel.frame), baloonLabel.frame.origin.y, 150, 40)];

		UIButton *swordsmanTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(swordsmanValueField.frame), swordsmanValueField.frame.origin.y, 150, 40)];
		[swordsmanTotalAmount setTitle:player.swordsmanNumber forState:UIControlStateNormal];
		[swordsmanTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *axemanTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(axeman.frame), axemanValueField.frame.origin.y, 150, 40)];
		[axemanTotalAmount setTitle:player.axemanNumber forState:UIControlStateNormal];
		[axemanTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *archerTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(archerValueField.frame), archerValueField.frame.origin.y, 150, 40)];
		[archerTotalAmount setTitle:player.archerNumber forState:UIControlStateNormal];
		[*archerTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *lightCavaleryTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lightCavaleryValueField.frame), lightCavaleryValueField.frame.origin.y, 150, 40)];
		[lightCavaleryTotalAmount setTitle:player.lightCavaleryNumber forState:UIControlStateNormal];
		[lightCavaleryTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *heavyCavaleryTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(heavyCavalery.frame), heavyCavaleryValueField.frame.origin.y, 150, 40)];
		[heavyCavaleryTotalAmount setTitle:player.heavyCavaleryNumber forState:UIControlStateNormal];
		[heavyCavaleryTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *wizardTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wizardValueField.frame), wizardValueField.frame.origin.y, 150, 40)];
		[wizardTotalAmount setTitle:player.wizardNumber forState:UIControlStateNormal];
		[wizardTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *ramTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ramValueField.frame), ramValueField.frame.origin.y, 150, 40)];
		[ramTotalAmount setTitleplayer.ramNumber forState:UIControlStateNormal];
		[ramTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *catapultTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(catapultValueField.frame), catapultValueField.frame.origin.y, 150, 40)];
		[catapultTotalAmount setTitleplayer.catapultNumber forState:UIControlStateNormal];
		[catapultTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *baloonTotalAmount = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(baloonValueField.frame), baloonValueField.frame.origin.y, 150, 40)];
		[baloonTotalAmount setTitleplayer.baloonNumber forState:UIControlStateNormal];
		[baloonTotalAmount addTarget:self action:@selector(addTotalValue:) forControlEvents:UIControlEventTouchUpInside];
		
		self.attack = [[UIButton alloc] initWithFrame:CGRectMake(, , 180, 75)];
        [self.attack setTitle:@"Attack!" forState:UIControlStateNormal];
        self.attack.backgroundColor =[UIColor redColor];
        [self.attack addTarget:self action:@selector(attackTown:) forControlEvents:UIControlEventTouchUpInside];
		 self.support = [[UIButton alloc] initWithFrame:CGRectMake(, , 180, 75)];
        [self.support setTitle:@"Support!" forState:UIControlStateNormal];
        self.support.backgroundColor =[UIColor greenColor];
        [self.support addTarget:self action:@selector(supportTown:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:targetLabel];
        [self addSubview:targetTown];
        [self addSubview:ownerLabel];
        [self addSubview:ownerPlayer];
        [self addSubview:swordsmanLabel];
        [self addSubview:axemanLabel];
		[self addSubview:archerLabel];
        [self addSubview:lightCavaleryLabel];
        [self addSubview:heavyCavaleryLabel];
		[self addSubview:wizardLabel];
        [self addSubview:ramLabel];
        [self addSubview:catapultLabel];
        [self addSubview:baloonLabel];
        [self addSubview:swordsmanValueField];
        [self addSubview:axemanValueField];
		[self addSubview:archerValueField];
        [self addSubview:lightCavaleryValueField];
        [self addSubview:heavyCavaleryValueField];
		[self addSubview:wizardValueField];
        [self addSubview:ramValueField];
        [self addSubview:catapultValueField];
        [self addSubview:baloonValueField];
		[self addSubview:swordsmanTotalAmount];
        [self addSubview:axemanTotalAmount];
		[self addSubview:archerTotalAmount];
        [self addSubview:lightCavaleryTotalAmount];
        [self addSubview:heavyCavaleryTotalAmount
		[self addSubview:wizardTotalAmount];
        [self addSubview:ramTotalAmount];
        [self addSubview:catapultTotalAmount];
        [self addSubview:baloonTotalAmount];
		[self addSubview:self.attack];
        [self addSubview:self.support];
	}
	return self;
}

- (void)attackTown:(UIButton *)button {
	/**/
}

- (void)supportTown:(UIButton *)button {
	/**/
}

- (void)addTotalValue:(UIButton *)button {
	
}