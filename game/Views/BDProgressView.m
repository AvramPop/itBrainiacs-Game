//
//  BDProgressView.m
//  game
//
//  Created by Bogdan Sala on 16/06/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDProgressView.h"

const NSTimeInterval kFMProgressViewReferenceDuration = 1.0;

@interface BDProgressView ()

@property (nonatomic, strong) UIImageView *trackImageView;
@property (nonatomic, strong) UIImageView *progressImageView;

@end

@interface BDProgressView (PrivateUICreation)

- (void)addTrackImageView;
- (void)addProgressImageView;

@end

@implementation BDProgressView

@dynamic trackColor;
@dynamic progressColor;
@dynamic trackImage;
@dynamic progressImage;

#pragma mark - Lifecycle

+ (BDProgressView *)progressViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.clipsToBounds = YES;
    
    [self addTrackImageView];
    [self addProgressImageView];
    
    return self;
}

- (void)dealloc {
    self.trackColor = nil;
    self.progressColor = nil;
    self.trackImage = nil;
    self.progressImage = nil;
    
    
}

#pragma mark - Properties

- (UIColor *)trackColor {
    return self.trackImageView.backgroundColor;
}

- (void)setTrackColor:(UIColor *)trackColor {
    self.trackImageView.backgroundColor = trackColor;
}

- (UIColor *)progressColor {
    return self.progressImageView.backgroundColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.progressImageView.backgroundColor = progressColor;
}

- (UIImage *)trackImage {
    return self.trackImageView.image;
}

- (void)setTrackImage:(UIImage *)trackImage {
    self.trackImageView.image = trackImage;
}

- (UIImage *)progressImage {
    return self.progressImageView.image;
}

- (void)setProgressImage:(UIImage *)progressImage {
    self.progressImageView.image = progressImage;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    
    [self setProgress:progress animated:NO];
}

#pragma mark - Public methods

- (void)setTrackOutlineColor:(UIColor *)trackOutlineColor andWidth:(CGFloat)width {
    [self.trackImageView.layer setBorderColor:[trackOutlineColor CGColor]];
    [self.trackImageView.layer setBorderWidth:width];
}

- (void)setProgressCornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
    [self.trackImageView.layer setCornerRadius:cornerRadius];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    float deltaProgress = fabsf(progress - self.progress);
    NSTimeInterval referenceDuration = kFMProgressViewReferenceDuration;
    
    if (animated) {
        NSTimeInterval duration = referenceDuration * deltaProgress;
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.progressImageView.frame = [self frameForCurrentProgress];
        } completion:NULL];
    } else {
        self.progressImageView.frame = [self frameForCurrentProgress];
    }
    _progress = progress;
}

#pragma mark - Protected methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.trackImageView.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    self.progressImageView.frame = [self frameForCurrentProgress];
}

#pragma mark - Private methods

- (CGRect)frameForCurrentProgress {
    float width = self.progress * self.bounds.size.width;
    
    return CGRectMake(0.0, 0.0, width, self.bounds.size.height);
}

- (void)addTrackImageView {
    self.trackImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.trackImageView];
}

- (void)addProgressImageView {
    self.progressImageView = [[UIImageView alloc] initWithFrame:[self frameForCurrentProgress]];
    [self addSubview:self.progressImageView];
}

@end

