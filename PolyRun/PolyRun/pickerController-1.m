//
//  pickerController.m
//  PolyRun
//
//  Created by Ruchita Patel on 11/12/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "pickerController.h"

@implementation pickerController


- (void)viewDidLoad
{
    [super viewDidLoad];
    arrStatus = [[NSArray alloc] initWithObjects:@"0", @"1",@"2",@"3", @"4",@"5", @"6", @"7", @"8", @"9", nil];
    
    decimal = [[NSArray alloc] initWithObjects:@".0", @".5", nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    if (component == 0 || component == 1) return arrStatus.count;
    else return decimal.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    if (component == 0 || component == 1) return [arrStatus objectAtIndex:row];
    else return [decimal objectAtIndex:row];
}




-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    NSString *numbers = [arrStatus objectAtIndex:[pickerView selectedRowInComponent:0] ];
    NSString *one = [arrStatus objectAtIndex:[pickerView selectedRowInComponent:1] ];
    NSString *ten = [decimal objectAtIndex:[pickerView selectedRowInComponent:2] ];
    
    
    NSString *intString = [numbers stringByAppendingString:[one stringByAppendingString:ten]];
    
    NSLog ( @"%@", intString);
    
}

@end
