/*
 CustomOverlay.m
 Brady Soglin.
 Displays a custom image on the map. Used for trails and a detailed map of Carleton's Campus.
 Based on this code: http://www.raywenderlich.com/30001/overlay-images-and-overlay-views-with-mapkit-tutorial
*/

#import "CustomOverlay.h"

@implementation CustomOverlay

-(instancetype)initWithRectangle:(MKMapRect)rectangle{
    self = [super init];
    if (self) {
        _boundingMapRect = rectangle;
        _coordinate = MKCoordinateForMapPoint(rectangle.origin);
    }
    return self;
}



@end