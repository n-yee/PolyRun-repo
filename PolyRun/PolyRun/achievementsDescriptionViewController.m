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
@property (weak, nonatomic) IBOutlet UITextView *descriptionBox;
@property (weak, nonatomic) IBOutlet UIProgressView *achievementProgress;

@end

@implementation AchievementsDescriptionViewController
NSString * achievement;

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
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSMutableDictionary * titleLabel = [NSMutableDictionary dictionary];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [titleLabel setObject: @"Total Distance Run" forKey:@"totalDistanc"];
    [titleLabel setObject: @"Total Pins Reached" forKey: @"numberOfPins"];
    [titleLabel setObject: @"Regular Visitor" forKey:@"keepVisiting"];
    [titleLabel setObject: @"Total Number Of Runs" forKey:@"numberOfRuns"];
    achievement = [defaults objectForKey:@"achievementValue"];
    NSString * twelveLetterAchievement = [achievement substringToIndex:12];
    NSString * achievementLevel = [achievement substringFromIndex:12];
    _navigationBar.title = [titleLabel objectForKey: twelveLetterAchievement];
    if ([defaults boolForKey:[NSString stringWithFormat:@"%@Status", [defaults objectForKey:@"achievementValue"]]]) _achievementPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Success.png", achievement]];
    else _achievementPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Fail.png", twelveLetterAchievement]];
    _descriptionBox.text = [NSString stringWithContentsOfFile:[mainBundle pathForResource:achievement ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    _achievementProgress.progress = [defaults floatForKey:twelveLetterAchievement]/[[[defaults objectForKey:@"numberOfRunsDict"] objectForKey: achievementLevel] intValue];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
