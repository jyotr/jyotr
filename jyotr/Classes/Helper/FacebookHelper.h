//
//  FacebookHelper.h
//  jyotr
//
//  Created by Armen Mkrtchyan on 04/06/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>


#define kAppName        @"Your App's name"
#define kCustomMessage  @"I just got a score of %d in %@, an iPhone/iPod Touch game by me!"
#define kServerLink     @"http://jyotr.me"
#define kImageSrc       @"http://refractedpixel.com/indiedevstories/wp-content/uploads/2011/09/677166248.png"

static NSString* kAppId = @"000000000000000";

typedef void(^FacebookHelperCallback)(BOOL success, id result);

@interface FacebookHelper : NSObject <FBRequestDelegate, FBWebDialogsDelegate> {
    NSArray* _permissions;
}
@property (nonatomic) NSArray* friendsArray;

+ (FacebookHelper *) sharedInstance;
+ (void)graphApi:(NSString *)graphPath withNotifier:(NSString *)notify;

#pragma mark - Public Methods
// Public methods here.
-(void) login;
//-(void) logout;
//+(void) postToWallWithDialogNewHighscore:(int)highscore;

+(NSArray *)getFriends;

@end