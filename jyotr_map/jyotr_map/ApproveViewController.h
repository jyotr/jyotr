//
//  ApproveViewController.h
//  jyotr_map
//
//  Created by Armen Mkrtchian on 07/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ApproveViewController : UIViewController

@property (nonatomic) CLLocationCoordinate2D selectedCoordinate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (nonatomic, strong) UIButton * backButton;

@end
