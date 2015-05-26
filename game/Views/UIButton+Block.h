//
//  UIButton+Block.h
//  game
//
//  Created by Bogdan Sala on 22/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton_Block : UIButton

@property (nonatomic, strong) void(^actionTouchUpInside)();

@end
