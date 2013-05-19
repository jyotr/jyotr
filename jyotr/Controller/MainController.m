//
//  MainController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "MainController.h"

@implementation MainController


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UIViewController *) getMainView{
    
    if (true) {
        self.loginVC = [[LoginViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
        return self.loginVC;
    } else {
        NSLog(@"false");
    }
    
}

@end
