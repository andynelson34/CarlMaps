//
//  MapViewController.m
//  CarlMaps hi
//
//  Created by Jonathan Knudson on 5/7/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "MapViewController.h"
#import "LocationDataSource.h"
#import "CustomOverlay.h"
#import "CustomOverlayRenderer.h"

@interface MapViewController ()

@end


@implementation MapViewController {
    __weak IBOutlet UIButton *trailsButton;
    __weak IBOutlet UIButton *locationsButton;
    IBOutlet UITableView *searchTableView;
    LocationDataSource *locSource;
    NSArray *checkedTrails;
    NSString *pinTitle;
    NSString *centerStatus;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadSettings];
    [self pinSearchResult:pinTitle];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewDidLoad
{
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(44.461329, -93.155607);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 400, 400)];
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.rotateEnabled = false;
    [self.mapView setDelegate:self];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    
    //Make buttons rounded and transparent
    CALayer *locationsButtonLayer = [locationsButton layer];
    [locationsButtonLayer setMasksToBounds:YES];
    [locationsButtonLayer setCornerRadius:5.0f];
    
    CALayer *trailsButtonLayer = [trailsButton layer];
    [trailsButtonLayer setMasksToBounds:YES];
    [trailsButtonLayer setCornerRadius:5.0f];
    
    
    // Create a location data source
    locSource = [[LocationDataSource alloc] init];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    // Ensures that when this view is reloaded, by default it will not center on the pin.
    centerStatus = @"No";
}

-(void)loadSettings {
    
    // Load trails and pin to display.
    checkedTrails = [[NSUserDefaults standardUserDefaults] arrayForKey:@"trails_key"];
    pinTitle = [[NSUserDefaults standardUserDefaults] stringForKey:@"pin_key"];
    [self placeOverlay];
}


-(void)dropPin:(NSString*)locName {
    
    // TODO: MAYBE ADD ANIMATION? THIS IS JUST POLISHING, BUT IT LOOKS COMPLICATED, NEED TO ADD A NEW THING CALLED MKANNOTATIONVIEW
    
    // Drops pin onto map at given coordinates
    NSArray *coords = [locSource.locDict objectForKey:locName];
    CLLocationCoordinate2D pinLoc;
    pinLoc.latitude = [coords[0] doubleValue];
    pinLoc.longitude = [coords[1] doubleValue];
    MKPointAnnotation *destinationPin = [[MKPointAnnotation alloc] init];
    destinationPin.coordinate = pinLoc;
    destinationPin.title = locName;
    [self.mapView addAnnotation:destinationPin];
    
    if ([centerStatus isEqual: @"Yes"]) {
        [self.mapView setCenterCoordinate:pinLoc animated:YES];
    }
}

-(void)pinSearchResult:(NSString*)pinName {
    // First, remove all existing pins from the map
    NSArray *existingPoints = self.mapView.annotations;
    if ([existingPoints count]) {
        [self.mapView removeAnnotations:existingPoints];
    }
    
    // Then add pin for the searched location
    [self dropPin:pinName];
}



//Creates the overlays
-(void)placeOverlay{
    //Define the region that all of the overlays share
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * 4);

    coords[0] = CLLocationCoordinate2DMake(44.486743000000001,-93.165835000000004);
    coords[1] = CLLocationCoordinate2DMake(44.455424999999998,-93.118323999999999);
    coords[2] = CLLocationCoordinate2DMake(44.486743000000001,-93.165835000000004);
    coords[3] = CLLocationCoordinate2DMake(44.455424999999998,-93.118323999999999);
    
    //Add the basemap overlay
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon.title = @"basemap";
    [self.mapView addOverlay:polygon];
    
    //Add an overlay for each of the trails
    //This is ugly but will serve
    MKPolygon *polygonX = [MKPolygon polygonWithCoordinates:coords count:4];
    polygonX.title = @"carlmaps_trails_all.png";
    [self.mapView addOverlay:polygonX];
    
    MKPolygon *polygon0 = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon0.title = @"carlmaps_trails_lower_long.png";
    [self.mapView addOverlay:polygon0];
    
    MKPolygon *polygon1 = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon1.title = @"carlmaps_trails_lower_medium.png";
    [self.mapView addOverlay:polygon1];
    
    MKPolygon *polygon2 = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon2.title = @"carlmaps_trails_lower_short.png";
    [self.mapView addOverlay:polygon2];
    
    MKPolygon *polygon3 = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon3.title = @"carlmaps_trails_upper_long.png";
    [self.mapView addOverlay:polygon3];
    
    MKPolygon *polygon4 = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon4.title = @"carlmaps_trails_upper_medium.png";
    [self.mapView addOverlay:polygon4];
}

//Tells the MapView which renderer to use for each overlay
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay{
    UIImage *theImage;
    
    
    //check which overlay is being drawn, and return the appropriate image
    if ([overlay.title  isEqual: @"basemap"]){
        theImage= [UIImage imageNamed:@"CM_basemap.png"];
    }else{
        //if we're not drawing the basemap, check for one of our cases, and then return the proper renderer, or none at all
        if ([overlay.title  isEqual: @"carlmaps_trails_all.png"] && [checkedTrails containsObject:@"All Arb Trails"]) {
            theImage= [UIImage imageNamed:@"CM_alltrails"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_lower_long.png"] && [checkedTrails containsObject:@"Lower Arb (Long)"]){
            theImage= [UIImage imageNamed:@"CM_lower_long"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_lower_medium.png"] && [checkedTrails containsObject:@"Lower Arb (Medium)"]){
            theImage= [UIImage imageNamed:@"CM_lower_med"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_lower_short.png"] && [checkedTrails containsObject:@"Lower Arb (Short)"]){
            theImage= [UIImage imageNamed:@"CM_lower_short"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_upper_long.png"] && [checkedTrails containsObject:@"Upper Arb (Long)"]){
            theImage= [UIImage imageNamed:@"CM_upper_long"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_upper_medium.png"] && [checkedTrails containsObject:@"Upper Arb (Medium)"]){
            theImage= [UIImage imageNamed:@"CM_upper_med"];
        }else{
            return nil;
        }
    
    }
    //Return an overlayrenderer primed with the custom image
    CustomOverlayRenderer *overlayRenderer = [[CustomOverlayRenderer alloc] initWithOverlay:overlay overlayImage:theImage];
    return overlayRenderer;
    
}

- (IBAction)unwindToMap:(UIStoryboardSegue *)unwindSegue{
    centerStatus = @"Yes";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
