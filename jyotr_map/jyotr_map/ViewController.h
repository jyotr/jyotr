//
//  ViewController.h
//  jyotr_map
//
//  Created by Armen Mkrtchian on 03/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MWDatePicker.h"

@interface ViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate, MWPickerDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *googleMapView;

@end
