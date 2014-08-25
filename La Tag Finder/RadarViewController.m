//
//  RadarViewController.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "RadarViewController.h"
#import "Tags.h"
#import "Language.h"
#import "NSData+Base64Additions.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>


#define LINK_LOSS_UUID @"1803"
#define IMMEDIATE_ALERT_SERVICE_UUID @"1802"
#define TX_POWER_LEVEL_SERVICE_UUID @"1804"
#define BATTER_LEVEL_SERVICE_UUID @"0x180F"
#define BATTERY_LEVEL_CHARECTERISTIC_UUID @"0x2A19"
#define DEVICE_INFORMATION_UUID @"0x180A"
#define IMMEDIATE_ALERT_CHARECTERISTIC_UUID @"2A06"


BOOL isAVailaable;
BOOL animating=FALSE;
@interface RadarViewController ()

@end

@implementation RadarViewController

@synthesize songsListinSDCard;
@synthesize audioPlayer;
@synthesize mediaQuery;
@synthesize findTagTimer;
@synthesize currentPeripheral;
@synthesize CBManager;
@synthesize connected;
@synthesize batteryPercentage;
@synthesize tags=_tags;
@synthesize LabaIcon;
@synthesize LatagLabel;
@synthesize radarViewImage;
@synthesize searchingImage;
@synthesize radarTag=_radarTag;
@synthesize findTagButton=_findTagButton;
@synthesize deviceLabel=_deviceLabel;
@synthesize rightButton=_rightButton;
@synthesize leftButton=_leftButton;
@synthesize signalStrength=_signalStrength;
@synthesize alertButton;
@synthesize theAudio=_theAudio;
@synthesize musicFile=_musicFile;
@synthesize SKSMPTPmessage=_SKSMPTPmessage;
@synthesize locationManager=_locationManager;
@synthesize alertDetail;

CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;

bool isConnected=false;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.LabaIcon.layer.cornerRadius = 4;
    self.LatagLabel.layer.cornerRadius=20;
    [self setValueToBoolVariables];
    [self memoryInitialize];
    //[self loadLocationFinder];
    [self makeSwipeEffect];
    
}
-(void)setValueToBoolVariables{
    self.searchingImage.hidden=YES;
    self.signalStrength.hidden=YES;
    isAVailaable=FALSE;
    isTagAvialable=FALSE;
    isDBUpdatedWithLocation=NO;
    isValueWriteToTAg=NO;
    alertButton.hidden=YES;
    // loadTagEnable=FALSE;
    isDBUpdatedWithBatteryLevel=FALSE;
    phoneAlertValidation=TRUE;
}
-(void)memoryInitialize{
    self.songsListinSDCard = [[NSMutableArray alloc]init];
    audioPlayer = [[AVPlayer alloc] init];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    self.mediaQuery = [[MPMediaQuery alloc] init];
    NSArray *itemsFromGenericQuery = [self.mediaQuery items];
    self.songsListinSDCard = [NSMutableArray arrayWithArray:itemsFromGenericQuery];
    _tags=[[NSMutableArray alloc]init];
    discoverdPeripherals=[[NSMutableArray alloc]init];
    self.CBManager=[[CBCentralManager alloc]initWithDelegate:self queue:Nil];
}
-(void)makeSwipeEffect{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}
- (void)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (void)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex - 1];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [self loadLocalizeText];
   // self.navigationController.navigationBarHidden=YES;
   // tagCount=0;
   // [self setCentralManager];
}

