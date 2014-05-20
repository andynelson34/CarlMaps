//
//  Tilelayer.m
//  CarlMaps
//
//  Created by Brady Soglin
//  
//

#import "TileLayer.h"

@implementation TileLayer

- (UIImage *)tileForX:(NSUInteger)x y:(NSUInteger)y zoom:(NSUInteger)zoom {

    /*This code tests to see if the UIImage loaded succesfully, which it has been
    UIImage *jeff = [UIImage imageNamed:@"jeff-and-moose.jpg"];
    
    CGImageRef cgref = [jeff CGImage];
    CIImage *cim = [jeff CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        NSLog(@"no underlying data");
    }
    */
   return [UIImage imageNamed:@"jeff-and-moose.jpg"];
}
@end
