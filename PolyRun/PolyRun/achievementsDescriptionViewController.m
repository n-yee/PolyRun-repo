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
NSString * achievement;
NSDictionary * titleLabel;

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
    [titleLabel setValue: @"Total Distance Run" forKey:@"totalDistanc"];
    [titleLabel setValue: @"Total Pins Reached" forKey: @"numberOfPins"];
    [titleLabel setValue:@"Regular Visitor" forKey:@"keepVisiting"];
    [titleLabel setValue:@"Total Number Of Runs" forKey:@"numberOfRuns"];
    achievement = [defaults objectForKey:@"achievementValue"];
    _navigationBar.title = [titleLabel objectForKey: [achievement substringToIndex:12]];
    if ([defaults boolForKey:[NSString stringWithFormat:@"%@Status", [defaults objectForKey:@"achievementValue"]]]) _achievementPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Success.png", achievement]];
    else _achievementPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Fail.png", [achievement substringToIndex:12]]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