- (void)setCentralManager{
    mailSendingBool=TRUE;
    if (currentPeripheral !=Nil) {
        if ([self peripheralFindingForAvailable]){
            [self prepareDBForTagInfo];
            [self prepareDataForTag:tagNumber];
        }
        else{
            isManuallyDisconnecting=YES;
            [self.CBManager cancelPeripheralConnection:self.currentPeripheral];
            isTagAvialable=TRUE;
            self.radarViewImage.hidden=YES;
            [self loadTag];
        }
        
    }
    else{
        [self loadTag];
        NSDictionary *options = @{
                                  CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]
                                  };
        NSArray *servicesUUIDsList=@[[CBUUID UUIDWithString:IMMEDIATE_ALERT_SERVICE_UUID],[CBUUID UUIDWithString:LINK_LOSS_UUID],[CBUUID UUIDWithString:TX_POWER_LEVEL_SERVICE_UUID],[CBUUID UUIDWithString:BATTER_LEVEL_SERVICE_UUID],[CBUUID UUIDWithString:DEVICE_INFORMATION_UUID]];
        [self.CBManager scanForPeripheralsWithServices:servicesUUIDsList options:options];
        
    }
}
- (void)loadLocationFinder{
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;// 1000;  // 1 kilometer
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    deviceLatitude=newLocation.coordinate.latitude;
    deviceLongitude=newLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CBCentralManagerDelegate Methods
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
- (void)sendMessageInBack
{
	
/*	NSLog(@"Start Sending");
    
    mailSendingBool=FALSE;
	
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	//NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"sample.pdf"];
	
	
	
	//NSData *dataObj = [NSData dataWithContentsOfFile:writableDBPath];
	
	self.SKSMPTPmessage= [[SKPSMTPMessage alloc] init];
    
	self.SKSMPTPmessage.fromEmail = @"la.tag.sos@gmail.com";//nimit51parekh@gmail.com
	
	self.SKSMPTPmessage.toEmail =sosMailId;//sender mail id
    
    self.SKSMPTPmessage.relayHost = @"smtp.gmail.com";
	
	self.SKSMPTPmessage.requiresAuth = YES;
    
	self.SKSMPTPmessage.login = @"la.tag.sos@gmail.com";//nimit51parekh@gmail.com
	
	self.SKSMPTPmessage.pass = @"25193454laba";
	
	self.SKSMPTPmessage.subject =[NSString stringWithFormat:@"LaTag_v2.0:%@ Tag Lost",tagNameForALert];
    
    self.SKSMPTPmessage.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
	
	// Only do this for self-signed certs!
	
	// testMsg.validateSSLChain = NO;
	
	self.SKSMPTPmessage.delegate = self;
    
    NSDate *myNSDateInstance=[NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MM-dd-yy HH:mm"];
    NSString *stringFromDate = [f stringFromDate:myNSDateInstance];
    
    NSString *prepareBodyFormail=[NSString stringWithFormat:@"<h4>http://maps.google.com/?q=%f,%f</h4><br><span style='color:red'>DATE</span>:%@<br> <span style='color:red'>MESSAGE</span>:%@",deviceLatitude,deviceLongitude,stringFromDate,sosMessage];
	
	NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/html",kSKPSMTPPartContentTypeKey,
							   prepareBodyFormail,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
	//Logic for attach file.
    
    //	NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"sample.pdf\"",kSKPSMTPPartContentTypeKey,@"attachment;\r\n\tfilename=\"sample.pdf\"",kSKPSMTPPartContentDispositionKey,[dataObj encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    //    NSLog(@"%@",vcfPart);
    //	testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
    
    
    //    testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
    
    self.SKSMPTPmessage.parts = [NSArray arrayWithObjects:plainPart,nil];
	
	[self.SKSMPTPmessage send];
	
    
}


-(void)messageSent:(SKPSMTPMessage *)message
 {
	
    [ALToastView toastInView:self.view withText:[Language get:@"Mail Sent" alter:Nil]];
    
    mailSendingBool=TRUE;
    self.SKSMPTPmessage=Nil;
}
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    self.SKSMPTPmessage=Nil;
    mailSendingBool=TRUE;
	// open an alert with just an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
    
	NSLog(@"delegate - error(%ld): %@", (long)[error code], [error localizedDescription]);*/
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    
    if (!isTagAvialable) {
        [self updateDBWithLatitudeandLongitude];
    }
    if (isManuallyDisconnecting) {
        [audioPlayer pause];
        [self.theAudio pause];
        [self loadTag];
    }
    else{
        [self PlayRingToneAndMakeTagBlinkingOn];
        NSDate *pickerDate = [NSDate date];
        // Schedule the notification
        UILocalNotification* LinkLossLocalNotification = [[UILocalNotification alloc] init];
        LinkLossLocalNotification.fireDate = pickerDate;
        LinkLossLocalNotification.alertBody =[NSString stringWithFormat:@"%@ %@",self.deviceLabel.text,[Language get:@"Tag is in Out Of Range" alter:Nil]];
        LinkLossLocalNotification.alertAction = @"Show me the linkLossAlert";
        LinkLossLocalNotification.timeZone = [NSTimeZone defaultTimeZone];
        // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[UIApplication sharedApplication] scheduleLocalNotification:LinkLossLocalNotification];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData1" object:self];
        [self.tabBarController.tabBar setHidden:NO];
        UIAlertView *outOfRanageAlert=[[UIAlertView alloc]initWithTitle:[Language get:@"OUT OF RANGE" alter:Nil] message:
                                       [NSString stringWithFormat:@"%@ %@",tagNameForALert,[Language get:@"Tag is in Out Of Range" alter:Nil]]  delegate:self cancelButtonTitle:NO otherButtonTitles:@"Ok", nil];
        outOfRanageAlert.tag=111;
        [outOfRanageAlert show];
        [self.radarViewImage setHidden:YES];
    }
  
    isValueWriteToTAg=FALSE;
    alertBool=NO;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"connected"];
    [self.tabBarController.tabBar setHidden:NO];
    isDBUpdatedWithBatteryLevel=FALSE;
    isAVailaable=FALSE;
    isTagAvialable=FALSE;
    isDBUpdatedWithLocation=NO;
    [peripheral setDelegate:nil];
    [self.currentPeripheral setDelegate:Nil];
    self.currentPeripheral=Nil;
    peripheral=Nil;
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    if (![discoverdPeripherals containsObject:peripheral ]) {
        [discoverdPeripherals addObject:peripheral];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
	}
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if ([service.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_SERVICE_UUID]]) {
        for (CBCharacteristic *checkChar in  service.characteristics) {
            if ([checkChar.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_CHARECTERISTIC_UUID]]) {
                [self.currentPeripheral setNotifyValue:YES forCharacteristic:checkChar];
                
            }
            
        }
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:BATTER_LEVEL_SERVICE_UUID]]) {
        for (CBCharacteristic *checkChar in  service.characteristics) {
            if ([checkChar.UUID isEqual:[CBUUID UUIDWithString:BATTERY_LEVEL_CHARECTERISTIC_UUID]]) {
                [self.currentPeripheral setNotifyValue:YES forCharacteristic:checkChar];
                
            }
        }
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
  /*if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_CHARECTERISTIC_UUID]] ) {
        if (alertBool) {
            if (sosAlert) {
                if (mailSendingBool) {
                  /  Reachability *kCFHostReachability = [Reachability reachabilityForInternetConnection];
                    NetworkStatus networkStatus = [kCFHostReachability currentReachabilityStatus];
                    if (networkStatus == NotReachable) {
                        if (phoneAlertValidation) {
                            [ALToastView toastInView:self.view withText:[Language get:@"Check the Internet Connection" alter:nil]];
                            phoneAlertValidation=FALSE;
                        }
                    }else
                        [self sendMessageInBack];
                }
                else
                    [ALToastView toastInView:self.view withText:[Language get:@"Please wait, Mail Sending..." alter:Nil]];
                
            }
            else{
                [self PlayRingToneAndMakeTagBlinkingOn];
                [self.tabBarController.tabBar setHidden:YES];
                if (phoneAlertValidation) {
                    UIAlertView *phoneAlert=[[UIAlertView alloc]initWithTitle:[Language get:@"\xF0\x9F\x93\xB1 Phone Find" alter:Nil] message:
                                             [NSString stringWithFormat:@"%@ %@",tagNameForALert,[Language get:@"Tag wants to find your phone" alter:Nil]] delegate:self cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
                    phoneAlertValidation=FALSE;
                    [phoneAlert show];
                }
                UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                localNotification.fireDate = [NSDate date];
                localNotification.alertBody = [NSString stringWithFormat:@"%@ %@",self.TagName.text,[Language get:@"Tag wants to find your phone" alter:Nil]];
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            }
        }
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BATTERY_LEVEL_CHARECTERISTIC_UUID]] ) {
        if (characteristic.isNotifying) {
            [findTagTimer invalidate];
            self.tabBarController.tabBar.hidden=YES;
            self.radarView.hidden=NO;
            [self stopSpin];
            alertBool=YES;
            isManuallyDisconnecting=NO;
            [self.searchingLabel setHidden:YES];
            [self calucalteBatteryLevel:characteristic.value];
            [self.currentPeripheral readRSSI];
            isAVailaable=TRUE;
        }
    }
    if (!isValueWriteToTAg) {
        [self writeDataForLinkLoss];
        
    }
    if (!isDBUpdatedWithLocation) {
        
        [self.locationManager startUpdatingLocation];
    }*/
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==100) {
        switch (buttonIndex) {
            case 0:
            {
                UIApplication *app = [UIApplication sharedApplication];
                [app performSelector:@selector(suspend)];
                
                //wait 2 seconds while app is going background
                [NSThread sleepForTimeInterval:2.0];
                
                //exit app when app is in background
                exit(0);
                
                //wait 2 seconds while app is going background
                [NSThread sleepForTimeInterval:2.0];
                
                //exit app when app is in background
                exit(0);
                
                break;
            }
                
            default:
                break;
        }
        
    }
    else{
        
        switch (buttonIndex) {
            case 0:
                [self PlayRingToneAndMakeTagBlinkingOff];
                phoneAlertValidation=TRUE;
                if (alertView.tag==111) {
                    [self loadTag];
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)writeDataForLinkLoss{
    for (CBService *service1 in self.currentPeripheral.services) {
        if ([service1.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_SERVICE_UUID]]) {
            for (CBCharacteristic *char1 in service1.characteristics) {
                if ([char1.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_CHARECTERISTIC_UUID]]) {
                    UInt8 data = 0x05;
                    [self.currentPeripheral  writeValue:[NSData dataWithBytes:&data length:sizeof(data)] forCharacteristic:char1 type:CBCharacteristicWriteWithoutResponse];
                    isValueWriteToTAg=TRUE;
                    return;
                }
            }
        }
    }
    
}
- (void)writeDataForAlarmOn{
    for ( CBService *service in self.currentPeripheral.services ) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_SERVICE_UUID]]) {
            for ( CBCharacteristic *characteristic in service.characteristics ) {
                if ([characteristic.UUID  isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_CHARECTERISTIC_UUID]]) {
                    UInt8 data = 0x02;
                    [self.currentPeripheral writeValue:[NSData dataWithBytes:&data length:sizeof(data)] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
                    return;
                }
            }
        }
        
    }
}
- (void)writeDataForAlarmOff
{
    for ( CBService *service in self.currentPeripheral.services )
    {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_SERVICE_UUID]])
        {
            for ( CBCharacteristic *characteristic in service.characteristics )
            {
                if ([characteristic.UUID  isEqual:[CBUUID UUIDWithString:IMMEDIATE_ALERT_CHARECTERISTIC_UUID]])
                {
                    UInt8 data = 0x00;
                    [self.currentPeripheral writeValue:[NSData dataWithBytes:&data length:sizeof(data)] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
                    return;
                }
            }
        }
    }
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    
    if( self.currentPeripheral )
        
    {
        [self.currentPeripheral setDelegate:nil];
        self.currentPeripheral = nil;
    }
}

