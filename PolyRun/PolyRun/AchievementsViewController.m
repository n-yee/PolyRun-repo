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
@property (weak, nonatomic) IBOutlet UIButton *totalDistancLevelOne;
@property (weak, nonatomic) IBOutlet UIButton *totalDistancLevelTwo;
@property (weak, nonatomic) IBOutlet UIButton *totalDistancLevelThree;
@property (weak, nonatomic) IBOutlet UIButton *totalDistancLevelFour;
@property (weak, nonatomic) IBOutlet UIButton *totalDistancLevelFive;
@property (weak, nonatomic) IBOutlet UIButton *totalDistancLevelSix;
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

@property (weak, nonatomic) IBOutlet UIScrollView *totalDistanc;
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
    [self.numberOfPins setScrollEnabled:YES];
    [self.totalDistanc setScrollEnabled:YES];
    [self.numberOfRuns setScrollEnabled:YES];
    [self.keepVisiting setScrollEnabled:YES];
    [self.numberOfPins setContentSize: CGSizeMake(430, -65)];
    [self.totalDistanc setContentSize: CGSizeMake (650, 100)];
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
    NSDictionary * numberOfPins = [[NSDictionary alloc] initWithObjectsAndKeys:@5, @"LevelOne", @10, @"LevelTwo", @15, @"LevelThree", @20, @"LevelFour", nil];
    NSDictionary * numberOfRuns = [[NSDictionary alloc] initWithObjectsAndKeys:@1, @"LevelOne", @5, @"LevelTwo", @10, @"LevelThree", @20, @"LevelFour", @50, @"LevelFive", @100, @"LevelSix", nil];
    NSDictionary * totalDistanc = [[NSDictionary alloc] initWithObjectsAndKeys:@1, @"LevelOne", @5, @"LevelTwo", @10, @"LevelThree", @20, @"LevelFour", @50, @"LevelFive", @100, @"LevelSix", nil];
    NSDictionary * keepVisiting = [[NSDictionary alloc] initWithObjectsAndKeys:@2, @"LevelOne", @5, @"LevelTwo", @7, @"LevelThree", @10, @"LevelFour", @14, @"LevelFive", @21, @"LevelSix", nil];
    [defaults setObject:numberOfPins forKey:@"numberOfPinsDict"];
    [defaults setObject:numberOfRuns forKey:@"numberOfRunsDict"];
    [defaults setObject:totalDistanc forKey:@"totalDistancDict"];
    [defaults setObject:keepVisiting forKey:@"keepVisitingDict"];
    [self checkAchievements];
}
- (NSString *) returnNumberString: (int) number {
    if (number == 1) return @"One";
    else if (number == 2) return @"Two";
    else if (number == 3) return @"Three";
    else if (number == 4) return @"Four";
    else if (number == 5) return @"Five";
    else if (number == 6) return @"Six";
    else return NULL;
}
- (void) checkAchievements {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    for (int i=1; i<5; i++) {
        NSString * numberString = [self returnNumberString:i];
        if ([defaults floatForKey:@"totalNumberOfPins"] >= [[[defaults objectForKey:@"numberOfPinsDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue]) [defaults setBool:YES forKey:[NSString stringWithFormat:@"numberOfPinsLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"numberOfPinsLevel%@Status", numberString]];
        if ([defaults floatForKey:@"numberOfRuns"] >= [[[defaults objectForKey:@"numberOfRunsDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue])[defaults setBool:YES forKey:[NSString stringWithFormat:@"numberOfRunsLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"numberOfRunsLevel%@Status", numberString]];
        if ([defaults floatForKey:@"totalDistanc"] >= [[[defaults objectForKey:@"totalDistancDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue])[defaults setBool:YES forKey:[NSString stringWithFormat:@"totalDistancLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"totalDistancLevel%@Status", numberString]];
        if ([defaults floatForKey:@"keepVisiting"] >= [[[defaults objectForKey:@"keepVisitingDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue])[defaults setBool:YES forKey:[NSString stringWithFormat:@"keepVisitingLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"keepVisitingLevel%@Status", numberString]];
    }
    for (int i=5; i<7; i++) {
        NSString * numberString = [self returnNumberString:i];
        if ([defaults floatForKey:@"numberOfRuns"] >= [[[defaults objectForKey:@"numberOfRunsDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue])[defaults setBool:YES forKey:[NSString stringWithFormat:@"numberOfRunsLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"numberOfRunsLevel%@Status", numberString]];
        if ([defaults floatForKey:@"totalDistanc"] >= [[[defaults objectForKey:@"totalDistancDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue])[defaults setBool:YES forKey:[NSString stringWithFormat:@"totalDistancLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"totalDistancLevel%@Status", numberString]];
        if ([defaults floatForKey:@"keepVisiting"] >= [[[defaults objectForKey:@"keepVisitingDict"] objectForKey: [NSString stringWithFormat:@"Level%@", numberString]] intValue])[defaults setBool:YES forKey:[NSString stringWithFormat:@"keepVisitingLevel%@Status", numberString]];
        else [defaults setBool: NO forKey:[ NSString stringWithFormat:@"keepVisitingLevel%@Status", numberString]];
    }
     [defaults synchronize];
    if ([defaults boolForKey:@"numberOfPinsLevelOneStatus"]) [_numberOfPinsLevelOne setImage:[UIImage imageNamed: @"numberOfPinsLevelOneSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelOne setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelTwoStatus"]) [_numberOfPinsLevelTwo setImage:[UIImage imageNamed: @"numberOfPinsLevelTwoSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelTwo setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelThreeStatus"]) [_numberOfPinsLevelThree setImage:[UIImage imageNamed: @"numberOfPinsLevelThreeSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelThree setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"numberOfPinsLevelFourStatus"]) [_numberOfPinsLevelFour setImage:[UIImage imageNamed: @"numberOfPinsLevelFourSuccess.png"] forState:UIControlStateNormal];
    else [_numberOfPinsLevelFour setImage:[UIImage imageNamed: @"numberOfPinsFail.png"] forState:UIControlStateNormal];
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
 
    if ([defaults boolForKey:@"totalDistancLevelOneStatus"]) [_totalDistancLevelOne setImage:[UIImage imageNamed: @"totalDistancLevelOneSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistancLevelOne setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistancLevelTwoStatus"]) [_totalDistancLevelTwo setImage:[UIImage imageNamed: @"totalDistancLevelTwoSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistancLevelTwo setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistancLevelThreeStatus"]) [_totalDistancLevelThree setImage:[UIImage imageNamed: @"totalDistancLevelThreeSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistancLevelThree setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistancLevelFourStatus"]) [_totalDistancLevelFour setImage:[UIImage imageNamed: @"totalDistancLevelFourSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistancLevelFour setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistancLevelFiveStatus"]) [_totalDistancLevelFive setImage:[UIImage imageNamed: @"totalDistancLevelFiveSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistancLevelFive setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
    if ([defaults boolForKey:@"totalDistancLevelSixStatus"]) [_totalDistancLevelSix setImage:[UIImage imageNamed: @"totalDistancLevelSixSuccess.png"] forState:UIControlStateNormal];
    else [_totalDistancLevelSix setImage:[UIImage imageNamed: @"totalDistancFail.png"] forState:UIControlStateNormal];
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
- (void) checkDate {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDate * today = [NSDate date];
    NSDate * yesterday = [today dateByAddingTimeInterval: -(60*60*24)];
    NSDateComponents * lastRun = [defaults objectForKey: @"lastRunDate"];
    NSCalendar * gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *thisRun = [gregorianCalendar components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:yesterday];
    NSDateComponents *todayComp = [gregorianCalendar components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    [defaults setObject: thisRun forKey:@"lastRunDate"];
    NSInteger lastRunMonth = [lastRun month];
    NSInteger lastRunDay = [lastRun day];
    NSInteger lastRunYear = [lastRun year];
    NSInteger thisRunDay = [thisRun day];
    NSInteger todayDay = [todayComp day];
    NSInteger todayMonth = [todayComp month];
    NSInteger todayYear = [todayComp year];
    NSInteger thisRunMonth = [thisRun month];
    NSInteger thisRunYear = [thisRun year];
    if (lastRunDay == thisRunDay && lastRunMonth == thisRunMonth && lastRunYear == thisRunYear) {
        [defaults setInteger: [defaults integerForKey:@"daysInARow"] +1 forKey:@"daysInARow"];
        if ([defaults integerForKey:@"daysInARow"] >= [defaults integerForKey:@"keepVisiting"]) {
            [defaults setInteger:[defaults integerForKey:@"daysInARow"] forKey:@"keepVisiting"];
        }
    }
    else if (lastRunDay != todayDay && lastRunYear != todayYear && todayMonth != lastRunMonth) {
        [defaults setInteger:1 forKey:@"daysInARow"];
    }
}

@end
