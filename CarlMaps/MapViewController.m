//
//  ViewController.m
//  CarlMaps
//
//  Created by Jonathan Knudson on 5/7/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "MapViewController.h"
#import "LocationDataSource.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController {
    __weak IBOutlet GMSMapView *mapView;
    __weak IBOutlet UIButton *trailsButton;
    __weak IBOutlet UISearchBar *searchBar;
    LocationDataSource *testSource;
}

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinates of Carleton College at zoom level 16.5
    GMSCameraPosition *carlCamera = [GMSCameraPosition cameraWithLatitude:44.461329
                                                            longitude:-93.155607
                                                                 zoom:16.5];

    mapView.frame = CGRectZero;
    mapView.camera = carlCamera;
    mapView.myLocationEnabled = YES;
    
    //set min and max zoom
    [mapView setMinZoom:14.0f maxZoom:20.0f];
    
    /* TEST CODE DEMONSTRATING HOW LOCATIONDATASOURCE WORKS
    //Create a data source, and search for a location
    testSource = [[LocationDataSource alloc] init];
    NSString *CMC = @"CMC";
    NSLog(@"%@",[testSource searchForPath:CMC]);*/


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
