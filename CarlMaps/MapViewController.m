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
    IBOutlet UITableView *searchTableView;
    LocationDataSource *locSource;
    NSArray *checkedTrails;
    NSArray *pinCoords;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self loadSettings];
    [self pinSearchResult:pinCoords];
}

- (void)viewDidLoad
{
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(44.461329, -93.155607);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 400, 400)];
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.rotateEnabled = false;
    [self.mapView setDelegate:self];
    adjustedRegion.center = startCoord;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    adjustedRegion.span = span;
    self.mapView.showsUserLocation = YES;
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    //place overlays
    
    // Create a location data source
    locSource = [[LocationDataSource alloc] init];
}


-(void)loadSettings {
    // Load trails to display
    checkedTrails = [[NSUserDefaults standardUserDefaults] arrayForKey:@"trails_key"];
    pinCoords = [[NSUserDefaults standardUserDefaults] arrayForKey:@"coords_key"];
    [self placeOverlay];
}


-(void)dropPin:(NSArray*)coords {
    
    // TODO: MAYBE ADD ANIMATION? THIS IS JUST POLISHING, BUT IT LOOKS COMPLICATED, NEED TO ADD A NEW THING CALLED MKANNOTATIONVIEW
    
    // Drops pin onto map at given coordinates
    CLLocationCoordinate2D pinLoc;
    pinLoc.latitude = [coords[0] doubleValue];
    pinLoc.longitude = [coords[1] doubleValue];
    MKPointAnnotation *destinationPin = [[MKPointAnnotation alloc] init];
    destinationPin.coordinate = pinLoc;
    [self.mapView addAnnotation:destinationPin];
    
    [self.mapView setCenterCoordinate:pinLoc animated:YES];
}

-(void)pinSearchResult:(NSArray*)coords {
    NSLog(@"booty");
    // First, remove all existing pins from the map
    NSArray *existingPoints = self.mapView.annotations;
    if ([existingPoints count]) {
        [self.mapView removeAnnotations:existingPoints];
    }
    
    // Then add pin for the searched location
    [self dropPin:coords];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}


//Creates the overlays
-(void)placeOverlay{
    //Make the basemap overlay
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * 4);
    coords[0] = CLLocationCoordinate2DMake(44.486443000000001,-93.165485000000004);
    coords[1] = CLLocationCoordinate2DMake(44.455624999999998,-93.165571000000000);
    coords[2] = CLLocationCoordinate2DMake(44.486412000000001,-93.118768000000003);
    coords[3] = CLLocationCoordinate2DMake(44.455840000000002,-93.118853999999999);

    
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon.title = @"basemap";
    [self.mapView addOverlay:polygon];
    

    //Add an overlay for each of the trails
    //This is ugly but will serve
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
        theImage= [UIImage imageNamed:@"carlmaps_map.png"];
    }else{
        //if we're not drawing the basemap, check for one of our cases, and then return the proper renderer, or none at all
        if ([overlay.title  isEqual: @"carlmaps_trails_lower_long.png"] && [checkedTrails containsObject:@"Lower Arb Long Loop"]){
            theImage= [UIImage imageNamed:@"carlmaps_trails_lower_long.png"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_lower_medium.png"] && [checkedTrails containsObject:@"Lower Arb Medium Loop"]){
            theImage= [UIImage imageNamed:@"carlmaps_trails_lower_medium.png"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_lower_short.png"] && [checkedTrails containsObject:@"Lower Arb Short Loop"]){
            theImage= [UIImage imageNamed:@"carlmaps_trails_lower_short.png"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_upper_long.png"] && [checkedTrails containsObject:@"Upper Arb Long Loop"]){
            theImage= [UIImage imageNamed:@"carlmaps_trails_upper_long.png"];
        }else if ([overlay.title  isEqual: @"carlmaps_trails_upper_medium.png"] && [checkedTrails containsObject:@"Upper Arb Medium Loop"]){
            theImage= [UIImage imageNamed:@"carlmaps_trails_upper_medium.png"];
        }else{
            return nil;
        }
    
    }
    //Return an overlayrenderer primed with the custom image
    CustomOverlayRenderer *overlayRenderer = [[CustomOverlayRenderer alloc] initWithOverlay:overlay overlayImage:theImage];
    return overlayRenderer;
    
}

- (IBAction)unwindToMap:(UIStoryboardSegue *)unwindSegue{
    NSLog(@"I'm back!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
