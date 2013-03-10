//
//  SRLeftViewController.m
//  ScanForGood
//
//  Created by Gilad Shai on 3/9/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import "SRLeftViewController.h"
#import "IIViewDeckController.h"
#import "SRFirstViewController.h"
#import "SRHistoryViewController.h"
#import "SRSettingsViewController.h"

@interface SRLeftViewController ()

@end

@implementation SRLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Welcome Jon";
            break;
        case 1:
            cell.textLabel.text = @"History";
            break;
        case 2:
            cell.textLabel.text = @"Settings";
            break;
        case 3:
            cell.textLabel.text = @"Holds";
            break;
            
        default:
            break;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 0: {
            self.viewDeckController.leftController = SharedAppDelegate.leftController;            
            SRFirstViewController* nestController = [[SRFirstViewController alloc] initWithNibName:@"SRFirstViewController" bundle:nil];
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:nestController];
            self.viewDeckController.centerController = navController;
        }
            break;

        case 1: {
            self.viewDeckController.leftController = SharedAppDelegate.leftController;
            
            SRHistoryViewController *nestController1 = [[SRHistoryViewController alloc] initWithNibName:@"SRHistoryViewController" bundle:nil];
            UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:nestController1];
            self.viewDeckController.centerController = navController1;
        }
            break;
            
        case 2: {
            self.viewDeckController.leftController = SharedAppDelegate.leftController;
            
            SRSettingsViewController *nestController1 = [[SRSettingsViewController alloc] initWithNibName:@"SRSettingsViewController" bundle:nil];
            UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:nestController1];
            self.viewDeckController.centerController = navController1;
        }
            break;
                        
        default: {
            self.viewDeckController.leftController = SharedAppDelegate.leftController;
            SRFirstViewController *nestController = [[SRFirstViewController alloc] initWithNibName:@"SRFirstViewController" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:nestController];
            self.viewDeckController.centerController = navController;
        }
            break;
    }
    
    // Close the view and present the selected VC
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            UITableViewController* cc = (UITableViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
        }
//        [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0]; // mimic delay... not really necessary
    }];
}

@end
