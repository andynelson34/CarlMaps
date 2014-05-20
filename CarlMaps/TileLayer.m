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
    if ([UIImage imageNamed:@"jeff-and-moose"] == nil){
        NSLog(@"aaasdsady");
    }
    return [UIImage imageNamed:@"jeff-and-moose"];
}
@end
