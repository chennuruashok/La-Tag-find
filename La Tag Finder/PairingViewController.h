//
//  ViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/14/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface PairingViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableArray *_tags;
    NSMutableArray *discoverPeripherals;
    DetailViewController *_detailViewController;
}

@property(nonatomic,retain)NSMutableArray *discoverPeripherals;
@property(nonatomic,retain) CBCentralManager *CBManager;
@property(nonatomic,retain)  NSMutableArray *devicesNotInDBForServices;
@property(nonatomic,retain)  NSMutableArray *devicesNotInDBForDevices;
@property (retain) NSMutableArray *tags;
@property (retain) DetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UIImageView *LabaIcon;
@property (strong, nonatomic) IBOutlet UILabel *LatagLabel;
@property (strong, nonatomic) IBOutlet UILabel *BluetoothDevicesLabel;
@property (strong, nonatomic) IBOutlet UIButton *PairingButton;
@property (strong, nonatomic) IBOutlet UITableView *deviceTable;



- (void)makeTableViewDesign;
- (void)startScan;
- (void)makeSwipeEffect;
- (IBAction)PairingButton:(id)sender;
@end
