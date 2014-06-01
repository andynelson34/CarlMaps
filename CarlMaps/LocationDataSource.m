//
//  LocationDataSource.m
//  CarlMaps
//
//  Created by MobileDev on 5/12/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "LocationDataSource.h"

@implementation LocationDataSource

- (id)init {
    self = [super init];
    if (self) {
        
        //Creates dictionary of location GPS coordinates from plist
        
        NSString *locationResourcePath = [[NSBundle mainBundle] pathForResource:@"LocationList" ofType:@"plist"];
        self.locDict = [[NSDictionary alloc] initWithContentsOfFile:locationResourcePath];
        self.locList = [self.locDict allKeys];
    }
    return self;
}

- (NSArray*)searchForPlace:(NSString*)searchString {
    
    // This is a standin method for a more advanced search algorithm with autocomplete that we will implement soon.
    
    if([self.locDict objectForKey:searchString]) {
        return [self.locDict objectForKey:searchString];
    }
    else {
        return NULL;
    }
}

//TODO: Add method to continuously check user's current location and pass that info to the dictionary, as well as display it on the map.

@end
