/*
 CustomOverlay.h
 Brady Soglin.
 Displays a custom image on the map. Used for trails and a detailed map of Carleton's Campus.
 Based on this code: http://www.raywenderlich.com/30001/overlay-images-and-overlay-views-with-mapkit-tutorial
 */

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomOverlay: NSObject<MKOverlay>

@property (nonatomic, readonly) MKMapRect boundingMapRect;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithRectangle:(MKMapRect)rectangle;

@end