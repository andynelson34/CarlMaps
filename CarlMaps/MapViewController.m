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
    NSArray *trailStatuses;
    bool showJeff;
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
    
    //place overlays
    [self placeOverlay];
    
    
    // Create a location data source
    locSource = [[LocationDataSource alloc] init];
    
    self.mapView.showsUserLocation = YES;
    
    //randomly toggle showing jeff's face
    int i = arc4random()%3;
    if (i == 1){
        showJeff = TRUE;
    }else{
        showJeff = FALSE;
    }
    
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
/*
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
*/

/*-(void)dropPin:(NSArray*)pinCoords {
    
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
}*/

//Add in a normal overlay
-(void)placeOverlay{
    //TEMPORARY: make two random overlays.
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * 4);
    coords[0] = CLLocationCoordinate2DMake(44.46141,-93.154928);
    coords[1] = CLLocationCoordinate2DMake(44.46141,-93.1543);
    coords[2] = CLLocationCoordinate2DMake(44.460802,-93.154928);
    coords[3] = CLLocationCoordinate2DMake(44.460802,-93.1543);
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon.title = @"baldspot";
    
    [self.mapView addOverlay:polygon];

    
    coords[0] = CLLocationCoordinate2DMake(44.46241,-93.155928);
    coords[1] = CLLocationCoordinate2DMake(44.46241,-93.1553);
    coords[2] = CLLocationCoordinate2DMake(44.463802,-93.155928);
    coords[3] = CLLocationCoordinate2DMake(44.463802,-93.1553);
    polygon = [MKPolygon polygonWithCoordinates:coords count:4];
    polygon.title = @"other one";
    [self.mapView addOverlay:polygon];
}

//Tells the MapView which renderer to use
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay{
    UIImage *theImage;
    
    //RIGHT NOW I am using "other one" as an example of what could be a trail overlay, and "baldspot" as an overlay we always want to show
    //the variable "showjeff" says whether or not we want to display the trail overlay, randomly
    
    //check which overlay is being drawn, and return the appropriate image
    if ([overlay.title  isEqual: @"baldspot"]){
         theImage= [UIImage imageNamed:@"jeff-and-moose.jpg"];
    }else if ([overlay.title  isEqual: @"other one"]){
        if (showJeff){
            theImage= [UIImage imageNamed:@"jeff-handsome.jpg"];
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    
    //Return an overlayrenderer primed with the custom image
    CustomOverlayRenderer *overlayRenderer = [[CustomOverlayRenderer alloc] initWithOverlay:overlay overlayImage:theImage];
    return overlayRenderer;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
