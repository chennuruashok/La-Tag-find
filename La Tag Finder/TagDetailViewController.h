//
//  TagDetailViewController.h
//  LaTagV1.0
//
//  Created by vedaslabs on 24/11/13.
//  Copyright (c) 2013 Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tags.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "SoundListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MapViewController.h"
#import "Language.h"
#import "Reachability.h"
#import "MusicViewController.h"
@interface TagDetailViewController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate,MPMediaPickerControllerDelegate,UIScrollViewDelegate,SoundListViewControllerDelegate,MusicViewControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

{
    Tags *updateTagData;
    NSString *tagname;
    NSString *colorName;
    UITextField *nameTextField;
   // UITextField *distanceTextField;
    MPMusicPlayerController *musicplayer;
    NSString *ringtoneData;
    NSString *ringtoneSelectedData;
    BOOL alerData;
    BOOL selectData;
   }
@property(nonatomic,retain)Tags *updateTagData;
@property (strong, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *batteryStatusLabel;
@property (strong, nonatomic) IBOutlet UISwitch *alertSwitch;
@property (strong, nonatomic) IBOutlet UIButton *browse;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *ic_bag;
@property (strong, nonatomic) IBOutlet UIImageView *ic_pet;
@property (strong, nonatomic) IBOutlet UIImageView *ic_camera;
@property (strong, nonatomic) IBOutlet UIImageView *ic_boy;
@property (strong, nonatomic) IBOutlet UIImageView *ic_music;
@property (strong, nonatomic) IBOutlet UIImageView *ic_account;
@property (strong, nonatomic) IBOutlet UIImageView *ic_girl;
@property (strong, nonatomic) IBOutlet UIImageView *ic_message;
@property (strong, nonatomic) IBOutlet UIImageView *ic_square;
@property (strong, nonatomic) IBOutlet UIImageView *ic_circle;
@property (strong, nonatomic) IBOutlet UIImageView *ic_tri_angel;
@property (strong, nonatomic) IBOutlet UIImageView *ic_star;
@property (strong, nonatomic) IBOutlet UIImageView *ic_black;
@property (strong, nonatomic) IBOutlet UIImageView *ic_blue;
@property (strong, nonatomic) IBOutlet UIImageView *ic_green;
@property (strong, nonatomic) IBOutlet UIImageView *ic_yellow;
@property (strong, nonatomic) IBOutlet UIImageView *ic_orange;
@property (strong, nonatomic) IBOutlet UIImageView *ic_red;
@property (strong, nonatomic) IBOutlet UIImageView *ic_dark_golden;
@property (strong, nonatomic) IBOutlet UIImageView *ic_gray;
@property (strong, nonatomic) IBOutlet UIImageView *ic_teal;
@property (strong, nonatomic) IBOutlet UIImageView *ic_white;
@property (strong, nonatomic) IBOutlet UILabel *ringtoneName;
@property (strong, nonatomic) IBOutlet UIImageView *ic_pink;
@property (strong, nonatomic) IBOutlet UIImageView *ic_laba;
@property (strong, nonatomic) IBOutlet UIImageView *ic_purple;
@property (strong,nonatomic) SoundListViewController *objSoundViewController;
@property (strong,nonatomic) MusicViewController *objMusicViewController;
@property(strong,nonatomic) MapViewController *objMapViewController;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *lastFoundButton;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *ringtoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *diconnectButton;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;
@property (weak, nonatomic) IBOutlet UILabel *diconnectTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (IBAction)browseClicked:(id)sender;
- (IBAction)okClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)alertSwichUsed:(id)sender;
- (IBAction)disConnectButton:(id)sender;
- (IBAction)lastFoundClick:(id)sender;
- (IBAction)distanceButtonClicked:(id)sender;

- (void)makeScrollViewCustomize;
- (void)makeVariablesInitialize;
- (void)ringtoneSelection;
- (void)tapGesture ;
- (void)roundButtonForBrowse;
- (void)allImagesUserInteractionEnable;
- (void)deSelectAllColorImages;
- (void) deSelectAllImages;
- (void)loadTagDetails ;
- (void)goBacktoView;
- (void)disconnectTag;
- (void)setLocalizedText;

@end