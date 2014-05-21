//
//  ViewController.m
//  CarlMaps
//
//  Created by Jonathan Knudson on 5/7/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "MapViewController.h"
#import "LocationDataSource.h"
#import "KMLParser.h"
#import "TileLayer.h"
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
    
    //load KML files?
    [self loadKMLfiles];

    //attempt to create a tile layer
    GMSTileLayer *layer = [[TileLayer alloc] init];
    layer.map = mapView;

    /*TEST CODE DEMONSTRATING HOW LOCATIONDATASOURCE WORKS
    //Create a data source, and search for a location
    testSource = [[LocationDataSource alloc] init];
    NSString *CMC = @"CMC";
    NSLog(@"%@",[testSource searchForPath:CMC]);*/

}

//TOYING AROUND WITH A FEW IDEAS HERE:
/*
This currently will parse the "arb_trails" KML file.
It's based on something that works for MK files for Apple Maps, but I was
hoping I could use it for us. -Brady
*/
-(void)loadKMLfiles{
    // Locate the path to the route.kml file in the application's bundle
    // and parse it with the KMLParser.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"arbtrails" ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    KMLParser *theParser = [[KMLParser alloc] initWithURL:url];
    [theParser parseKML];
    /*
    // Add all of the MKOverlay objects parsed from the KML file to the map.
    NSArray *overlays = [theParser overlays];
    [mapView addOverlays:overlays];
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    //NSArray *annotations = [theParser points];
    //[mapView addAnnotations:annotations];
    
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
    map.visibleMapRect = flyTo;
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
