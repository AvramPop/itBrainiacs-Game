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
#import "BDArmyMenu.h"
#import <QuartzCore/QuartzCore.h>

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

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel  *nameLabel;

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
    [BDPlayer setCurrentPlayer:[self getSavedPlayer]];
    self.player = [BDPlayer currentPlayer];
    
    
    // Present the scene.
//    UIAlertView *welcomeAlert = [[UIAlertView alloc] initWithTitle:@"Welcome to THE GAME!" message:@"Are you ready to rule?" delegate:self cancelButtonTitle:@"YES!" otherButtonTitles:nil];

    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.button.frame) + 100, 0, 100, 50)];
    self.nameLabel.text = self.player.name;
    
    if (array) {
        self.gameScene = [[BDMap alloc] initWithSize:skView.bounds.size andBuildings:array sceneSize:CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2)];
        if(self.player.name){
            [self.view addSubview:self.nameLabel];
        } else {
            UIAlertView *nameChoosingAlert = [[UIAlertView alloc] initWithTitle:@"Greetings, my lord!" message:@"Choose your name!" delegate:self cancelButtonTitle:@"Not now!" otherButtonTitles:@"Done!", nil];
            nameChoosingAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [nameChoosingAlert show];
        }
    } else {

        
//        UIAlertView *tutorial1 = [[UIAlertView alloc] initWithTitle:@"Tutorial" message:@"At first, place your headquarters with a simple tap :)" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
//        [tutorial1 show];
//        [nameChoosingAlert show];
//        [welcomeAlert show];
        self.gameScene = [BDMap sceneWithSize:skView.bounds.size];
        BDHeadquarters *headquarter = [[BDHeadquarters alloc] initWithImageNamed:@"Headquarters1"];
        [self.gameScene prepareToAddNode:headquarter];
        self.gameScene.backgroundSize = CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2);
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
 

    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    [self.button setTitle:@"save" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(saveMapInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];


    
    
    UIButton *armyButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 180, 100, 100)];
    armyButton.backgroundColor = [UIColor greenColor];
    [armyButton setTitle:@"Army" forState:UIControlStateNormal];
    [armyButton addTarget:self action:@selector(goToArmyView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:armyButton];
    
    UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 180, 100, 100)];
    mapButton.backgroundColor = [UIColor blueColor];
    [mapButton setTitle:@"Map" forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(goToAttackMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
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

-(void)goToArmyView {
    BDArmyMenu *menu = [[BDArmyMenu alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height) andPlayer:[BDPlayer currentPlayer]];
    [self.view addSubview:menu];
}

-(void)goToAttackMap {
    //
}

- (void)menu:(BDMenu *)menu didSelectBuilding:(BDBuilding *)building {
    
    [self.gameScene prepareToAddNode:building];
}

- (void)updateResourcesLabels {
    self.gold.text = [NSString stringWithFormat:@"Gold: %ld", (long)[BDPlayer currentPlayer].gold];
    self.iron.text = [NSString stringWithFormat:@"Iron: %ld", (long)[BDPlayer currentPlayer].iron];
    self.wood.text = [NSString stringWithFormat:@"Wood: %ld", (long)[BDPlayer currentPlayer].wood];
    self.people.text = [NSString stringWithFormat:@"People: %ld", (long)[BDPlayer currentPlayer].people];

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
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[BDPlayer currentPlayer]];
    [userDefaults setObject:data forKey:@"player"];
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
    BDPlayer *player = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"player"]];
    return player;
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


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == alertView.cancelButtonIndex) {
//        self.confirmationBlock = nil;
//    } else {
//        self.confirmationBlock();
//    }
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        self.player.name = name;
        self.nameLabel.text = name;
        [self.view addSubview:self.nameLabel];
       // NSLog(@"%@", self.player.name);
    }
}

@end