#pragma mark - CBPeripheralDelegate Methods

- (void)performUpdateRSSI:(NSArray *)args {
    CBPeripheral *peripheral = args[0];
    [peripheral readRSSI];
    
}
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    /*if (peripheral.state == CBPeripheralStateConnected) {
        NSArray *args = @[peripheral];
        [self performSelector:@selector(performUpdateRSSI:) withObject:args afterDelay:4.0];
        NSString  *rssiString=[NSMutableString stringWithFormat:[Language get:@"Signal Strength:%d" alter:Nil],[peripheral.RSSI integerValue]];
        [self.RSSI setText:rssiString];
        if (abs([peripheral.RSSI integerValue]) <50) {
            self.radarImage4.hidden=NO;
            self.radarImage3.hidden=NO;
            self.radarImage2.hidden=NO;
            self.radarImage1.hidden=NO;
            
        }
        else if(abs([peripheral.RSSI integerValue])>50 &&abs([peripheral.RSSI integerValue])<65){
            self.radarImage4.hidden=YES;
            self.radarImage3.hidden=NO;
            self.radarImage2.hidden=NO;
            self.radarImage1.hidden=NO;
            
        }
        else if (abs([peripheral.RSSI integerValue])>65&&abs([peripheral.RSSI integerValue])<80){
            
            self.radarImage4.hidden=YES;
            self.radarImage3.hidden=YES;
            self.radarImage2.hidden=NO;
            self.radarImage1.hidden=NO;
        }
        else if (abs([peripheral.RSSI integerValue]>80)){
            
            self.radarImage4.hidden=YES;
            self.radarImage3.hidden=YES;
            self.radarImage2.hidden=YES;
            self.radarImage1.hidden=NO;
            
            
        }
        else if(abs([peripheral.RSSI integerValue])>80)
        {
            if (!isLongDistance) {
                if (isConnected) {
                    if (self.currentPeripheral) {
                        isManuallyDisconnecting=NO;
                        [self.CBManager cancelPeripheralConnection:self.currentPeripheral];
                    }
                }
            }
            
        }
    }
    
    return;*/
}
- (void)peripheralDidUpdateRSSI1:(CBPeripheral *)peripheral error:(NSError *)error {
    if (peripheral.state == CBPeripheralStateConnected) {
        NSArray *args = @[peripheral];
        [self performSelector:@selector(performUpdateRSSI:) withObject:args afterDelay:4.0];
    }
    
    return;
    
}
-(void)calucalteBatteryLevel:(NSData *)batterydata{
    char batlevel;
    AVSpeechSynthesizer *speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"Connected Succesfully"];
    [speechSynthesizer speakUtterance:utterance];
    [batterydata getBytes:&batlevel length:1];
    self.batteryPercentage = (float)batlevel;
    if (!isDBUpdatedWithBatteryLevel) {
        [ self upDateDBWithBatteryLevel];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self becomeFirstResponder];
    return YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return FALSE;
}

