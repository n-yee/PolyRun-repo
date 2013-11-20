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
@property (weak, nonatomic) IBOutlet UIButton *totalDistanceLevelOne;
@property (weak, nonatomic) IBOutlet UIButton *totalDistanceLevelTwo;
@property (weak, nonatomic) IBOutlet UIButton *totalDistanceLevelThree;
@property (weak, nonatomic) IBOutlet UIButton *totalDistanceLevelFour;
@property (weak, nonatomic) IBOutlet UIButton *totalDistanceLevelFive;
@property (weak, nonatomic) IBOutlet UIButton *totalDistanceLevelSix;
@property (weak, nonatomic) IBOutlet UIButton *numberOfRunsLevelOne;
@property (weak, nonatomic) IBOutlet UIButton *numberOfRunsLevelTwo;
@property (weak, nonatomic) IBOutlet UIButton *numberOfRunsLevelThree;
@property (weak, nonatomic) IBOutlet UIButton *numberOfRunsLevelFour;
@property (weak, nonatomic) IBOutlet UIButton *numberOfRunsLevelFive;
@property (weak, nonatomic) IBOutlet UIButton *numberOfRunsLevelSix;
@property (weak, nonatomic) IBOutlet UIButton *keepVisitingLevelOne;
@property (weak, nonatomic) IBOutlet UIButton *keepVisitingLevelTwo;
@property (weak, nonatomic) IBOutlet UIButton *keepVisitingLevelThree;
@property (weak, nonatomic) IBOutlet UIButton *keepVisitingLevelFour;
@property (weak, nonatomic) IBOutlet UIButton *keepVisitingLevelFive;
@property (weak, nonatomic) IBOutlet UIButton *keepVisitingLevelSix;
@property (weak, nonatomic) IBOutlet UITextField *numberOfPinsAchieved;
@property (weak, nonatomic) IBOutlet UIScrollView *numberOfRuns;
@property (weak, nonatomic) IBOutlet UIScrollView *keepVisiting;

