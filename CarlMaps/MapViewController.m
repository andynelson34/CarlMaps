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

@interface MapViewController ()

@end

@implementation MapViewController {
    __weak IBOutlet MKMapView *mapView;
    __weak IBOutlet UIButton *trailsButton;
    __weak IBOutlet UISearchBar *locSearchBar;
    IBOutlet UITableView *searchTableView;
    LocationDataSource *locSource;
    KMLParser *theParser;
    MKTileOverlay *arbtrails;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    
    // TODO: I THINK WE NEED TO INCLUDE SOMETHING CALLED A "LOCATION MANAGER" TO TRACK OUR CURRENT LOCATION.
    
    /* Old Joogle Maps Stuffe
    // Create a GMSCameraPosition that tells the map to display the
    // coordinates of Carleton College at zoom level 16.5
    GMSCameraPosition *carlCamera = [GMSCameraPosition cameraWithLatitude:44.461329
                                                            longitude:-93.155607
                                                                 zoom:16.5];

    mapView.frame = CGRectZero;
    mapView.camera = carlCamera;
    mapView.myLocationEnabled = YES;
    
    //set min and max zoom, and disable rotation
    [mapView setMinZoom:14.0f maxZoom:20.0f];
    mapView.settings.rotateGestures = NO;
     
     
     //attempt to create a tile layer
     GMSTileLayer *layer = [[TileLayer alloc] init];
     layer.map = mapView;
    */;
    
    //locSearchBar.delegate = self;
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(44.461329, -93.155607);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
    [mapView setRegion:adjustedRegion animated:YES];
    mapView.rotateEnabled = false;
    
    
    //load KML files?
    //[self loadKMLfiles];
    
    //add the tiled overlay
    [self placeTiledOverlay];

    //TEST CODE DEMONSTRATING HOW LOCATIONDATASOURCE WORKS
    //Create a data source, and search for a location
    locSource = [[LocationDataSource alloc] init];
    NSString *NYC = @"New York";
    [self dropPin:[locSource searchForPlace:NYC]];
    //NSLog(@"%@",[locSource searchForPlace:CMC]);*/

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"The search button was clicked!");
    NSLog(@"%@",[locSource searchForPlace:searchBar.text]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([locSearchBar isFirstResponder] && [touch view] != locSearchBar)
    {
        [locSearchBar resignFirstResponder];
        [mapView setUserInteractionEnabled:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

/*- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [locSearchBar resignFirstResponder];
    [locSearchBar setShowsCancelButton:YES animated:YES];
}*/

-(void)dropPin:(NSArray*)pinCoords {
    CLLocationCoordinate2D pinLoc;
    pinLoc.latitude = [pinCoords[0] doubleValue];
    pinLoc.longitude = [pinCoords[1] doubleValue];
    MKPointAnnotation *destinationPin = [[MKPointAnnotation alloc] init];
    destinationPin.coordinate = pinLoc;
    [mapView addAnnotation:destinationPin];
    
}

//Add in a tiled overlay
-(void)placeTiledOverlay{
    NSString *template = @"jeff-and-moose.jpg";
    arbtrails = [[MKTileOverlay alloc] initWithURLTemplate: template];
    arbtrails.canReplaceMapContent = YES;
    [mapView addOverlay:arbtrails level: MKOverlayLevelAboveRoads];
}


//Attempt to load in a KML file
-(void)loadKMLfiles{
    // Locate the path to the route.kml file in the application's bundle
    // and parse it with the KMLParser.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KML_Samples" ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    theParser = [[KMLParser alloc] initWithURL:url];
    [theParser parseKML];
    
    // Add all of the MKOverlay objects parsed from the KML file to the map.
    NSArray *overlays = [theParser overlays];
    [mapView addOverlays:overlays];
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [theParser points];
    [mapView addAnnotations:annotations];
    
    // Walk the list of overlays and annotations and create a MKMapRect that
    // bounds all of them and store it into flyTo.
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        }else{
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    // Position the map so that all overlays and annotations are visible on screen.
    mapView.visibleMapRect = flyTo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKTileOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    return [[MKTileOverlayRenderer alloc] initWithTileOverlay:arbtrails];
}


@end
