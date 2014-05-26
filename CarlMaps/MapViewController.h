//
//  MapViewController.h
//  CarlMaps
//
//  Created by Jonathan Knudson on 5/7/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end