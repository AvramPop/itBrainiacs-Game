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
#import "BDGoldMine.h"
#import "BDHouse.h"
#import "BDPlayer.h"
#import "BDMarketContainerMenu.h"

@interface BDBuildingMenu() <BDUnitInfoViewDelegate>

@property (nonatomic, strong) UIImageView   *icon;
@property (nonatomic, strong) UIButton      *upgrade;
@property (nonatomic, strong) NSArray       *products;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) UILabel       *levelLabel;
@property (nonatomic, strong) UILabel       *goldValue;
@property (nonatomic, strong) UILabel       *woodValue;
@property (nonatomic, strong) UILabel       *ironValue;
@property (nonatomic, strong) UILabel       *peopleValue;
@property (nonatomic, strong) UILabel       *timeValue;
@property (nonatomic, strong) UILabel       *production;
@property (nonatomic, strong) UILabel       *descriptionLabel;

@property (nonatomic, strong) NSMutableDictionary       *dictOfUnitViews;

@property (nonatomic, strong) UIScrollView  *container;

@end

@implementation BDBuildingMenu

- (instancetype)initWithBuilding:(BDBuilding *)building andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.building = building;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishCreatingProtoProduct:) name:@"shouldUpdateBuildingUI" object:nil];
        
        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:15.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];
        UIColor *blueColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];

        UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [exitButton setTitle:@"X" forState:UIControlStateNormal];
        [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(didTouchExitButton) forControlEvents:UIControlEventTouchUpInside];
        exitButton.titleLabel.font = font;
        
        UIImageView *sparkel = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 260, 220)];
        sparkel.image = [UIImage imageNamed:@"sparkel"];
        sparkel.contentMode = UIViewContentModeScaleAspectFit;
        sparkel.alpha = 0.3;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 160)];
        self.icon.image = [UIImage imageNamed:building.iconName];
        self.icon.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 150, 40)];
        nameLabel.text = building.name;
        nameLabel.font = font;
        nameLabel.textColor = color;
        
        CGFloat buttonsX = CGRectGetMaxX(self.icon.frame) + 15;
        self.goldValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, self.icon.frame.origin.y, 300, self.icon.frame.size.height / 4)];
        self.goldValue.font = font;
        self.goldValue.textColor = color;
        self.woodValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, CGRectGetMaxY(self.goldValue.frame), 300, self.icon.frame.size.height / 4)];
        self.woodValue.font = font;
        self.woodValue.textColor = color;
        self.ironValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, CGRectGetMaxY(self.woodValue.frame), 300, self.icon.frame.size.height / 4)];
        self.ironValue.font = font;
        self.ironValue.textColor = color;
        self.peopleValue = [[UILabel alloc] initWithFrame:CGRectMake(buttonsX, CGRectGetMaxY(self.ironValue.frame), 300, self.icon.frame.size.height / 4)];
        self.peopleValue.font = font;
        self.peopleValue.textColor = color;

        CGFloat originY = CGRectGetMaxY(self.icon.frame) + 20;
        self.container = [[UIScrollView alloc] initWithFrame:CGRectMake(self.icon.frame.origin.x, originY, self.frame.size.width - 100, self.frame.size.height - originY - 50)];
        self.container.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.container.frame.size.width - 20, self.container.frame.size.height - 20)];
        self.descriptionLabel.font = font;
        self.descriptionLabel.textColor = blueColor;
        self.descriptionLabel.numberOfLines = 0;
        [self.container addSubview:self.descriptionLabel];
        
        CGFloat upgradeButtonX = (self.frame.size.width - self.container.frame.size.width) / 2;
        self.upgrade = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - upgradeButtonX - 180, self.icon.frame.origin.y, 180, 75)];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Level +"];
        NSRange range = [@"Level +" rangeOfString:@"+"];
        [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Supercell-magic" size:20.0] range:range];
        [self.upgrade setAttributedTitle:title forState:UIControlStateNormal];
        self.upgrade.titleLabel.font = font;
        self.upgrade.titleLabel.textColor = color;
        self.upgrade.backgroundColor = blueColor;
        [self.upgrade addTarget:self action:@selector(upgradeBuilding:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.building isUpgrading]) {
            [self.upgrade setEnabled:NO];
            self.upgrade.backgroundColor = [UIColor colorWithRed:30/255.0 green:32/255.0 blue:40/255.0 alpha:1];
        }
        
        UIImage *timeImage = [UIImage imageNamed:@"time-icon1"];
        UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.upgrade.frame.origin.x, CGRectGetMaxY(self.upgrade.frame) + 20, self.upgrade.frame.size.width / 3, self.upgrade.frame.size.width / 3)];
        timeIcon.image = timeImage;
        
        self.timeValue = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIcon.frame) + 5, timeIcon.frame.origin.y, 2 * timeIcon.frame.size.width, timeIcon.frame.size.height)];
        self.timeValue.font = font;
        self.timeValue.textColor = color;
        
        self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.upgrade.frame.origin.x, self.upgrade.frame.origin.y - 20, self.upgrade.frame.size.width, 20)];
        self.levelLabel.font = font;
        self.levelLabel.textColor = color;
        
        self.progress = [BDProgressView progressViewWithFrame:CGRectMake(self.container.frame.origin.x, CGRectGetMaxY(self.container.frame) + 25, self.container.frame.size.width, 10)];
        [self.progress setProgressCornerRadius:5];
        [self.progress setProgressColor:[UIColor colorWithRed:30/255.0 green:32/255.0 blue:40/255.0 alpha:1]];
        [self.progress setTrackColor:[UIColor clearColor]];
        [self.progress setTrackOutlineColor:[UIColor colorWithRed:30/255.0 green:32/255.0 blue:40/255.0 alpha:1] andWidth:1];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkTimer:) userInfo:nil repeats:YES];
        [self.timer fire];
        self.dictOfUnitViews = [NSMutableDictionary dictionary];
        
        self.production = [[UILabel alloc] initWithFrame:CGRectMake(self.goldValue.frame.origin.x, self.goldValue.frame.origin.y - self.icon.frame.size.height / 4, 300, self.icon.frame.size.height / 4)];
        self.production.font = font;
        self.production.textColor = color;
        if ([self.building respondsToSelector:NSSelectorFromString(@"productionPerHour")]) {
            [self addSubview:self.production];
        }
        
        if ([self.building respondsToSelector:NSSelectorFromString(@"peopleProduced")]) {
            [self addSubview:self.production];
        }
        
        [self refreshUI];
        [self addSubview:sparkel];
        [self addSubview:self.icon];
        [self addSubview:self.upgrade];
        [self addSubview:self.container];
        [self addSubview:timeIcon];
        [self addSubview:self.timeValue];
        [self addSubview:self.goldValue];
        [self addSubview:self.woodValue];
        [self addSubview:self.ironValue];
        [self addSubview:self.peopleValue];
        [self addSubview:exitButton];
        [self addSubview:nameLabel];
        [self addSubview:self.levelLabel];
        [self addSubview:self.progress];
    }
    return self;
}



