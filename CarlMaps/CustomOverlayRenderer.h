/*
 CustomOverlayRenderer.h
 Brady Soglin.
 A view responsible for displaying custom overlays.
 Based on this code: http://www.raywenderlich.com/30001/overlay-images-and-overlay-views-with-mapkit-tutorial
 */

#import <MapKit/MapKit.h>

@interface CustomOverlayRenderer:MKOverlayRenderer

@property (nonatomic, strong) UIImage *overlayImage;

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage;

@end