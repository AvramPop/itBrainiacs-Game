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

@implementation GameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    BDMap *scene = [BDMap sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    UIImage *image = [self steachBackgroundImagesForOrientation:UIInterfaceOrientationPortrait];
    scene.backgroundImage = image;
    // Present the scene.
    self.gameScene = scene;
    self.gameScene.tileSize = self.tileSize;
    BDHeadquarters *headquarter = [[BDHeadquarters alloc] init];
    [self.gameScene prepareToAddNode:headquarter];
    
    self.buildingsMenu = [[BDMenuController alloc] initWithDecoratedView:self.view withMenuFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 100)];
    self.buildingsMenu.delegate = self;
    
    [skView presentScene:scene];
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

- (UIImage *)steachBackgroundImagesForOrientation:(UIInterfaceOrientation)orientation {
    
    int x, y;
    UIImage *tile1 = [UIImage imageNamed:@"tileset1.png"];
    UIImage *tile2 = [UIImage imageNamed:@"tileset2.png"];
    
    self.tileSize = tile1.size;
    
    int tileWidth = self.tileSize.width;
    int tileHeight = self.tileSize.height;
    
    UIImage *finalImage = [[UIImage alloc] init];
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 CGRectGetWidth(self.view.frame),
                                                 CGRectGetHeight(self.view.frame),
                                                 CGImageGetBitsPerComponent(tile1.CGImage),
                                                 0, //auto computed
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    int i = 0;
    
#ifdef TouchDebug
    UIFont *helvetica11 = [UIFont fontWithName:@"Helvetica" size:9];
#endif
    for (y = - tileHeight / 2; y <= self.view.frame.size.height; y = y + tileHeight / 2) {
        for (x = (y % tileHeight == 0 ? 0 : -tileWidth / 2); x < self.view.frame.size.width; x = x + tileWidth) {
            UIImage *currentImage;
            if (y % tileHeight == 0){
                currentImage = tile1;
            } else {
                currentImage = tile2;
            }
            CGRect frame = CGRectMake(x, y, tileWidth, tileHeight);
#ifdef TouchDebug
            if (currentImage == tile1) {
                currentImage = [self drawText:[NSString stringWithFormat:@"%d", i] withFont:helvetica11 inImage:currentImage];
            } else {
                currentImage = [self drawText:[NSString stringWithFormat:@"%d", i] withFont:helvetica11 inImage:currentImage];;
            }
#endif
            CGContextDrawImage(context, frame, currentImage.CGImage);
            i++;
        }
    }
    
    CGImageRef mergeResult  = CGBitmapContextCreateImage(context);
    finalImage = [[UIImage alloc] initWithCGImage:mergeResult];
    CGContextRelease(context);
    CGImageRelease(mergeResult);
    
    return finalImage;
    
}

- (UIImage *)drawText:(NSString *)text withFont:(UIFont *)font inImage:(UIImage*)image {
    //initialize the text randering context variables (text size, font, frame, alignment)
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName:font,
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    CGSize size = [text sizeWithAttributes:attributes];
    CGRect textRect = CGRectMake(frame.origin.x + floorf((frame.size.width - size.width) / 1.5),
                                 frame.origin.y + floorf((frame.size.height - size.height) / 4),
                                 size.width,
                                 size.height);
    //render image in context after that rander text => text on image
    UIGraphicsBeginImageContext(frame.size);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), true);
    [image drawInRect:CGRectMake(0,0,frame.size.width,frame.size.height)];
    [text drawInRect:textRect withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)menu:(BDMenu *)menu didSelectBuilding:(BDBuilding *)building {
    
    [self.gameScene prepareToAddNode:building];
}

@end
