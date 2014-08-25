//
//  MapViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayMap.h"
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    
}
@property(nonatomic,strong) NSNumber *latitudeNumber;
@property(nonatomic,strong) NSNumber *longitudeNumber;
@property(nonatomic,strong)NSString *lastFoundTime;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mapSegmentedControl;

- (IBAction)mapTypeChanged:(id)sender;
- (IBAction)backButton:(id)sender;
@end