- (void)didTouchExitButton{
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        if ([proto isEqual:[self.building.class upgradeProtoProduct]]) {
            a = self.building.timeCost;
            b = [date timeIntervalSinceDate:[proto.timeStamp dateByAddingTimeInterval:-a]];
            double progress = b/a;

            self.progress.progress = progress;
        } else {
            BDUnit *unit = ([[NSClassFromString(proto.protoProductName) alloc] init]);
            a = unit.timeCost;
            b = [date timeIntervalSinceDate:[proto.timeStamp dateByAddingTimeInterval:-a]];
            double progress = b/a;
            BDUnitInfoView *unitView = self.dictOfUnitViews[proto.protoProductName];
            [unitView.prog setProgress:progress animated:YES];
        }
    }
}

- (BDBuilding *)buildingModel {
    return self.building;
}

- (void)didIncrementUnit:(BDUnit *)unit{
    [self.building.protoProducts addObject:[self protoProductWithUnit:unit]];
}

-(void)didDecrementUnit:(BDUnit *)unit{
    [self.building.protoProducts removeObject:[self lastProtoProduct]];
}

- (BDProtoProduct *)protoProductWithUnit:(BDUnit *)unit{
    BDProtoProduct *proto = [[unit class] protoProduct];
    
    BDProtoProduct *currentProto = [self.building.protoProducts lastObject];
     NSDate *date = [NSDate date];
    if (currentProto) {
        date = currentProto.timeStamp;
    }
    proto.timeStamp = [date dateByAddingTimeInterval:unit.timeCost];
    proto.type = ProtoProductTypeUnit;
    proto.delegate = self.building;
    
    return proto;
}

- (BDProtoProduct *)lastProtoProduct {
    return [self.building.protoProducts lastObject];
}