@property (weak, nonatomic) IBOutlet UIScrollView *totalDistance;
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
    [self.totalDistance setScrollEnabled:YES];
    [self.numberOfRuns setScrollEnabled:YES];
    [self.keepVisiting setScrollEnabled:YES];
    [self.numberOfPins setContentSize: CGSizeMake(430, -65)];
    [self.totalDistance setContentSize: CGSizeMake (650, 100)];
    [self.numberOfRuns setContentSize: CGSizeMake (650, 100)];
    [self.keepVisiting setContentSize: CGSizeMake (650, 100)];
    [self updateAchievements];
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
    [defaults setFloat: ([defaults floatForKey:@"totalDistance"] + milesRun) forKey:@"totalDistance"];
    [defaults setInteger: ([defaults integerForKey:@"numberOfRuns"] + 1) forKey: @"numberOfRuns"];
    [defaults setInteger: ([defaults integerForKey:@"totalNumberOfPins"] + numberOfPins) forKey: @"totalNumberOfPins"];
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
    if ([defaults floatForKey:@"totalNumberOfPins"] >= 20)[defaults setBool:YES forKey:@"numberOfPinsLevelFourStatus"];
    else [defaults setBool: NO forKey: @"numberOfPinsLevelFourStatus"];
    if ([defaults floatForKey:@"totalNumberOfPins"] >= 25)[defaults setBool:YES forKey:@"numberOfPinsLevelFiveStatus"];
    else [defaults setBool: NO forKey: @"numberOfPinsLevelFiveStatus"];
    if ([defaults floatForKey:@"totalNumberOfPins"] >= 30)[defaults setBool:YES forKey:@"numberOfPinsLevelSixStatus"];
    else [defaults setBool: NO forKey: @"numberOfPinsLevelSixStatus"];
    if ([defaults floatForKey:@"numberOfRuns"] >= 5)[defaults setBool:YES forKey:@"numberOfRunsLevelOneStatus"];
    else [defaults setBool: NO forKey:@"numberOfRunsLevelOneStatus"];
    if ([defaults floatForKey:@"numberOfRuns"] >= 10)[defaults setBool:YES forKey:@"numberOfRunsLevelTwoStatus"];
    else [defaults setBool: NO forKey: @"numberOfRunsLevelTwoStatus"];
    if ([defaults floatForKey:@"numberOfRuns"] >= 15)[defaults setBool:YES forKey:@"numberOfRunsLevelThreeStatus"];
    else [defaults setBool: NO forKey: @"numberOfRunsLevelThreeStatus"];
    if ([defaults floatForKey:@"numberOfRuns"] >= 20)[defaults setBool:YES forKey:@"numberOfRunsLevelFourStatus"];
    else [defaults setBool: NO forKey: @"numberOfRunsLevelFourStatus"];
    if ([defaults floatForKey:@"numberOfRuns"] >= 25)[defaults setBool:YES forKey:@"numberOfRunsLevelFiveStatus"];
    else [defaults setBool: NO forKey: @"numberOfRunsLevelFiveStatus"];
    if ([defaults floatForKey:@"numberOfRuns"] >= 30)[defaults setBool:YES forKey:@"numberOfRunsLevelSixStatus"];
    else [defaults setBool: NO forKey: @"numberOfRunsLevelSixStatus"];
    if ([defaults floatForKey:@"totalDistance"] >= 5)[defaults setBool:YES forKey:@"totalDistanceLevelOneStatus"];
    else [defaults setBool: NO forKey:@"totalDistanceLevelOneStatus"];
    if ([defaults floatForKey:@"totalDistance"] >= 10)[defaults setBool:YES forKey:@"totalDistanceLevelTwoStatus"];
    else [defaults setBool: NO forKey: @"totalDistanceLevelTwoStatus"];
    if ([defaults floatForKey:@"totalDistance"] >= 15)[defaults setBool:YES forKey:@"totalDistanceLevelThreeStatus"];
    else [defaults setBool: NO forKey: @"totalDistanceLevelThreeStatus"];
    if ([defaults floatForKey:@"totalDistance"] >= 20)[defaults setBool:YES forKey:@"totalDistanceLevelFourStatus"];
    else [defaults setBool: NO forKey: @"totalDistanceLevelFourStatus"];
    if ([defaults floatForKey:@"totalDistance"] >= 25)[defaults setBool:YES forKey:@"totalDistanceLevelFiveStatus"];
    else [defaults setBool: NO forKey: @"totalDistanceLevelFiveStatus"];
    if ([defaults floatForKey:@"totalDistance"] >= 30)[defaults setBool:YES forKey:@"totalDistanceLevelSixStatus"];
    else [defaults setBool: NO forKey: @"totalDistanceLevelSixStatus"];
    if ([defaults floatForKey:@"keepVisiting"] >= 5)[defaults setBool:YES forKey:@"keepVisitingLevelOneStatus"];
    else [defaults setBool: NO forKey:@"keepVisitingLevelOneStatus"];
    if ([defaults floatForKey:@"keepVisiting"] >= 10)[defaults setBool:YES forKey:@"keepVisitingLevelTwoStatus"];
    else [defaults setBool: NO forKey: @"keepVisitingLevelTwoStatus"];
    if ([defaults floatForKey:@"keepVisiting"] >= 15)[defaults setBool:YES forKey:@"keepVisitingLevelThreeStatus"];
    else [defaults setBool: NO forKey: @"keepVisitingLevelThreeStatus"];
    if ([defaults floatForKey:@"keepVisiting"] >= 20)[defaults setBool:YES forKey:@"keepVisitingLevelFourStatus"];
    else [defaults setBool: NO forKey: @"keepVisitingLevelFourStatus"];
    if ([defaults floatForKey:@"keepVisiting"] >= 25)[defaults setBool:YES forKey:@"keepVisitingLevelFiveStatus"];
    else [defaults setBool: NO forKey: @"keepVisitingLevelFiveStatus"];
    if ([defaults floatForKey:@"keepVisiting"] >= 30)[defaults setBool:YES forKey:@"keepVisitingLevelSixStatus"];
    else [defaults setBool: NO forKey: @"keepVisitingLevelSixStatus"];
     [defaults synchronize];
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
    if ([defaults boolForKey:@"numberOfRunsLevelOneStatus"]) [_numberOfRunsLevelOne setImage:[UIImage imageNamed: @"numberOfRunsLevelOneSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfRunsLevelOne setImage:[UIImage imageNamed:@"numberOfRunsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfRunsLevelTwoStatus"]) [_numberOfRunsLevelTwo setImage:[UIImage imageNamed: @"numberOfRunsLevelTwoSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfRunsLevelTwo setImage:[UIImage imageNamed: @"numberOfRunsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfRunsLevelThreeStatus"]) [_numberOfRunsLevelThree setImage:[UIImage imageNamed: @"numberOfRunsLevelThreeSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfRunsLevelThree setImage:[UIImage imageNamed: @"numberOfRunsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfRunsLevelFourStatus"]) [_numberOfRunsLevelFour setImage:[UIImage imageNamed: @"numberOfRunsLevelFourSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfRunsLevelFour setImage:[UIImage imageNamed: @"numberOfRunsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfRunsLevelFiveStatus"]) [_numberOfRunsLevelFive setImage:[UIImage imageNamed: @"numberOfRunsLevelFiveSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfRunsLevelFive setImage:[UIImage imageNamed: @"numberOfRunsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfRunsLevelSixStatus"]) [_numberOfRunsLevelSix setImage:[UIImage imageNamed: @"numberOfRunsLevelSixSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfRunsLevelSix setImage:[UIImage imageNamed: @"numberOfRunsFail.png"] forState:UIControlStateNormal];
 
    if ([defaults boolForKey:@"totalDistanceLevelOneStatus"]) [_totalDistanceLevelOne setImage:[UIImage imageNamed: @"totalDistanceLevelOneSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistanceLevelOne setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistanceLevelTwoStatus"]) [_totalDistanceLevelTwo setImage:[UIImage imageNamed: @"totalDistanceLevelTwoSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistanceLevelTwo setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistanceLevelThreeStatus"]) [_totalDistanceLevelThree setImage:[UIImage imageNamed: @"totalDistanceLevelThreeSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistanceLevelThree setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistanceLevelFourStatus"]) [_totalDistanceLevelFour setImage:[UIImage imageNamed: @"totalDistanceLevelFourSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistanceLevelFour setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistanceLevelFiveStatus"]) [_totalDistanceLevelFive setImage:[UIImage imageNamed: @"totalDistanceLevelFiveSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistanceLevelFive setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistanceLevelSixStatus"]) [_totalDistanceLevelSix setImage:[UIImage imageNamed: @"totalDistanceLevelSixSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistanceLevelSix setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"keepVisitingLevelOneStatus"]) [_keepVisitingLevelOne setImage:[UIImage imageNamed: @"keepVisitingLevelOneSuccess.png"] forState:UIControlStateNormal];
    else [_keepVisitingLevelOne setImage:[UIImage imageNamed: @"keepVisitingFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"keepVisitingLevelTwoStatus"]) [_keepVisitingLevelTwo setImage:[UIImage imageNamed: @"keepVisitingLevelTwoSuccess.png"] forState:UIControlStateNormal];
    else [_keepVisitingLevelTwo setImage:[UIImage imageNamed: @"keepVisitingFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"keepVisitingLevelThreeStatus"]) [_keepVisitingLevelThree setImage:[UIImage imageNamed: @"keepVisitingLevelThreeSuccess.png"] forState:UIControlStateNormal];
    else [_keepVisitingLevelThree setImage:[UIImage imageNamed: @"keepVisitingFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"keepVisitingLevelFourStatus"]) [_keepVisitingLevelFour setImage:[UIImage imageNamed: @"keepVisitingLevelFourSuccess.png"] forState:UIControlStateNormal];
    else [_keepVisitingLevelFour setImage:[UIImage imageNamed: @"keepVisitingFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"keepVisitingLevelFiveStatus"]) [_keepVisitingLevelFive setImage:[UIImage imageNamed: @"keepVisitingLevelFiveSuccess.png"] forState:UIControlStateNormal];
    else [_keepVisitingLevelFive setImage:[UIImage imageNamed: @"keepVisitingFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"keepVisitingLevelSixStatus"]) [_keepVisitingLevelSix setImage:[UIImage imageNamed: @"keepVisitingLevelSixSuccess.png"] forState:UIControlStateNormal];
    else [_keepVisitingLevelSix setImage:[UIImage imageNamed: @"keepVisitingFail.png"] forState:UIControlStateNormal];
}

@end
