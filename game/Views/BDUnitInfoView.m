//
//  BDUnitInfoView.m
//  game
//
//  Created by Bogdan Sala on 29/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDUnitInfoView.h"
#import "BDUnit.h"
#import "BDPlayer.h"
#import "BDSquad.h"

@interface BDUnitInfoView ()

@property (nonatomic, strong) BDUnit *unit;

@end

@implementation BDUnitInfoView

-(instancetype)initWithFrame:(CGRect)frame andUnit:(BDUnit *)unit {
    self = [super initWithFrame:frame];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishCreatingProtoProduct:) name:@"shouldUpdateBuildingUI" object:nil];

        self.unit = unit;
        self.unitImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height / 2)];
        self.unitImage.image = [UIImage imageNamed:unit.imageName];
        
        self.plusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.unitImage.frame.origin.x, CGRectGetMaxY(self.unitImage.frame) + 10, self.unitImage.frame.size.width / 3, self.unitImage.frame.size.height / 3)];
        [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
        [self.plusButton addTarget:self action:@selector(increaseAmountOfUnits:) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton.backgroundColor = [UIColor redColor];
        
        self.minusButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.plusButton.frame) + self.unitImage.frame.size.width / 3, CGRectGetMaxY(self.unitImage.frame) + 10, self.unitImage.frame.size.width / 3,                  self.unitImage.frame.size.height / 3)];
        [self.minusButton setTitle:@"-" forState:UIControlStateNormal];
        [self.minusButton addTarget:self action:@selector(decreaseAmountOfUnits:) forControlEvents:UIControlEventTouchUpInside];
        self.minusButton.backgroundColor = [UIColor redColor];
        
        self.fieldOfAmountOfUnitsToBeCreated = [[UITextField alloc] initWithFrame:CGRectMake(self.unitImage.frame.origin.x, CGRectGetMaxY(self.plusButton.frame) + 10, self.unitImage.frame.size.width, self.unitImage.frame.size.height / 5)];
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)self.amountOfUnitsToBeCreated]];
        self.fieldOfAmountOfUnitsToBeCreated.textAlignment = NSTextAlignmentCenter;
        self.fieldOfAmountOfUnitsToBeCreated.backgroundColor = [UIColor blueColor];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        nameLabel.text = @"Swordsman";
        
        [self addSubview:self.unitImage];
        [self addSubview:self.plusButton];
        [self addSubview:self.minusButton];
        [self addSubview:self.fieldOfAmountOfUnitsToBeCreated];
        [self addSubview:nameLabel];
    }
    return self;
}

-(void)increaseAmountOfUnits:(UIButton *)button{
    if([self hasEnoughResouces:self.amountOfUnitsToBeCreated + 1]) {
        self.amountOfUnitsToBeCreated++;
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)self.amountOfUnitsToBeCreated]];
        [self.delegate didIncrementUnit:self.unit];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Not enough resources for THAT amount of units!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

-(void)decreaseAmountOfUnits:(UIButton *)button{
    if(self.amountOfUnitsToBeCreated > 1) {
        self.amountOfUnitsToBeCreated--;
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)self.amountOfUnitsToBeCreated]];
        self.fieldOfAmountOfUnitsToBeCreated.textAlignment = NSTextAlignmentCenter;
    }
}

-(BOOL)hasEnoughResouces:(NSInteger)count{
    if (count * self.unit.woodCost >= [BDPlayer currentPlayer].wood &&
        count * self.unit.goldCost >= [BDPlayer currentPlayer].gold &&
        count * self.unit.ironCost >= [BDPlayer currentPlayer].iron &&
        count * self.unit.peopleCost >= [BDPlayer currentPlayer].people) {
        return NO;
    }
    return YES;
}

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct {
    [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)--self.amountOfUnitsToBeCreated]];
}

@end
