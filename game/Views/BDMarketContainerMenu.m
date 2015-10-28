//
//  BDMarketContainerMenu.m
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDMarketContainerMenu.h"
#import "BDAttackMapViewController.h"
#import "UIButton+Block.h"

@interface BDMarketContainerMenu ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIButton *dealButton;
@property (nonatomic, strong) BDTown   *town;
@property (nonatomic, strong) UITextField   *forTextField;
@property (nonatomic, strong) NSArray       *pickerData;
@property (nonatomic, assign) NSInteger resToExchange;
@property (nonatomic, assign) NSInteger resToReceive;
@property (nonatomic, strong) UILabel   *needTextField;

@property (nonatomic, strong) UIButton *woodButton;
@property (nonatomic, strong) UIButton *forLabel;
@property (nonatomic, strong) UIButton *offerLabel;

@end

@implementation BDMarketContainerMenu

- (instancetype)initWithFrame:(CGRect)frame andNumberOfAvaliableMerchants:(NSInteger)numberOfAvaliableMerchants andTown:(BDTown* )town {
    self = [super initWithFrame:frame];
    if(self) {
        UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:16.0];
        UIColor *color = [UIColor colorWithRed:1.0 green:191.0/255.0 blue:78.0/255.0 alpha:1];
        UIColor *blueColor = [UIColor colorWithRed:10/255.0 green:154/255.0 blue:191/255.0 alpha:1.0];

        self.numberOfAvaliableMerchants = numberOfAvaliableMerchants;
        self.backgroundColor = blueColor;
        self.town = town;

        self.dealButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 100, self.frame.size.height - 70, 80, 50)];
        [self.dealButton setTitle:@"Deal!" forState:UIControlStateNormal];
        [self.dealButton addTarget:self action:@selector(makeExchange) forControlEvents:UIControlEventTouchUpInside];
        [self.dealButton setTitleColor: blueColor forState:UIControlStateNormal];
        self.dealButton.backgroundColor = color;
        self.dealButton.titleLabel.font = font;

        UILabel *forLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 100, 60)];
        forLabel.text = @"FOR";
        forLabel.font = font; 
        forLabel.textColor = color;
        
        UILabel *offerLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(forLabel.frame) + 50, 180, 60)];
        offerLabel.text = @"Merchants offer";
        offerLabel.font = font; 
        offerLabel.textColor = color;

        self.forTextField = [[UITextField alloc] initWithFrame:CGRectMake(forLabel.frame.size.width + 30, CGRectGetMaxY(forLabel.frame), 100, forLabel.frame.size.height)];
        self.forTextField.font = font;
        self.forTextField.textColor = color;

        UIButton_Block *woodButton = [[UIButton_Block alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.forTextField.frame), self.forTextField.frame.origin.y, self.forTextField.frame.size.width, self.forTextField.frame.size.height)];
        woodButton.titleLabel.font = font;
        woodButton.titleLabel.textColor = color;
        __weak typeof(woodButton) wutton = woodButton;
        woodButton.actionTouchUpInside = ^{
               self.forTextField.text = wutton.titleLabel.text;
        };
        NSString *string = [NSString stringWithFormat:@"(%ld)", self.numberOfAvaliableMerchants * 1000 ];
        [woodButton setTitle:string forState:UIControlStateNormal];

        self.pickerData = @[@"wood", @"gold", @"iron"];

        UIPickerView *pic1 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(woodButton.frame) + 100, woodButton.frame.origin.y, 200, 100)];

        pic1.dataSource = self;
        pic1.delegate = self;
        pic1.tag = 1;

        UIPickerView *pic2 = [[UIPickerView alloc] initWithFrame:CGRectMake(pic1.frame.origin.x, CGRectGetMaxY(pic1.frame), 200, 100)];

        pic2.dataSource = self;
        pic2.delegate = self;
        pic2.tag = 2;

        self.needTextField = [[UILabel alloc] initWithFrame:CGRectMake(offerLabel.frame.size.width + 30, CGRectGetMaxY(offerLabel.frame), 100, offerLabel.frame.size.height)];
        self.needTextField.font = font;
        self.needTextField.textColor = color;

        [self addSubview:self.needTextField];
        [self addSubview:self.forTextField];
        [self addSubview:pic1];
        [self addSubview:self.woodButton];
        [self addSubview:self.dealButton];
        [self addSubview:self.forLabel];
        [self addSubview:self.offerLabel];
    }
    return self;
}

- (void)makeExchange {
//    if ((self.resToExchange == 0 && [self.forTextField.text intValue] > self.town.wood) || (self.resToExchange == 1 && [self.forTextField intValue] > self.town.gold) || (self.resToExchange == 2 && [self.forTextField intValue] > self.town.iron)) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You do not have enought resources" message:nil delegate:self cancelButtonTitle:@"Maybe later..." otherButtonTitles: nil];
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deal?" message:nil delegate:self cancelButtonTitle:@"Maybe later..." otherButtonTitles:@"DEAL!", nil];
//    }
//    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.firstOtherButtonIndex == buttonIndex) {
        if(self.resToExchange == 0){
            self.town.wood -= [self.forTextField.text intValue];
            if(self.resToReceive == 1){
                self.town.gold += [self.needTextField.text intValue];
            } else {
                self.town.iron += [self.needTextField.text intValue];
            }
        } else if(self.resToExchange == 1){
            self.town.gold -= [self.forTextField.text intValue];
            if(self.resToReceive == 0){
                self.town.wood += [self.needTextField.text intValue];
            } else {
                self.town.iron += [self.needTextField.text intValue];
            }
        } else {
            self.town.iron -= [self.forTextField.text intValue];
            if(self.resToReceive == 0){
                self.town.wood += [self.needTextField.text intValue];
            } else {
                self.town.gold += [self.needTextField.text intValue];
            }
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.needTextField.text = [NSString stringWithFormat:@"%f", [self.forTextField.text intValue] * 0.85];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}
 
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView.tag == 1) {
        self.resToExchange = row;
    } else {
        self.resToReceive = row;
    }
}

@end

