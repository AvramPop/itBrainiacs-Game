//
//  BDProgressView.h
//  game
//
//  Created by Bogdan Sala on 16/06/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIImage *trackImage;
@property (nonatomic, strong) UIImage *progressImage;

+ (BDProgressView *)progressViewWithFrame:(CGRect)frame;

- (void)setProgress:(float)progress animated:(BOOL)animated;

- (void)setProgressCornerRadius:(CGFloat)cornerRadius;
- (void)setTrackOutlineColor:(UIColor *)trackOutlineColor andWidth:(CGFloat)width;

@end
