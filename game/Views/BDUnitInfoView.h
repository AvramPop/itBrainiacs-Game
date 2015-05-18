//
//  BDUnitInfoView.h
//  game
//
//  Created by Bogdan Sala on 29/04/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDUnit, BDSquad;
@protocol BDUnitInfoViewDelegate;

@interface BDUnitInfoView : UIView

@property(nonatomic, strong)UIButton        *plusButton;
@property(nonatomic, strong)UIButton        *minusButton;
@property(nonatomic, strong)UIImageView     *unitImage;
@property(nonatomic, strong)UITextField     *fieldOfAmountOfUnitsToBeCreated;
@property(nonatomic, assign)NSInteger       amountOfUnitsToBeCreated;

@property(nonatomic, assign)id<BDUnitInfoViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame andUnit:(BDUnit *)unit;



@end


@protocol BDUnitInfoViewDelegate<NSObject>

-(void)didIncrementUnit:(BDUnit *)unit;
-(void)didDecrementUnit:(BDUnit *)unit;

@end