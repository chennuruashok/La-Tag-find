//
//  Tags.h
//  LaTag_v2.0
//
//  Created by Apple on 15/03/14.
//  Copyright (c) 2014 Prakash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tags : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic,assign) BOOL alert;
@property (nonatomic, retain) NSNumber * batterypercentage;
@property (nonatomic, retain) NSString * colorName;
@property (nonatomic, retain) NSString * deviceName;
@property (nonatomic, retain) NSString * imageData;
@property (nonatomic,assign) BOOL isLongDistance;
@property (nonatomic,assign )BOOL isRingTone;
@property (nonatomic, retain) NSString * lastFoundDate;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * ringTone;
@property (nonatomic,assign) BOOL sosAlert;
@property (nonatomic, retain) NSString * sosEmail;
@property (nonatomic, retain) NSString * sosMessage;
@property (nonatomic, retain) NSString * sosName;

@end
