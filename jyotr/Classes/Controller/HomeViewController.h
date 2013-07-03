//
//  HomeViewController.h
//  jyotr
//
//  Created by Armen Mkrtchyan on 03/07/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookViewController.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) FacebookViewController *fbView;
@property (weak, nonatomic) IBOutlet UITextField *graphPath;

- (IBAction)getGraph:(id)sender;
- (IBAction)friends:(id)sender;
- (IBAction)signout:(id)sender;

@end
