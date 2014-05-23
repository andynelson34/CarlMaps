//
//  TrailDataSource.m
//  CarlMaps
//
//  Created by MobileDev on 5/22/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import "TrailDataSource.h"

@implementation TrailDataSource

- (id)init {
    self = [super init];
    if (self) {
        
        // Creates array of trails and their on-display/off-display status from plist
        
        NSString *trailResourcePath = [[NSBundle mainBundle] pathForResource:@"TrailList" ofType:@"plist"];
        self.trails = [[NSMutableArray alloc] initWithContentsOfFile:trailResourcePath];
    }
    return self;
}

@end