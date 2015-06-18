//
//  BDAttackMapViewController.m
//  game
//
//  Created by Bogdan Sala on 24/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDAttackMapViewController.h"
#import "BDAttackMap.h"
#import "BDAttackMenu.h"
#import "BDPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface BDAttackMapViewController ()

@property (nonatomic, strong) BDAttackMap   *mapAttack;
@property (nonatomic) AVAudioPlayer         *backgroundMusicPlayer;

@end

@implementation BDAttackMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"ClashofClans_ringtone1" withExtension:@"m4r"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTouchTown:) name:@"townWasTouched" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SKView * skView = (SKView *)self.view;
    self.mapAttack = [[BDAttackMap alloc] initWithSize:skView.bounds.size andTowns:nil sceneSize:CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2)];
    [skView presentScene:self.mapAttack];
    
    UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:30.0];
    UIColor *color = [UIColor whiteColor];
    
    UILabel *map = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-150, 30, 300, 50)];
    map.textAlignment = NSTextAlignmentCenter;
    map.font = font;
    map.textColor = color;
    map.text = @"Map";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
    backButton.center = CGPointMake(backButton.center.x, map.center.y);
    [backButton setImage:[UIImage imageNamed:@"icon-back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didTouchBackToTown:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:map];
    [self.view addSubview:backButton];
}

- (IBAction)didTouchBackToTown:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTouchTown:(NSNotification *)notification {
    self.targetTown = notification.userInfo[@"town"];

    if ([self.targetTown isEqual:[[BDPlayer currentPlayer] currentTown]]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (self.targetTown) {
        CGFloat margin = 100;
        BDAttackMenu *menu = [[BDAttackMenu alloc] initWithPlayer:[BDPlayer currentPlayer] andFrame:CGRectMake(100, 80, self.view.frame.size.width - 2*margin, self.view.frame.size.height - 2*margin) andTargetTown:self.targetTown];
        [self.view addSubview:menu];
    }
    
}

@end
