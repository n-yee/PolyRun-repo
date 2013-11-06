//
//  AchievementsViewController.m
//  PolyRun
//
//  Created by Brendan Baronia on 11/5/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "AchievementsViewController.h"

@interface AchievementsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *firstRow;

@end

@implementation AchievementsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.firstRow setScrollEnabled:YES];
    [self.firstRow setContentSize: CGSizeMake(500, 50)];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end