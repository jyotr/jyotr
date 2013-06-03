//
//  FacebookCell.m
//  jyotr
//
//  Created by Armen Mkrtchian on 04/06/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "FacebookCell.h"

@implementation FacebookCell

- (id)init {
    static NSString *cellID = @"FacebookCell";
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    if(self != nil){
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




@end
