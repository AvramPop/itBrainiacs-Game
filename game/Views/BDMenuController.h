//
//  BDMenuController.h
//  game
//
//  Created by Bogdan Sala on 13/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBuilding.h"

@interface BDMenuController : NSObject

@property (nonatomic, weak) id delegate;

- (instancetype)initWithDecoratedView:(UIView *)decoratedView withMenuFrame:(CGRect)frame;

@end

@protocol BDMenuControllerDelegate <NSObject>

- (void)menu:(BDMenuController *)menu didSelectBuilding:(BDBuilding *)building;

@end