-(void)loadTag {
    [self prepareDBForTagInfo];
    if ([_tags count] >=1) {
        tagCount=_tags.count-1;
        tagNumber=tagCount;
    }
    [self prepareDataForTag:tagCount];
}
-(void)prepareDBForTagInfo{
    AppDelegate *objAppDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate] ;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Tags" inManagedObjectContext:objAppDelegate.managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSError *error;
    NSMutableArray *resultArray=[[objAppDelegate.managedObjectContext executeFetchRequest:request error:&error]mutableCopy];
    if (error==Nil) {
        _tags=[NSMutableArray arrayWithArray:resultArray];
        
    }
}

- (void)PlayRingToneAndMakeTagBlinkingOn
{
    
}
- (void)PlayRingToneAndMakeTagBlinkingOff
{
    
}
- (void)prepareDataForTag:(int)tagNumberInfo
{
    
}

- (void)getCurrentLocation
{
    
}
- (void) spinWithOptions: (float) options
{
    
}
-(void) stopSpin
{
    
}
-(void)upDateDBWithBatteryLevel
{
    
}

- (void) startSpin
{
    
}
- (void)checkForConnect{
    
}
- (void)updateDBWithLatitudeandLongitude
{
    
}
- (void)loadLocalizeText
{
    
}

- (IBAction)informationButton:(id)sender;
{

    
}
- (IBAction)findTagButton:(id)sender;
{
    
}
- (IBAction)rightButton:(id)sender;
{
    
}
- (IBAction)leftButton:(id)sender;
{
    
}
- (IBAction)alertButton:(id)sender;
{
    
}
@end
