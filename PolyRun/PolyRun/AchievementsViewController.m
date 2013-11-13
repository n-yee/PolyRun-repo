//
//  AchievementsViewController.m
//  PolyRun
//
//  Created by Brendan Baronia on 11/5/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "AchievementsViewController.h"

@interface AchievementsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *numberOfPins;
@property (weak, nonatomic) IBOutlet UIButton *numberOfPinsLevelOne;
@property (weak, nonatomic) IBOutlet UIButton *numberOfPinsLevelTwo;
@property (weak, nonatomic) IBOutlet UIButton *numberOfPinsLevelThree;
@property (weak, nonatomic) IBOutlet UIButton *numberOfPinsLevelFour;
@property (weak, nonatomic) IBOutlet UIButton *numberOfPinsLevelFive;
@property (weak, nonatomic) IBOutlet UIButton *numberOfPinsLevelSix;

@end

@implementation AchievementsViewController
int milesRun;
int numberOfPins;

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
    [self.numberOfPins setScrollEnabled:YES];
    [self.numberOfPins setContentSize: CGSizeMake(555, -65)];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"numberOfPinsLevelOneStatus"]) [_numberOfPinsLevelOne setImage:[UIImage imageNamed: @"numberOfPinsLevelOneSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelOne setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelTwoStatus"]) [_numberOfPinsLevelTwo setImage:[UIImage imageNamed: @"numberOfPinsLevelTwoSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelTwo setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelThreeStatus"]) [_numberOfPinsLevelThree setImage:[UIImage imageNamed: @"numberOfPinsLevelThreeSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelThree setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelFourStatus"]) [_numberOfPinsLevelFour setImage:[UIImage imageNamed: @"numberOfPinsLevelFourSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelFour setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelFiveStatus"]) [_numberOfPinsLevelFive setImage:[UIImage imageNamed: @"numberOfPinsLevelFiveSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelFive setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelSixStatus"]) [_numberOfPinsLevelSix setImage:[UIImage imageNamed: @"numberOfPinsLevelSixSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelSix setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction) achievementSelected: (UIButton *) sender {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sender.titleLabel.text forKey: @"achievementValue"];
    [self performSegueWithIdentifier:@"achievementsSegue" sender: self];
}

- (void) updateAchievements {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (milesRun > [defaults floatForKey:@"longestDistance"]) [defaults setFloat:milesRun forKey:@"longestDistance"];
    [defaults setFloat: ([defaults floatForKey:@"totalDistance"] + milesRun) forKey:@"totalDistance"];
    [defaults setInteger: ([defaults integerForKey:@"numberOfRuns"] + 1) forKey: @"numberOfRuns"];
    [defaults setInteger: ([defaults integerForKey:@"numberOfPins"] + numberOfPins) forKey: @"totalNumberOfPins"];
    [defaults synchronize];
    [self checkAchievements];
}
- (void) checkAchievements {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults floatForKey:@"totalNumberOfPins"] >= 5)[defaults setBool:YES forKey:@"numberOfPinsLevelOneStatus"];
    else [defaults setBool: NO forKey:@"numberOfPinsLevelOneStatus"];
    if ([defaults floatForKey:@"totalNumberOfPins"] >= 10)[defaults setBool:YES forKey:@"numberOfPinsLevelTwoStatus"];
    else [defaults setBool: NO forKey: @"numberOfPinsLevelTwoStatus"];
    if ([defaults floatForKey:@"totalNumberOfPins"] >= 15)[defaults setBool:YES forKey:@"numberOfPinsLevelThreeStatus"];
    else [defaults setBool: NO forKey: @"numberOfPinsLevelThreeStatus"];
     [defaults synchronize];
}


@end
