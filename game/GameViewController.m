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

@interface GameViewController ()

@property (nonatomic, strong) UILabel *gold;
@property (nonatomic, strong) UILabel *wood;
@property (nonatomic, strong) UILabel *iron;

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
    NSError *error;
    ;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BDHeadquartersInfo" ofType:@"json"];
    NSString *dataStr = [[NSString alloc ] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    BDBuildingInfoParser *bdip = [[BDBuildingInfoParser alloc] initWithString:dataStr];
 
    
    NSMutableArray *array = [[self getSavedBuildings] mutableCopy];
    // Present the scene.
    if (array) {
        self.gameScene = [[BDMap alloc] initWithSize:skView.bounds.size andBuildings:array];
    } else {
        self.gameScene = [BDMap sceneWithSize:skView.bounds.size];
        BDHeadquarters *headquarter = [[BDHeadquarters alloc] init];
        [self.gameScene prepareToAddNode:headquarter];
    }
    
    
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    

    self.gameScene.tileSize = self.tileSize;
    
    [skView presentScene:self.gameScene];
    
    self.gameLogicController = [[BDGameLogicController alloc] initWithMap:self.gameScene];

    self.buildingsMenu = [[BDMenuController alloc] initWithDecoratedView:self.view withMenuFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 100)];
    self.buildingsMenu.delegate = self;
    
    [self addResourcesInfo];
    
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
    [self saveUserInfo];
}

- (void)addResourcesInfo{
    self.gold = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 75)];
    [self.view addSubview:self.gold];
    
    self.iron = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 75, 100, 75)];
    [self.view addSubview:self.iron];
    
    self.wood = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 150, 100, 75)];
    [self.view addSubview:self.wood];
}

- (void)saveUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = @{@"amountOfGold" : @([BDPlayer goldAmount]),
                                 @"amountOfIron" : @([BDPlayer ironAmount]),
                                 @"amountOfWood" : @([BDPlayer woodAmount])};
    
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
    [[NSUserDefaults standardUserDefaults] synchronize];
    return nil;
}


- (NSArray *)getSavedBuildings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *buildingsArray = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"map"]];
    return buildingsArray;
}

- (void) didTouchBuilding:(NSNotification *)notification{
    BDBuilding *building = notification.object;
    BDBuildingMenu *menu;
    CGFloat margin = 100;
    menu = [[BDBuildingMenu alloc] initWithBuilding:building andFrame: CGRectMake(100, 80, self.view.frame.size.width - 2*margin, self.view.frame.size.height - 2*margin)];
    menu.backgroundColor = [UIColor redColor];
    [self.view addSubview:menu];
}

@end
