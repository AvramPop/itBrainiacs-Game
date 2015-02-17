//
//  GameViewController.h
//  game
//

//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "BDMap.h"
#import "BDMenuController.h"

@interface GameViewController : UIViewController <BDMenuControllerDelegate>
@property (nonatomic, assign) CGSize tileSize;
@property (nonatomic, strong) BDMenuController *buildingsMenu;

@property (nonatomic, strong) BDMap *gameScene;

@end
