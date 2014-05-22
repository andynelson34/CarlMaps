//
//  TrailTableViewController.m
//  CarlMaps
//
//  Created by MobileDev on 5/14/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "TrailTableViewController.h"

@interface TrailTableViewController ()

@end

@implementation TrailTableViewController {
    NSArray *trails;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Shows the navigation bar, which is hidden in the map view, in this view
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    trails = [NSArray arrayWithObjects:@"Goose Trail", @"Deer Path", @"Trail of Doom", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    return [trails count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *trailTableIdentifier = @"TrailTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:trailTableIdentifier];
    
    // Populates cells in table from trails list
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trailTableIdentifier];
    }
    
    cell.textLabel.text = [trails objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Checkmarks cells upon tapping them
    
    UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:indexPath];
    checkedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
