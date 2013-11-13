//
//  achievementsDescriptionViewController.m
//  PolyRun
//
//  Created by Brendan Baronia on 11/12/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "AchievementsDescriptionViewController.h"

@interface AchievementsDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *achievementPicture;

@end

@implementation AchievementsDescriptionViewController

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
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    _navigationBar.title = [defaults objectForKey:@"achievementValue"];
    if ([defaults boolForKey:[NSString stringWithFormat:@"%@Status", [defaults objectForKey:@"achievementValue"]]]) _achievementPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Success.png", [defaults objectForKey:@"achievementValue"]]];
    else _achievementPicture.image = [UIImage imageNamed: @"numberOfPinsFail.png"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
