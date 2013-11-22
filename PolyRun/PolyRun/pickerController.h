//
//  pickerController.h
//  PolyRun
//
//  Created by Ruchita Patel on 11/12/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface pickerController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *picker;
    NSArray *decimal;
    NSArray *arrStatus;
}
@property (strong, nonatomic) IBOutlet UIPickerView *_picker;
@property NSString *miles;
@property NSMutableArray *myRoute;
@property CLLocationManager *locMgr;



@end
