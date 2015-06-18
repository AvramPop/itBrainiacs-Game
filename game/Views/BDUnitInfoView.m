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

- (instancetype)initWithFrame:(CGRect)frame andUnit:(BDUnit *)unit {
    self = [super initWithFrame:frame];
    if(self){
        
        self.clipsToBounds = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishCreatingProtoProduct:) name:@"shouldUpdateBuildingUI" object:nil];
        
        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:16.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];
        UIColor *blueColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];
        
        self.unit = unit;
        self.unitImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height / 2)];
        self.unitImage.image = [UIImage imageNamed:unit.imageName];
        self.unitImage.contentMode = UIViewContentModeScaleAspectFit;
        
        self.plusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.unitImage.frame.origin.x, CGRectGetMaxY(self.unitImage.frame) + 10, self.unitImage.frame.size.width / 3, self.unitImage.frame.size.height / 3)];
        [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
        [self.plusButton addTarget:self action:@selector(increaseAmountOfUnits:) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton.backgroundColor = blueColor;
        self.plusButton.titleLabel.font = font;
        [self.plusButton setTitleColor:color forState:UIControlStateNormal];
        
        self.minusButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.plusButton.frame) + self.unitImage.frame.size.width / 3, CGRectGetMaxY(self.unitImage.frame) + 10, self.unitImage.frame.size.width / 3,                  self.unitImage.frame.size.height / 3)];
        [self.minusButton setTitle:@"-" forState:UIControlStateNormal];
        [self.minusButton addTarget:self action:@selector(decreaseAmountOfUnits:) forControlEvents:UIControlEventTouchUpInside];
        self.minusButton.backgroundColor = blueColor;
        [self.minusButton setTitleColor:color forState:UIControlStateNormal];

        self.fieldOfAmountOfUnitsToBeCreated = [[UITextField alloc] initWithFrame:CGRectMake(self.unitImage.frame.origin.x, CGRectGetMaxY(self.plusButton.frame) + 10, self.unitImage.frame.size.width, self.unitImage.frame.size.height / 5)];
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)self.amountOfUnitsToBeCreated]];
        self.fieldOfAmountOfUnitsToBeCreated.textAlignment = NSTextAlignmentCenter;
        self.fieldOfAmountOfUnitsToBeCreated.font = [UIFont fontWithName:@"Supercell-magic" size:14.0];
        UILabel *nameLabel = nil;
        
        if (!unit.imageName) {
            nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, 60)];
            nameLabel.text = unit.name;
        }

        self.prog = [BDProgressView progressViewWithFrame:CGRectMake(10, CGRectGetMaxY(self.fieldOfAmountOfUnitsToBeCreated.frame) + 10, self.frame.size.width - 20, 10)];
        [self.prog setProgressCornerRadius:5];
        [self.prog setProgressColor:color];
        [self.prog setTrackColor:[UIColor clearColor]];
        [self.prog setTrackOutlineColor:blueColor andWidth:1];

        [self addSubview:self.unitImage];
        [self addSubview:self.plusButton];
        [self addSubview:self.minusButton];
        [self addSubview:self.fieldOfAmountOfUnitsToBeCreated];
        [self addSubview:nameLabel];
        [self addSubview:self.prog];

    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)increaseAmountOfUnits:(UIButton *)button{
    if([self hasEnoughResouces:self.amountOfUnitsToBeCreated + 1]) {
        self.amountOfUnitsToBeCreated++;
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)self.amountOfUnitsToBeCreated]];
        [self.delegate didIncrementUnit:self.unit];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Not enough resources for THAT amount of units!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

- (void)decreaseAmountOfUnits:(UIButton *)button{
    if(self.amountOfUnitsToBeCreated > 1) {
        self.amountOfUnitsToBeCreated--;
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)self.amountOfUnitsToBeCreated]];
        self.fieldOfAmountOfUnitsToBeCreated.textAlignment = NSTextAlignmentCenter;
        [self.delegate didDecrementUnit:self.unit];
    }
}

- (BOOL)hasEnoughResouces:(NSInteger)count{
#ifndef DebugEnabled
    if (count * self.unit.woodCost >= [[BDPlayer currentPlayer] currentTown].wood &&
        count * self.unit.goldCost >= [[BDPlayer currentPlayer] currentTown].gold &&
        count * self.unit.ironCost >= [[BDPlayer currentPlayer] currentTown].iron &&
        count * self.unit.peopleCost >= [[BDPlayer currentPlayer] currentTown].people) {
        return NO;
    }
#else
    return YES;
#endif
}

- (void)didFinishCreatingProtoProduct:(NSNotification *)notification {
    NSDictionary *dictionary = [notification userInfo];
    BDProtoProduct *protoProduct = dictionary[@"BDProtoProduct"];
    if ([[[self.unit class] protoProduct].protoProductName isEqual:protoProduct.protoProductName]) {
        [self.fieldOfAmountOfUnitsToBeCreated setText:[NSString stringWithFormat:@"%ld", (long)--self.amountOfUnitsToBeCreated]];
    };
}

@end
