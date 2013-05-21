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
    if (false) {
        NSLog(@"MAIN VIEW");
        /*
        self.loginVC = [[LoginViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
        return self.loginVC;
        */
    } else {

        LogInViewController *logInController =[[LogInViewController alloc] init];
        logInController.delegate = self;
        
        logInController.fields = PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten
        | PFLogInFieldsFacebook
        | PFLogInFieldsTwitter
        //| PFLogInFieldsDismissButton
        ;
        
        return logInController;
    }
}

@end
