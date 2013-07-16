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
- (IBAction)getFriends:(id)sender;
- (IBAction)signoutBtnHandler:(id)sender;
- (IBAction)profileBtnHandler:(id)sender;

@end
