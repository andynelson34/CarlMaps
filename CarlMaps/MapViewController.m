//
//  MapViewController.m
//  CarlMaps
//
//  Created by Jonathan Knudson on 5/7/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "MapViewController.h"
#import "LocationDataSource.h"
#import "KMLParser.h"
#import "CustomOverlay.h"
#import "CustomOverlayRenderer.h"

@interface MapViewController ()

@end

@implementation MapViewController {
    __weak IBOutlet UIButton *trailsButton;
    __weak IBOutlet UISearchBar *locSearchBar;
    IBOutlet UITableView *searchTableView;
    LocationDataSource *locSource;
    NSArray *trailStatuses;
    KMLParser *theParser;
    MKTileOverlay *arbtrails;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self loadSettings];
}

- (void)viewDidLoad
{
    //locSearchBar.delegate = self;
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(44.461329, -93.155607);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 400, 400)];
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.rotateEnabled = false;
    adjustedRegion.center = startCoord;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    adjustedRegion.span = span;
    
    [self.mapView setRegion:adjustedRegion animated:YES];
    [self placeOverlay];
    
    
    
    //load KML files?
    //[self loadKMLfiles];
    
    //add the tiled overlay
    
    // Create a location data source
    locSource = [[LocationDataSource alloc] init];
    
    self.mapView.showsUserLocation = YES;
    //NSLog(@"%@",[locSource searchForPlace:CMC]);*/
    
}

/*- (void)saveSettings{
 // Store the data
 NSMutableArray *checkmarkedTrails;
 int saveSlide = self.erotic_slider.value;
 [[NSUserDefaults standardUserDefaults] setObject:saveString forKey:@"haiku_key"];
 [[NSUserDefaults standardUserDefaults] setInteger:saveSlide forKey:@"slider_key"];
 }*/

-(void)loadSettings {
    
    // Load trails to display
    self->trailStatuses = [[NSUserDefaults standardUserDefaults] arrayForKey:@"trails_key"];
    NSLog(@"%@", self->trailStatuses);
}

/*-(void)saveSettings {
 [[NSUserDefaults standardUserDefaults] setObject:trailStatuses forKey:@"trails_key"];
 }*/

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // Carries out search for a given location
    NSArray *searchCoords = [locSource searchForPlace:searchBar.text];
    
    // Removes keyboard if search is successful
    if ([locSource searchForPlace:searchBar.text]) {
        if ([locSearchBar isFirstResponder])
        {
            [locSearchBar resignFirstResponder];
            [self.mapView setUserInteractionEnabled:YES];
        }
    }
    
    // Places pin on map at coordinates for search result if a result was found
    if (searchCoords != nil) {
        [self pinSearchResult:searchCoords];
        NSLog(@"%@",[locSource searchForPlace:searchBar.text]);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([locSearchBar isFirstResponder] && [touch view] != locSearchBar)
    {
        [locSearchBar resignFirstResponder];
        [self.mapView setUserInteractionEnabled:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

/*- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
 [locSearchBar resignFirstResponder];
 [locSearchBar setShowsCancelButton:YES animated:YES];
 }*/

-(void)dropPin:(NSArray*)pinCoords {
    
    // TODO: MAYBE ADD ANIMATION? THIS IS JUST POLISHING, BUT IT LOOKS COMPLICATED, NEED TO ADD A NEW THING CALLED MKANNOTATIONVIEW
    
    // Drops pin onto map at given coordinates
    CLLocationCoordinate2D pinLoc;
    pinLoc.latitude = [pinCoords[0] doubleValue];
    pinLoc.longitude = [pinCoords[1] doubleValue];
    MKPointAnnotation *destinationPin = [[MKPointAnnotation alloc] init];
    destinationPin.coordinate = pinLoc;
    [self.mapView addAnnotation:destinationPin];
    
    [self.mapView setCenterCoordinate:pinLoc animated:YES];
}

-(void)pinSearchResult:(NSArray*)pinCoords {
    
    // First, remove all existing pins from the map
    NSArray *existingPoints = self.mapView.annotations;
    if ([existingPoints count]) {
        [self.mapView removeAnnotations:existingPoints];
    }
    
    // Then add pin for the searched location
    [self dropPin:pinCoords];
}

//Add in a normal overlay
-(void)placeOverlay{
    // draw MKRectangle on the map using the outline coordinates of the building
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * 4);
    coords[0] = CLLocationCoordinate2DMake(44.4608902423,-93.1567658615);
    coords[1] = CLLocationCoordinate2DMake(44.4608902423,-93.1568401051);
    coords[1] = CLLocationCoordinate2DMake(44.4605042217,-93.156478259);
    coords[1] = CLLocationCoordinate2DMake(44.4605558631,-93.156523186);
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:4];
    
    [self.mapView addOverlay:polygon];
}

//Tells the MapView which renderer to use
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay{
    NSLog(@"I was called");
    UIImage *jeffImage = [UIImage imageNamed:@"jeff-and-moose.jpg"];
    CustomOverlayRenderer *overlayRenderer = [[CustomOverlayRenderer alloc] initWithOverlay:overlay overlayImage:jeffImage];
    return overlayRenderer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
