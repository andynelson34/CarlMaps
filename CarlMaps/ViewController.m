//
//  ViewController.m
//  CarlMaps
//
//  Created by Jonathan Knudson on 5/7/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()

@end

@implementation ViewController {
    GMSMapView *mapView_;
    UITableView *trailView;
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
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:44.461329
                                                            longitude:-93.155607
                                                                 zoom:16.5];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    //set min and max zoom
    [mapView_ setMinZoom:14.0f maxZoom:20.0f];
    
    /*
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;*/
    
    UIButton *trailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    trailButton.frame = CGRectMake(mapView_.bounds.size.width - 60, mapView_.bounds.size.height - 450, 50, 20);
    trailButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [trailButton setTitle:@"Trails" forState:UIControlStateNormal];
    [mapView_ addSubview:trailButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
