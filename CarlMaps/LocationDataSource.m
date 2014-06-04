//
//  LocationDataSource.m
//  CarlMaps
//
//  Created by MobileDev on 5/12/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

/*Thanks to the CarlTour group for giving us access to the building borders coordinate data they scraped off the Carleton website,
 which we parsed and averaged to get our building coordinates.*/

#import "LocationDataSource.h"

@implementation LocationDataSource

- (id)init {
    self = [super init];
    if (self) {
        
        //Creates dictionary of location GPS coordinates from plist
        
        NSString *locationResourcePath = [[NSBundle mainBundle] pathForResource:@"LocationList" ofType:@"plist"];
        self.locDict = [[NSDictionary alloc] initWithContentsOfFile:locationResourcePath];
        self.locList = [[self.locDict allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    }
    return self;
}

@end
