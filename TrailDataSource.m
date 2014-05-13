//
//  TrailDataSource.m
//  CarlMaps
//
//  Created by MobileDev on 5/12/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "TrailDataSource.h"

@implementation TrailDataSource {
    NSMutableDictionary *trailsDict;
}

- (id)init {
    self = [super init];
    if (self) {
        
        // Parses text file and adds coordinates of each location in it to dictioanry of locations that can be searched later.
        
        trailsDict = [[NSMutableDictionary alloc] init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource: @"TrailsList" ofType:@"txt"];
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


@end
