//
//  LocationDataSource.h
//  CarlMaps
//
//  Created by MobileDev on 5/12/14.
//  Copyright (c) 2014 Jonathan Knudson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationDataSource : NSObject
- (NSArray*)searchForPath:(NSString*)searchString;

@end