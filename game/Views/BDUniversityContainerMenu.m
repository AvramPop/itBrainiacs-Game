//
//  BDUniversityContainerMenu.m
//  game
//
//  Created by Bogdan Sala on 15/05/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import "BDUniversityContainerMenu.h"
#import "UIButton+Block.h"

@interface BDUniversityContainerMenu : UIViewController

@property (nonatomic, strong) NSMutableArray *researchedTechnologies;

@end

@implementation BDUniversityContainerMenu

- (instancetype) initWithFrame:(CGrect)frame andResearchedTechnologies:(NSMutableArray*)researchedTechnologies {
    self = [super initWithFrame:frame];
    if(self) {
        self.researchedTechnologies = researchedTechnologies;
    }
    return self;
}

@end