- (void)didFinishCreatingProtoProduct:(NSNotification *)notification {
    NSDictionary *dictionary = [notification userInfo];
    BDProtoProduct *protoProduct = dictionary[@"BDProtoProduct"];
    
    if ([protoProduct isEqual:[self.building.class upgradeProtoProduct]]) {
        self.progress.progress = 0;
        [self.upgrade setEnabled:YES];
        [self.building runAction:[SKAction playSoundFileNamed:@"upgrade-finished.m4r" waitForCompletion:NO]];
        [BDPlayer currentPlayer].points += self.building.points;
    } else {
        BDUnitInfoView *unitView = self.dictOfUnitViews[protoProduct.protoProductName];
        unitView.prog.progress = 0;
    }
    [self refreshUI];
}

- (void)refreshUI {
    self.levelLabel.text = [NSString stringWithFormat:@"Level: %ld", (long)self.building.level + 1];
    self.goldValue.text = [NSString stringWithFormat:@"Gold: %ld", (long)self.building.goldCost];
    self.woodValue.text = [NSString stringWithFormat:@"Wood: %ld", (long)self.building.woodCost];
    self.ironValue.text = [NSString stringWithFormat:@"Iron: %ld", (long)self.building.ironCost];
    self.peopleValue.text = [NSString stringWithFormat:@"People: %ld", (long)self.building.peopleCost];
    self.icon.image = [UIImage imageNamed:self.building.iconName];
    self.timeValue.text = [NSString stringWithFormat:@"%ld", (long)self.building.timeCost];
    [self.upgrade setEnabled:self.building.maxLevel > self.building.level];
    
    
    if ([self.building respondsToSelector:NSSelectorFromString(@"productionPerHour")]) {
        self.production.text = [NSString stringWithFormat:@"Production/hour: %ld", (long)((BDGoldMine *)self.building).productionPerHour];
    }
    
    if ([self.building respondsToSelector:NSSelectorFromString(@"peopleProduced")]) {
        self.production.text = [NSString stringWithFormat:@"People produced: %ld", (long)((BDHouse *)self.building).peopleProduced];
    }
    
	if ([self.building respondsToSelector:NSSelectorFromString(@"merchantsProduced")]) {
        self.production.text = [NSString stringWithFormat:@"Merchants produced: %ld", (long)((BDMarket.building).merchantsProduced];
    }
	
    NSMutableDictionary *productsValue = [NSMutableDictionary dictionary];
    for (BDProtoProduct *proto in self.building.protoProducts) {
        NSNumber *value = productsValue[proto.protoProductName];
        value = @([value integerValue] + 1);
        productsValue[proto.protoProductName] = value;
    }
    
    int i = 0;
    float infoViewWidth = self.container.frame.size.width  / 4 + 10;
    self.container.contentSize = CGSizeMake(self.building.availableProtoProducts.count * infoViewWidth + 10, self.container.frame.size.height);
    NSArray *availableProto = self.building.availableProtoProducts;
    
    if (!availableProto.count  && ![self.building.name isEqualToString: @"market"]) {
        self.descriptionLabel.hidden = NO;
        [self.descriptionLabel setText:self.building.buildingDescription];
    } else if([self.building.name isEqualToString: @"market"]){
        self.descriptionLabel.hidden = YES;
        BDMarketContainerMenu *m = [BDMarketContainerMenu alloc] initWithFrame:CGRectMake(self.container.frame.origin.x, self.container.frame.origin.y, self.container.frame.size.width, self.container.frame.size.height) andNumberOfAvaliableMerchants:(NSInteger)10 andTown:(BDTown*)self.town];
    } else {
        self.descriptionLabel.hidden = YES;
        for (NSString *unitClassName in availableProto) {
            if (!self.dictOfUnitViews[unitClassName]) {
                BDUnit *unit = [[NSClassFromString(unitClassName) alloc] init];
                
                BDUnitInfoView *unitView = [[BDUnitInfoView alloc] initWithFrame:CGRectMake(10 + infoViewWidth * i, 10, infoViewWidth - 10, self.container.frame.size.height - 20) andUnit:unit];
                unitView.delegate = self;
                unitView.backgroundColor = [UIColor clearColor];
                unitView.layer.borderColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0].CGColor;
                unitView.layer.borderWidth = 1;
                
                NSNumber *numberOfUnits = productsValue[unitClassName];
                unitView.amountOfUnitsToBeCreated = [numberOfUnits integerValue];
                
                [self.container addSubview:unitView];
                [self.dictOfUnitViews setObject:unitView forKey:unitClassName];
            }
            i++;
        }
    }
}

@end
