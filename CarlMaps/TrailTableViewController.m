//
//  TrailTableViewController.m
//  CarlMaps
//
//  Created by MobileDev on 5/14/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "TrailTableViewController.h"
#import "TrailDataSource.h"

@interface TrailTableViewController ()

@end

@implementation TrailTableViewController {
    TrailDataSource *trailSource;
    IBOutlet UITableView *trailTableView;
    NSMutableArray *checkedTrails;
    NSUserDefaults *defaults;
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
    trailSource = [[TrailDataSource alloc] init];
    checkedTrails = [[NSMutableArray arrayWithArray:[self loadCheckedTrails]] mutableCopy];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    // Save which trails are checkmarked for display on the map as this view closes.
    [self saveCheckedTrails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCheckedTrails {
    
    // Save which trails are checkmarked so they can be displayed on the map.
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:checkedTrails forKey:@"trails_key"];
}

-(NSMutableArray*)loadCheckedTrails {
    
    // Load previously checked trails so they can be re-checked as the table loads.
    defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *checkedTrailArray = [[defaults arrayForKey:@"trails_key"] mutableCopy];
    return checkedTrailArray;
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
    return [trailSource.trails count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *trailTableIdentifier = @"TrailTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:trailTableIdentifier];
    
    // Populates cells in table from trails list
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trailTableIdentifier];
    }
    
    cell.textLabel.text = [trailSource.trails objectAtIndex:indexPath.row];
    
    // Re-checkmarks previously checkmarked cells
    if ([checkedTrails containsObject:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Checks or unchecks cells upon tapping them
    
    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (tappedCell.accessoryType == UITableViewCellAccessoryNone) {
        tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [checkedTrails addObject:tappedCell.textLabel.text];
    } else {
        tappedCell.accessoryType = UITableViewCellAccessoryNone;
        [checkedTrails removeObject:tappedCell.textLabel.text];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
