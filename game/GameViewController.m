//
//  GameViewController.m
//  game
//
//  Created by Bogdan Sala on 29/01/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "GameViewController.h"
#import "BDBuilding.h"
#import "BDHeadquarters.h"
#import "BDMenu.h"
#import "BDMenuItem.h"
#import "BDPlayer.h"
#import "BDGameLogicController.h"
#import "BDMap.h"
#import "BDBuildingMenu.h"
#import "BDBuildingInfoParser.h"

@implementation SKScene (Unarchive) 

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@interface GameViewController () <BDGameLogicControllerDelegate>

@property (nonatomic, strong) UILabel *gold;
@property (nonatomic, strong) UILabel *wood;
@property (nonatomic, strong) UILabel *iron;
@property (nonatomic, strong) UILabel *people;

@property (nonatomic, copy) void (^confirmationBlock)();

@end

@implementation GameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTouchBuilding:) name:@"buildingWasTouched" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResourcesLabels) name:@"shouldUpdateResourcesUI" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveMapInfo) name:@"saveGame" object:nil];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    NSMutableArray *array = [[self getSavedBuildings] mutableCopy];
    // Present the scene.
    if (array) {
        self.gameScene = [[BDMap alloc] initWithSize:skView.bounds.size andBuildings:array];
    } else {
        self.gameScene = [BDMap sceneWithSize:skView.bounds.size];
        BDHeadquarters *headquarter = [[BDHeadquarters alloc] initWithImageNamed:@"Headquarters1"];
        [self.gameScene prepareToAddNode:headquarter];
    }
    
    
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;

    self.gameScene.tileSize = self.tileSize;
    
    [skView presentScene:self.gameScene];
    
    self.gameLogicController = [[BDGameLogicController alloc] initWithMap:self.gameScene];
    self.gameLogicController.delegate = self;

    self.buildingsMenu = [[BDMenuController alloc] initWithDecoratedView:self.view withMenuFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 100)];
    self.buildingsMenu.delegate = self;
    
    [self addResourcesInfo];
    self.gameScene.mapDelegate = self.gameLogicController;
 
    self.player = [self getSavedPlayer];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    [button setTitle:@"save" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveMapInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)menu:(BDMenu *)menu didSelectBuilding:(BDBuilding *)building {
    
    [self.gameScene prepareToAddNode:building];
}

- (void)updateResourcesLabels {
    self.gold.text = [NSString stringWithFormat:@"Gold: %ld", (long)[BDPlayer goldAmount]];
    self.iron.text = [NSString stringWithFormat:@"Iron: %ld", (long)[BDPlayer ironAmount]];
    self.wood.text = [NSString stringWithFormat:@"Wood: %ld", (long)[BDPlayer woodAmount]];
    self.people.text = [NSString stringWithFormat:@"People: %ld", (long)[BDPlayer peopleAmount]];

    [self saveUserInfo];
}

- (void)addResourcesInfo{
    self.gold = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 45)];
    [self.view addSubview:self.gold];
    
    self.iron = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, CGRectGetMaxY(self.gold.frame), 100, 45)];
    [self.view addSubview:self.iron];
    
    self.wood = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, CGRectGetMaxY(self.iron.frame), 100, 45)];
    [self.view addSubview:self.wood];
    
    self.people = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, CGRectGetMaxY(self.wood.frame), 100, 45)];
    [self.view addSubview:self.people];
}

- (void)saveUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = @{@"amountOfGold" : @([BDPlayer goldAmount]),
                                 @"amountOfIron" : @([BDPlayer ironAmount]),
                                 @"amountOfWood" : @([BDPlayer woodAmount]),
                                 @"amountOfPeople" : @([BDPlayer peopleAmount])
                                 };
    
    [userDefaults setObject:dictionary forKey:@"player"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveMapInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *buildingsData = [NSKeyedArchiver archivedDataWithRootObject:self.gameScene.buildings];
    [userDefaults setObject:buildingsData forKey:@"map"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BDPlayer *)getSavedPlayer {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefaults objectForKey:@"player"];
    [BDPlayer setGoldAmount:[dictionary[@"amountOfGold"] integerValue]];
    [BDPlayer setWoodAmount:[dictionary[@"amountOfWood"] integerValue]];
    [BDPlayer setIronAmount:[dictionary[@"amountOfIron"] integerValue]];
    [BDPlayer setPeopleAmount:[dictionary[@"amountOfPeople"] integerValue]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return nil;
}


- (NSArray *)getSavedBuildings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *buildingsArray = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"map"]];
    return buildingsArray;
}

- (void)didTouchBuilding:(NSNotification *)notification{
    BDBuilding *building = notification.object;
    BDBuildingMenu *menu;
    CGFloat margin = 100;
    menu = [[BDBuildingMenu alloc] initWithBuilding:building andFrame: CGRectMake(100, 80, self.view.frame.size.width - 2*margin, self.view.frame.size.height - 2*margin)];
    menu.delegate = self.gameLogicController;
    menu.backgroundColor = [UIColor redColor];
    [self.view addSubview:menu];
}

- (void)gameLogicController:(BDGameLogicController *)gameLogic requestUpdateForBuilding:(id)building withConfirmationBlock:(void (^)())block {
    self.confirmationBlock = block;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade" message:@"Are you sure you want to update?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}

- (void)gameLogicController:(BDGameLogicController *)gameLogicController notEnoughResourcesForBuilding:(BDBuilding *)building {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade" message:@"NOT ENOUGH MINERALS" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        self.confirmationBlock = nil;
    } else {
        self.confirmationBlock();
    }
}


@end
