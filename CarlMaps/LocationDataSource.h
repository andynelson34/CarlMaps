//
//  LocationDataSource.h
//  CarlMaps
//
//  Created by MobileDev on 5/12/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDataSource : NSObject
- (NSArray*)searchForPlace:(NSString*)searchString;

@property NSDictionary *locDict;
@property NSArray *locList;

@end