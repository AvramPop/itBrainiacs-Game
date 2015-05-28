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


@interface BDAttackMapViewController ()

@property (nonatomic, strong) BDAttackMap *mapAttack;

@end

@implementation BDAttackMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView * skView = (SKView *)self.view;
    self.mapAttack = [[BDAttackMap alloc] initWithSize:skView.bounds.size andTowns:nil sceneSize:CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTouchTown:) name:@"townWasTouched" object:nil];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SKView * skView = (SKView *)self.view;

    self.mapAttack.size = skView.frame.size;
    [skView presentScene:self.mapAttack];
    
    UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 180, 100, 100)];
    mapButton.backgroundColor = [UIColor blueColor];
    [mapButton setTitle:@"Map" forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(didTouchBackToTown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
}

- (IBAction)didTouchBackToTown:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didTouchTown:(NSNotification *)notification {
    self.targetTown = notification.userInfo[@"town"];
    
    if (self.targetTown) {
        NSLog(@"merge");
        CGFloat margin = 100;
        BDAttackMenu *menu = [[BDAttackMenu alloc] initWithPlayer:[BDPlayer currentPlayer] andFrame:CGRectMake(100, 80, self.view.frame.size.width - 2*margin, self.view.frame.size.height - 2*margin) andTargetTown:self.targetTown];
        [self.view addSubview:menu];
    }
    
}

@end
