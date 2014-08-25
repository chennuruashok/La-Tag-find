//
//  RadarViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "RadarViewController.h"

@interface RadarViewController : UIViewController<UIAlertViewDelegate, CBPeripheralDelegate, CBCentralManagerDelegate, UITextFieldDelegate,AVAudioPlayerDelegate,CLLocationManagerDelegate,SKPSMTPMessageDelegate,NSURLConnectionDelegate>
{
    int tagCount;
    double deviceLatitude;
    double deviceLongitude;
    BOOL isSDCardTypeRingTone;
    BOOL isManuallyDisconnecting;
    BOOL isDBUpdatedWithBatteryLevel;
    float batteryPercentage;
    NSMutableArray *discoverdPeripherals;
    NSMutableArray *peripheralsListWithInfo;
    BOOL PeripheralMatche;
    BOOL isScanning;
    BOOL isDBUpdatedWithLocation;
    BOOL isValueWriteToTAg;
    BOOL isLongDistance;
    NSTimer *findTagTimer;
    BOOL isTagAvialable;
    int tagNumber;
    NSString *tagNameForALert;
    NSString *sosMailId;
    NSString *sosMessage;
    BOOL sosAlert;
    BOOL alertBool;
    BOOL mailSendingBool;
    BOOL phoneAlertValidation;
    // BOOL *loadTagEnable;
}

@property (nonatomic,retain)SKPSMTPMessage *SKSMPTPmessage;
@property(nonatomic,retain)NSTimer *findTagTimer;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic,assign) float batteryPercentage;
@property (retain) NSMutableArray *tags;
@property(nonatomic,retain)NSString *connected;
@property(nonatomic,retain)MPMediaQuery *mediaQuery;
@property(nonatomic,retain) CBPeripheral *currentPeripheral;
@property(nonatomic,retain) CBCentralManager *CBManager;
@property (nonatomic, strong) AVAudioPlayer *theAudio;
@property (nonatomic, strong) NSURL* musicFile;
@property(nonatomic) BOOL alertDetail;
@property(nonatomic,retain) NSMutableArray *songsListinSDCard;
@property(nonatomic,retain) AVPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UIImageView *LabaIcon;
@property (strong, nonatomic) IBOutlet UILabel *LatagLabel;
@property (strong, nonatomic) IBOutlet UIButton *informationButton;
@property (strong, nonatomic) IBOutlet UIImageView *radarViewImage;
@property (strong, nonatomic) IBOutlet UIImageView *searchingImage;
@property (strong, nonatomic) IBOutlet UIImageView *radarTag;
@property (strong, nonatomic) IBOutlet UIButton *findTagButton;
@property (strong, nonatomic) IBOutlet UILabel *deviceLabel;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UILabel *signalStrength;
@property (strong, nonatomic) IBOutlet UIButton *alertButton;



- (void)sendMessageInBack;
- (void)PlayRingToneAndMakeTagBlinkingOn;
- (void)PlayRingToneAndMakeTagBlinkingOff;
- (BOOL)peripheralFindingForAvailable;
- (void)setValueToBoolVariables;
- (void)memoryInitialize;
- (void)makeSwipeEffect;
- (void)tappedRightButton:(id)sender;
- (void)tappedLeftButton:(id)sender;
- (void)setCentralManager;
- (void)loadLocationFinder;
- (void)writeDataForLinkLoss;
- (void)writeDataForAlarmOn;
- (void)writeDataForAlarmOff;
- (void)performUpdateRSSI:(NSArray *)args;
- (void)calucalteBatteryLevel:(NSData *)batterydata;
- (void)loadTag ;
- (void)prepareDataForTag:(int)tagNumberInfo;
- (void)prepareDBForTagInfo;
- (void) spinWithOptions: (float) options;
- (void) startSpin;
- (void) stopSpin;
- (void)checkForConnect;
- (void)upDateDBWithBatteryLevel;
- (void)updateDBWithLatitudeandLongitude;
- (void)loadLocalizeText;
- (CBPeripheral *)peripheralTest;
- (void)getCurrentLocation;
- (IBAction)informationButton:(id)sender;
- (IBAction)findTagButton:(id)sender;
- (IBAction)rightButton:(id)sender;
- (IBAction)leftButton:(id)sender;
- (IBAction)alertButton:(id)sender;


@end
