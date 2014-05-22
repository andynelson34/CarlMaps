//
//  TrailDataSource.m
//  CarlMaps
//
//  Created by student on 5/22/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//


// TODO:
// So basically, we're eventually going to move all the stuff with creating an array of trails from the plist
// over from TrailTableViewController.m to here and TTVC will create one of these to store the array and keep
// track of which ones are checked so we can display them when the user opens the map again (on closing the
// table view and opening the map, the table will push the checked trails from its TrailDataSource to the map
// for highlighting on KML. I'd do this right now but I've been working for 2 hours and I'm hungry.

#import "TrailDataSource.h"

@interface TrailDataSource ()

@end

@implementation TrailDataSource

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
