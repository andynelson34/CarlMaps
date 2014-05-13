//
//  LocationDataSource.m
//  CarlMaps
//
//  Created by MobileDev on 5/12/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "LocationDataSource.h"

@implementation LocationDataSource {
    NSMutableDictionary *placesDict;
}

- (id)init {
    self = [super init];
    if (self) {
        
        // Parses text file and adds coordinates of each location in it to dictionary of locations that can be searched later.
        
        placesDict = [[NSMutableDictionary alloc] init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource: @"LocationsList" ofType:@"txt"];
        NSString *locString = [NSString stringWithContentsOfFile:filePath encoding: NSUTF8StringEncoding error:NULL];
        NSArray *rawLocArray = [locString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        for (NSString *rawLoc in rawLocArray) {
            NSArray *tempArray = [rawLoc componentsSeparatedByString:@"#"];
            NSString *dictKey = [tempArray objectAtIndex: 0];
            NSArray *coordsArray = @[[tempArray objectAtIndex: 1], [tempArray objectAtIndex: 2]];
            [placesDict setObject:coordsArray forKey:dictKey];
        }
    }
    return self;
}

- (NSArray*)searchForPath:(NSString*)searchString {
    
    // This is a standin method for a more advanced search algorithm with autocomplete that we will implement later.
    
    if([placesDict objectForKey:searchString]) {
        return [placesDict objectForKey:searchString];
    }
    else {
        return NULL;
    }
}

@end
