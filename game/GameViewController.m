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
#import <AVFoundation/AVFoundation.h>
#import "BDFirstLevelBuildingAlert.h"
#import "BDAttackMap.h"
#import "BDAttackMapViewController.h"
#import "BDReportMenu.h"

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

@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTouchBuilding:) name:@"buildingWasTouched" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResourcesLabels) name:@"shouldUpdateResourcesUI" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didfinishWar:) name:@"didFinishWAR" object:nil];
    
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"background-sound" withExtension:@"m4a"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = YES;
    
    [BDPlayer setCurrentPlayer:[self getSavedPlayer]];
    self.player = [BDPlayer currentPlayer];
    [self.player currentTown].position = skView.center;
    // Present the scene.
//    UIAlertView *welcomeAlert = [[UIAlertView alloc] initWithTitle:@"Welcome to THE GAME!" message:@"Are you ready to rule?" delegate:self cancelButtonTitle:@"YES!" otherButtonTitles:nil];

    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    self.nameLabel.font = [UIFont fontWithName:@"Supercell-magic" size:20];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = [NSString stringWithFormat:@"%@       %ld", self.player.name, self.player.points];
    
    if (self.player.arrayOfTowns.count) {
        self.gameScene = [[BDMap alloc] initWithSize:skView.bounds.size andTown:self.player.arrayOfTowns[0] sceneSize:CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2)];
        [self.view addSubview:self.nameLabel];
    } else {

        
//        UIAlertView *tutorial1 = [[UIAlertView alloc] initWithTitle:@"Tutorial" message:@"At first, place your headquarters with a simple tap :)" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
//        [tutorial1 show];
//        [nameChoosingAlert show];
//        [welcomeAlert show];

        BDTown *homeTown = [[BDTown alloc] initWithPosition:skView.center imageName:@"Headquarters1" andType:BDTownTypeHuman];
        homeTown.owner = self.player;
        homeTown.gold = 1500;
        homeTown.iron = 1500;
        homeTown.wood = 1500;
        homeTown.people = 10;
        self.player.points = 100;
        self.player.arrayOfTowns = @[homeTown];
        self.gameScene = [[BDMap alloc] initWithSize:skView.bounds.size andTown:[self.player currentTown] sceneSize:CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2)];
        BDHeadquarters *headquarter = [[BDHeadquarters alloc] initWithImageNamed:@"Headquarters1"];
        [self.gameScene prepareToAddNode:headquarter];
        self.gameScene.backgroundSize = CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height *2);
        
        UIAlertView *nameChoosingAlert = [[UIAlertView alloc] initWithTitle:@"Greetings, my lord!" message:@"Choose your name!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Done!", nil];
        nameChoosingAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [nameChoosingAlert show];

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
     
    [self.view addSubview:self.button];

    UIButton *armyButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 180, 100, 100)];
    [armyButton setImage:[UIImage imageNamed:@"army-icon"] forState:UIControlStateNormal];
    [armyButton setTitle:@"Army" forState:UIControlStateNormal];
    [armyButton addTarget:self action:@selector(goToArmyView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:armyButton];

    UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 180, 100, 100)];
    [mapButton setImage:[UIImage imageNamed:@"war-map-icon3"] forState:UIControlStateNormal];
    [mapButton setTitle:@"Map" forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(goToAttackMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
    
    UIButton *reportButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(armyButton.frame) - 150, 40, 40)];
    [reportButton setImage:[UIImage imageNamed:@"report"] forState:UIControlStateNormal];
    [reportButton addTarget:self action:@selector(openReportsMenu) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:reportButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.backgroundMusicPlayer play];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)openReportsMenu {
    NSLog(@"fsdfds");
}

- (void)goToArmyView {
    BDArmyMenu *menu = [[BDArmyMenu alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height) andPlayer:[BDPlayer currentPlayer]];
    menu.controller = self.navigationController;
    [self.view addSubview:menu];
}

- (void)goToAttackMap {
    [self.backgroundMusicPlayer pause];
    BDAttackMapViewController *attackVC = [[BDAttackMapViewController alloc] init];
    [self.navigationController pushViewController:attackVC animated:YES];
}

