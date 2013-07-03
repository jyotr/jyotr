//
//  FacebookViewController.m
//  jyotr
//
//  Created by Armen Mkrtchian on 04/06/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "FacebookViewController.h"
#import "FacebookCell.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = closeButton;
    
	// Do any additional setup after loading the view.
}

-(void)close{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //code
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"FacebookCell";
    FacebookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSLog(@"cell == nil");
        cell = [[FacebookCell alloc] init];
    }
    
    // Configure the cell.
    NSDictionary *object = [self.friends objectAtIndex:indexPath.row];
    
    NSLog(@"%@", object);
    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", [object objectForKey:@"id"]]];
    
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.detailTextLabel.text = [object objectForKey:@"username"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:pictureURL]];
    [cell.imageView setImage:image];
    
//	if(object.imageURL != nil)
//    {
//        //NSLog(@"%@", rssItem.imageURL);
//        [cell.myImageView setImageWithURL:[NSURL URLWithString:rssItem.imageURL]
//                         placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
//    }
//    
//    [cell.myImageView.layer setBorderColor: [[UIColor grayColor] CGColor]];
//    [cell.myImageView.layer setBorderWidth: 1.5];
//    
//    [cell.date.layer setCornerRadius: 5.0];
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
