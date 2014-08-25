//
//  ViewController.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/14/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "PairingViewController.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#define LINK_LOSS_UUID @"1803"
#define IMMEDIATE_ALERT_SERVICE_UUID @"1802"
#define TX_POWER_LEVEL_SERVICE_UUID @"1804"
#define BATTER_LEVEL_SERVICE_UUID @"0x2A19"
#define DEVICE_INFORMATION_UUID @"0x180A"
@interface PairingViewController ()<UITableViewDataSource,UITableViewDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>

@end

@implementation PairingViewController
@synthesize deviceTable;
@synthesize devicesNotInDBForServices;
@synthesize devicesNotInDBForDevices;
@synthesize tags=_tags;
@synthesize CBManager=_CBManager;
@synthesize discoverPeripherals;
@synthesize BluetoothDevicesLabel;
@synthesize LabaIcon;
@synthesize LatagLabel;
@synthesize detailViewController=_detailViewController;

#pragma mark -
#pragma mark View lifecycle
/****************************************************************************/
/*								View Lifecycle                              */
/****************************************************************************/
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.LabaIcon.layer.cornerRadius=4;
    [self makeTableViewDesign];
    [self makeSwipeEffect];
}
-(void)makeTableViewDesign{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    self.deviceTable.backgroundView = imageView;
    self.deviceTable.tableFooterView = [[UIView alloc] init];
}
-(void)makeSwipeEffect{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
}

- (void)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (void) viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    [self.BluetoothDevicesLabel setText:[Language get:@"BluetoothDevicesLabel" alter:Nil]];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:[Language get:@"PAIRING" alter:Nil]];
    self.navigationController.navigationBarHidden=YES;
    discoverPeripherals=[[NSMutableArray alloc]init];
    _CBManager=[[CBCentralManager alloc]initWithDelegate:self queue:Nil];
    NSDictionary *options = @{
                              CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]
                              };
    NSArray *servicesUUIDsList=@[[CBUUID UUIDWithString:IMMEDIATE_ALERT_SERVICE_UUID],[CBUUID UUIDWithString:LINK_LOSS_UUID],[CBUUID UUIDWithString:TX_POWER_LEVEL_SERVICE_UUID],[CBUUID UUIDWithString:BATTER_LEVEL_SERVICE_UUID],[CBUUID UUIDWithString:DEVICE_INFORMATION_UUID]];
    [self.CBManager scanForPeripheralsWithServices:servicesUUIDsList options:options];
    
}
-(void)startScan{
    NSDictionary *options = @{
                              CBCentralManagerOptionRestoreIdentifierKey:@"myCentralManagerIdentifier",
                              CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]
                              };
    
    [self.CBManager scanForPeripheralsWithServices:Nil options:options];
}

- (void) discoveryDidRefresh
{
    devicesNotInDBForDevices=[[NSMutableArray alloc]init];
    AppDelegate *objAppDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Tags" inManagedObjectContext:objAppDelegate.managedObjectContext];
    [request setEntity:entity];
    NSMutableArray *arryPeripeharlList=[[NSMutableArray alloc]init];
    for (int j=0; j<discoverPeripherals.count;j++ ) {
        CBPeripheral *PeripheralFinding=(CBPeripheral*)[discoverPeripherals objectAtIndex:j];
        [arryPeripeharlList addObject:PeripheralFinding];
    }
    
    for (CBPeripheral *checkPeripheralDevice in arryPeripeharlList) {
        
        NSString *uuidForAddressCheck1 = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, (__bridge CFUUIDRef)(checkPeripheralDevice.identifier));
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"address== %@",uuidForAddressCheck1];
        [request setPredicate:predicate];
        NSError *error1=nil;
        NSMutableArray *mutableArrayResults1=[[objAppDelegate.managedObjectContext executeFetchRequest:request error:&error1]mutableCopy];
        
        if (mutableArrayResults1.count==0) {
            [devicesNotInDBForDevices addObject:checkPeripheralDevice];
        }
    }
    [deviceTable reloadData];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            break;
        case CBCentralManagerStatePoweredOff:
            break;
            
        case CBCentralManagerStateUnsupported: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dang."
                                                            message:@"Unfortunately this device can not talk to Bluetooth Smart (Low Energy) Devices"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Dismiss"
                                                  otherButtonTitles:nil];
            
            [alert show];
            break;
        }
        case CBCentralManagerStateResetting: {
            
            break;
        }
        case CBCentralManagerStateUnauthorized:
            break;
            
        case CBCentralManagerStateUnknown:
            break;
            
        default:
            break;
    }
}
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if ([[advertisementData objectForKey:CBAdvertisementDataLocalNameKey] isEqualToString:@"LA-TAG a87"]) {
        if (![discoverPeripherals containsObject:peripheral]) {
            [discoverPeripherals addObject:peripheral];

        }
    }
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return FALSE;
}


#pragma mark -
#pragma mark TableView Delegates
/****************************************************************************/
/*							TableView Delegates								*/
/****************************************************************************/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell	*cell;
	CBPeripheral	*peripheral;
    static NSString *cellID = @"DeviceList";
    
	cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    peripheral=[devicesNotInDBForDevices objectAtIndex:indexPath.row];
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        [[cell textLabel]setFont:[UIFont boldSystemFontOfSize:18]];
        [[cell detailTextLabel]setFont:[UIFont systemFontOfSize:16]];
    }
    else{
        [[cell textLabel]setFont:[UIFont boldSystemFontOfSize:25]];
        [[cell detailTextLabel]setFont:[UIFont systemFontOfSize:23]];
        
    }
    [[cell textLabel] setText:@"La Tag"];
    [[cell textLabel]setTextAlignment:NSTextAlignmentCenter];
    [[cell textLabel]setTextColor:[UIColor whiteColor]];
    NSString *uuid = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, (__bridge CFUUIDRef)(peripheral.identifier));
    [[cell detailTextLabel] setText: uuid];
    [[cell detailTextLabel]setText:uuid];
    [[cell detailTextLabel] setNumberOfLines:2];
    [[cell detailTextLabel]setTextColor:[UIColor whiteColor]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    UITableViewCell  *cell =[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f] ForCell:cell];  //highlight colour
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    UITableViewCell  *cell =[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor clearColor] ForCell:cell]; //normal color
}
- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return devicesNotInDBForDevices.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_detailViewController == nil)
    {
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
            if (iOSDeviceScreenSize.height == 568)
            {
                self.detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Detail"];
            }
        }
        
    }
    CBPeripheral *peripheral=[devicesNotInDBForDevices objectAtIndex:indexPath.row];
    
    self.detailViewController.address=(__bridge_transfer NSString *)CFUUIDCreateString(NULL, (__bridge CFUUIDRef)(peripheral.identifier));
    
    UIAlertView *pairAlert=[[UIAlertView alloc]initWithTitle:[Language get:@"Do you want to pair?" alter:Nil] message:Nil delegate:self cancelButtonTitle:Nil otherButtonTitles:[Language get:@"YES" alter:Nil],[Language get:@"NO" alter:Nil], nil];
    [pairAlert show];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        return 70;
        
    }
    else{
        
        return 100;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self.tabBarController hidesBottomBarWhenPushed];
            [self.navigationController pushViewController:self.detailViewController animated:YES];
            break;
            
        default:
            break;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    //  [self.CBManager stopScan];
}
- (IBAction)PairingButton:(id)sender;
{
    [self startScan];
    [self discoveryDidRefresh];
   // [deviceTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
}
@end