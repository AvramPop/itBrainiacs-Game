//
//  BDMarketContainerMenu.h
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDPlayer.h"
#import "BDTown.h"

@interface BDMarketContainerMenu : UIView

@property (nonatomic, assign) NSInteger numberOfAvaliableMerchants;

- (instancetype)initWithFrame:(CGRect)frame andNumberOfAvaliableMerchants:(NSInteger)numberOfAvaliableMerchants andTown:(BDTown* )town;

@end