- (void)menu:(BDMenu *)menu didSelectBuilding:(BDBuilding *)building {
    BDFirstLevelBuildingAlert *al = [[BDFirstLevelBuildingAlert alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 200, self.view.frame.size.height / 2 - 150, 400, 300) andBuilding:building];
    al.delegate = self;
    [self.view addSubview:al];
}

- (void)didAcceptWithResponse:(BOOL)response creationForBuilding:(BDBuilding *)building {
    if(response){
        if([self.player currentTown].gold >= building.goldCost &&
           [self.player currentTown].wood >= building.woodCost &&
           [self.player currentTown].iron >= building.ironCost &&
           [self.player currentTown].people >= building.peopleCost) {
            [self.gameScene prepareToAddNode:building];
            [self.player currentTown].gold -= building.goldCost;
            [self.player currentTown].wood -= building.woodCost;
            [self.player currentTown].iron -= building.ironCost;
            [self.player currentTown].people -= building.peopleCost;
            [self updateResourcesLabels];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Build" message:@"NOT ENOUGH MINERALS" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)updateResourcesLabels {
    self.gold.text = [NSString stringWithFormat:@"Gold: %ld", (long)[[BDPlayer currentPlayer] currentTown].gold];
    self.iron.text = [NSString stringWithFormat:@"Iron: %ld", (long)[[BDPlayer currentPlayer] currentTown].iron];
    self.wood.text = [NSString stringWithFormat:@"Wood: %ld", (long)[[BDPlayer currentPlayer] currentTown].wood];
    self.people.text = [NSString stringWithFormat:@"People: %ld", (long)[[BDPlayer currentPlayer] currentTown].people];
    self.nameLabel.text = [NSString stringWithFormat:@"%@       %ld", self.player.name, self.player.points];
}

- (void)addResourcesInfo {
    UIFont *font = [UIFont fontWithName:@"Supercell-magic" size:14.0];
    UIColor *color = [UIColor whiteColor];

    
    self.gold = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, 0, 150, 45)];
    self.gold.font = font;
    self.gold.textColor = color;
    [self.view addSubview:self.gold];
    
    self.iron = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, CGRectGetMaxY(self.gold.frame), 150, 45)];
    self.iron.font = font;
    self.iron.textColor = color;
    [self.view addSubview:self.iron];
    
    self.wood = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, CGRectGetMaxY(self.iron.frame), 150, 45)];
    self.wood.font = font;
    self.wood.textColor = color;
    [self.view addSubview:self.wood];
    
    self.people = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, CGRectGetMaxY(self.wood.frame), 150, 45)];
    self.people.font = font;
    self.people.textColor = color;
    [self.view addSubview:self.people];
}

- (BDPlayer *)getSavedPlayer {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BDPlayer *player = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"player"]];
    return player;
}

- (void)didTouchBuilding:(NSNotification *)notification{
    BDBuilding *building = notification.object;
    BDBuildingMenu *menu;
    CGFloat margin = 100;
    menu = [[BDBuildingMenu alloc] initWithBuilding:building andFrame:CGRectMake(100, 80, self.view.frame.size.width - 2*margin, self.view.frame.size.height - 2*margin)];
    menu.delegate = self.gameLogicController;
    menu.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    [self.view addSubview:menu];
}

- (void)gameLogicController:(BDGameLogicController *)gameLogic requestUpdateForBuilding:(id)building withConfirmationBlock:(void (^)())block {
    self.confirmationBlock = block;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade" message:@"Are you sure you want to update?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alertView.tag = 102;
    [alertView show];
}

- (void)gameLogicController:(BDGameLogicController *)gameLogicController notEnoughResourcesForBuilding:(BDBuilding *)building {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade" message:@"NOT ENOUGH MINERALS" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag != 102 && buttonIndex == alertView.firstOtherButtonIndex) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        self.player.name = name;
        self.nameLabel.text = name;
        [self.view addSubview:self.nameLabel];
    } else if (alertView.tag == 102 && buttonIndex == alertView.firstOtherButtonIndex){
        self.confirmationBlock();
    }
}

#pragma mark - notification 

- (void)didfinishWar:(NSNotification *)notification {
    double margin = 100;
    BDReportMenu *rpm = [[BDReportMenu alloc] initWithFrame:CGRectMake(100, 80, self.view.frame.size.width - 2*margin, self.view.frame.size.height - 2*margin) andDictionary:notification.userInfo];
    [self.view addSubview:rpm];
}

@end

