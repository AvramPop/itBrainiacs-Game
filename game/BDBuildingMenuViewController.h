//
//  BDBuildingMenuViewController.h
//  game
//
//  Created by Bogdan Sala on 12/11/15.
//  Copyright © 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBuildingMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView    *buildingIcon;
@property (weak, nonatomic) IBOutlet UILabel        *productionLabel;
@property (weak, nonatomic) IBOutlet UILabel        *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel        *woodLabel;
@property (weak, nonatomic) IBOutlet UILabel        *buildingName;
@property (weak, nonatomic) IBOutlet UILabel        *ironLabel;
@property (weak, nonatomic) IBOutlet UILabel        *peopleLabel;
@property (weak, nonatomic) IBOutlet UIButton       *levelUpButton;
@property (weak, nonatomic) IBOutlet UILabel        *currentLevel;
@property (weak, nonatomic) IBOutlet UILabel        *timeToUpgrade;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
