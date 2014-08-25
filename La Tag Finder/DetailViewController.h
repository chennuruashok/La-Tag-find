//
//  DetailViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "SoundListViewController.h"
#import "MusicViewController.h"
#import "MapViewController.h"
#import "SOSViewController.h"
@class SOSViewController;

@interface DetailViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate,SoundListViewControllerDelegate,MusicViewControllerDelegate,UIActionSheetDelegate>
{
    SoundListViewController *objSoundViewController;
    MusicViewController *objMusicViewController;
    UITextField *_titleField;
    UIImageView *ic_key_dark;
    UIImageView *ic_key;
    UIImageView *ic_child_dark;
    UIImageView *ic_child;
    UIImageView *ic_bag_dark;
    UIImageView *ic_bag;
    UIImageView *ic_old_people_dark;
    UIImageView *ic_old_people;
    UIImageView *ic_question_mark_dark;
    UIImageView *ic_question_mark;
    UIImageView *ic_pet_dark;
    UIImageView *ic_pet;
    
    BOOL isSDCard;
    BOOL isDistanceLong;
    NSString *tagname;
    NSString *ringtoneData;
}
@property (nonatomic, retain) NSString * address;
@property (strong, nonatomic) IBOutlet UIImageView *sosIcon;
@property (strong, nonatomic) IBOutlet UIImageView *petIcon;
@property (strong, nonatomic) IBOutlet UIImageView *boy;
@property (strong, nonatomic) IBOutlet UIImageView *questionMark;
@property (strong, nonatomic) IBOutlet UIImageView *ringtoneIcon;
@property (strong, nonatomic) IBOutlet UIImageView *selectIcon;
@property (strong, nonatomic) IBOutlet UIImageView *distanceIcon;
@property (strong, nonatomic) IBOutlet UIImageView *tagNameIcon;
@property (strong, nonatomic) IBOutlet UITextField *tagTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UIImageView *old;
@property (strong, nonatomic) IBOutlet UIImageView *keyIcon;
@property (strong, nonatomic) IBOutlet UIImageView *bagIcon;
@property (strong, nonatomic) IBOutlet UILabel *ringtoneName;
@property (strong, nonatomic) IBOutlet UIButton *browseButton;
@property (strong, nonatomic) IBOutlet UIButton *distanceButton;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *ringtoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *sosButton;
@property (retain) MapViewController *mvc;
@property (strong, nonatomic) SOSViewController *sosvc;

- (IBAction)browseButtonClicked:(id)sender;
- (IBAction)distanceButtonClicked:(id)sender;
- (IBAction)lastFoundButtonClicked:(id)sender;
- (IBAction)sosButtonClicked:(id)sender;
- (IBAction)okButtonClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;

-(void)customBrowseButton;
-(void)makeTapGesture;
-(void)setImagesInteractionEnable;
-(void)scrollViewPrepare;
-(void) deSelectAllImages;
-(void) clickEventOnImage:(id)sender;
-(void)goBacktoView;

@end
