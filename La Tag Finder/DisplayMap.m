//
//  DisplayMap.m
//  MapKitDisplay
//
//  Created by Chakra on 12/07/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import "DisplayMap.h"


@implementation DisplayMap

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:placeName description:description {
    self = [super init];
    if (self != nil) {
        
        coordinate = location;
        title = placeName;
        subtitle = description;
    }
    return self;
}

@end
