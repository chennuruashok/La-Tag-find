//
//  tagDetailViewController.m
//  tagsTrail
//
//  Created by Prakash on 26/10/13.
//  Copyright (c) 2013 Prakash. All rights reserved.
//

#import "TagDetailViewController.h"
#import "RadarViewController.h"
#import "AppDelegate.h"
#import "Tags.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MapViewController.h"
#import "MusicViewController.h"
@interface TagDetailViewController ()

@end
@implementation TagDetailViewController

@synthesize updateTagData;
@synthesize nameTextField=_nameTextField;
@synthesize deviceNameLabel;
@synthesize batteryStatusLabel;
@synthesize scroller;
@synthesize browse;
@synthesize ringtoneName;
@synthesize alertSwitch;
@synthesize ic_black;
@synthesize ic_laba;
@synthesize ic_account;
@synthesize ic_bag;
@synthesize ic_blue;
@synthesize ic_boy;
@synthesize ic_camera;
@synthesize ic_circle;
@synthesize ic_dark_golden;
@synthesize ic_girl;
@synthesize ic_gray;
@synthesize ic_green;
@synthesize ic_message;
@synthesize ic_music;
@synthesize ic_orange;
@synthesize ic_pet;
@synthesize ic_pink;
@synthesize ic_purple;
@synthesize ic_red;
@synthesize ic_square;
@synthesize ic_star;
@synthesize ic_teal;
@synthesize ic_tri_angel;
@synthesize ic_white;
@synthesize ic_yellow;
@synthesize objSoundViewController;
@synthesize objMapViewController;
@synthesize alertLabel;
@synthesize batteryLabel;
@synthesize nameLabel;
@synthesize ringtoneLabel,lastFoundButton,iconLabel,colorLabel,diconnectButton,diconnectTextLabel;
@synthesize distanceButton;
@synthesize distanceLabel;

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ic_laba.layer.cornerRadius = 4;
    self.nameTextField.layer.borderWidth= 2.0f;
    self.ic_laba.layer.cornerRadius = 4;
    self.nameTextField.layer.cornerRadius=8.0f;
    self.nameTextField.layer.borderColor=[[UIColor grayColor]CGColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self.ringtoneName setText:[Language get:@"Ringtone Name" alter:Nil]];
    [self makeScrollViewCustomize];
    [self makeVariablesInitialize];
    [self roundButtonForBrowse];
    [self tapGesture];
    [self ringtoneSelection];
    [self allImagesUserInteractionEnable];
    selectData=FALSE;
  }
- (void)makeScrollViewCustomize{

    [self.scroller setShowsVerticalScrollIndicator:YES];
    [self.scroller setScrollEnabled:YES];
    self.scroller.delaysContentTouches = NO;
    self.scroller.canCancelContentTouches = NO;
    self.scroller.scrollsToTop=YES;
}
- (void)makeVariablesInitialize{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 480)
        {
            self.objSoundViewController=[[UIStoryboard storyboardWithName:@"Main_4" bundle:Nil]instantiateViewControllerWithIdentifier:@"SoundListViewController"];
            
            self.objMusicViewController=[[UIStoryboard storyboardWithName:@"Main_4" bundle:Nil]instantiateViewControllerWithIdentifier:@"MusicViewController"];
            [self.scroller setContentSize:CGSizeMake(320,950)];

        }
        else{
        self.objSoundViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"SoundListViewController"];
        self.objMusicViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"MusicViewController"];
            
        [self.scroller setContentSize:CGSizeMake(320,950)];
        }
    }
    else{
        self.objSoundViewController=[[UIStoryboard storyboardWithName:@"Main_ipad" bundle:Nil]instantiateViewControllerWithIdentifier:@"SoundListViewController"];
        self.objMusicViewController=[[UIStoryboard storyboardWithName:@"Main_ipad" bundle:Nil]instantiateViewControllerWithIdentifier:@"MusicViewController"];
        [self.scroller setContentSize:CGSizeMake(768,1800)];
    }
    
    self.objMusicViewController.delegate=self;
    objSoundViewController.delegate=self;
    musicplayer=[[MPMusicPlayerController alloc]init];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden=YES;
     [self setLocalizedText];
     [self loadTagDetails];
      self.tabBarController.tabBar.hidden=YES;
   }

- (void)viewDidDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}

- (void)ringtoneSelection{
    // Here  I am getting RingTonePath and RingTone Name. I am dividing string into two  parts by seperator.
    if (updateTagData.isRingTone) {
        self.ringtoneName.text=updateTagData.ringTone;
    }
    else{
    ringtoneData=updateTagData.ringTone;
    NSString *ringtoneDataForSplit=ringtoneData;
    NSArray *ringToneDataArray= [ringtoneDataForSplit componentsSeparatedByString:@"/"];
    NSString *ringtoneExactName=[ringToneDataArray objectAtIndex:ringToneDataArray.count-1];
    NSArray *ringToneExactArray=[ringtoneExactName componentsSeparatedByString:@"."];
    ringtoneSelectedData=[ringToneExactArray objectAtIndex:0];
    self.ringtoneName.text=ringtoneSelectedData;

    }
   }


- (void)tapGesture{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]init] ;
    [self.scroller addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.enabled = YES;
    tapGestureRecognizer.delegate = self;
    [tapGestureRecognizer setCancelsTouchesInView:NO];
 }
- (void)roundButtonForBrowse {
    CALayer *btnLayer = [self.browse layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}
- (void)allImagesUserInteractionEnable {
    self.ic_bag.userInteractionEnabled = YES;
    self.ic_account.userInteractionEnabled =YES;
    self.ic_boy.userInteractionEnabled=YES;
    self.ic_camera.userInteractionEnabled=YES;
    self.ic_girl.userInteractionEnabled=YES;
    self.ic_message.userInteractionEnabled =YES;
    self.ic_music.userInteractionEnabled=YES;
    self.ic_pet.userInteractionEnabled=YES;
    self.ic_square.userInteractionEnabled=YES;
    self.ic_circle.userInteractionEnabled=YES;
    self.ic_tri_angel.userInteractionEnabled=YES;
    self.ic_star.userInteractionEnabled=YES;
    
    self.ic_orange.userInteractionEnabled=YES;
    self.ic_blue.userInteractionEnabled=YES;
    self.ic_black.userInteractionEnabled=YES;
    self.ic_orange.userInteractionEnabled=YES;
    self.ic_green.userInteractionEnabled=YES;
    self.ic_gray.userInteractionEnabled=YES;
    self.ic_white.userInteractionEnabled=YES;
    self.ic_red.userInteractionEnabled=YES;
    self.ic_orange.userInteractionEnabled=YES;
    self.ic_teal.userInteractionEnabled=YES;
    self.ic_purple.userInteractionEnabled=YES;
    self.ic_dark_golden.userInteractionEnabled=YES;
  
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    
    return YES;
}

- (BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // test if our control subview is on-screen
      if ([touch.view isKindOfClass:[UIImageView class]])
      {
        // we touched a button, slider, or other UIContro
         if (touch.view == self.ic_bag) {
            [self deSelectAllImages];
            if (self.ic_bag.tag==50){
                tagname=[NSString stringWithFormat:@"ic_bag"];
                [self.ic_bag setImage:[UIImage imageNamed: @"ic_bag_blue.png"]];
                self.ic_bag.tag=51;
            }else if (self.ic_bag.tag==51){
                tagname=[NSString stringWithFormat:@"ic_bag"];
                [self.ic_bag setImage:[UIImage imageNamed: @"ic_bag.png"]];
                self.ic_bag.tag=50;
            }
            
        }else if (touch.view == self.ic_message){
            [self deSelectAllImages];
            if (self.ic_message.tag==52) {
                tagname=[NSString stringWithFormat:@"ic_message"];
                [self.ic_message setImage:[UIImage imageNamed: @"ic_message_blue.png"]];
                self.ic_message.tag=53;
            }else if (self.ic_message.tag==53){
                tagname=[NSString stringWithFormat:@"ic_message"];
                [self.ic_message setImage:[UIImage imageNamed: @"ic_message.png"]];
                self.ic_message.tag=52;
            }
        }else if (touch.view == self.ic_account){
            [self deSelectAllImages];
            if (self.ic_account.tag==54) {
                tagname=[NSString stringWithFormat:@"ic_account"];
                [self.ic_account setImage:[UIImage imageNamed: @"ic_account_blue.png"]];
                self.ic_account.tag=55;
            }else if (self.ic_account.tag==55){
                tagname=[NSString stringWithFormat:@"ic_account"];
                [self.ic_account setImage:[UIImage imageNamed: @"ic_account.png"]];
                self.ic_account.tag=54;
            }
            
        }else if (touch.view == self.ic_pet){
            [self deSelectAllImages];
            if (self.ic_pet.tag==56) {
                tagname=[NSString stringWithFormat:@"ic_pet"];
                [self.ic_pet setImage:[UIImage imageNamed: @"ic_pet_blue.png"]];
                self.ic_pet.tag=57;
            }else if (self.ic_pet.tag==57){
                tagname=[NSString stringWithFormat:@"ic_pet"];
                [self.ic_pet setImage:[UIImage imageNamed: @"ic_pet.png"]];
                self.ic_pet.tag=56;
            }
        }else if (touch.view == self.ic_camera){
            [self deSelectAllImages];
            if (self.ic_camera.tag==58) {
                tagname=[NSString stringWithFormat:@"ic_camera"];
                [self.ic_camera setImage:[UIImage imageNamed: @"ic_camera_blue.png"]];
                self.ic_camera.tag=59;
            }else if (self.ic_camera.tag==59){
                tagname=[NSString stringWithFormat:@"ic_camera"];
                [self.ic_camera setImage:[UIImage imageNamed: @"ic_camera.png"]];
                self.ic_camera.tag=58;
            }
        }else if (touch.view == self.ic_girl){
            [self deSelectAllImages];
            if (self.ic_girl.tag==60) {
                tagname=[NSString stringWithFormat:@"ic_girl"];
                [self.ic_girl setImage:[UIImage imageNamed: @"ic_girl_blue.png"]];
                self.ic_girl.tag=61;
            }else if (self.ic_girl.tag==61){
                tagname=[NSString stringWithFormat:@"ic_girl"];
                [self.ic_girl setImage:[UIImage imageNamed: @"ic_girl.png"]];
                self.ic_girl.tag=60;
            }
        }else if (touch.view == self.ic_boy){
            [self deSelectAllImages];
            if (self.ic_boy.tag==62) {
                tagname=[NSString stringWithFormat:@"ic_boy"];
                [self.ic_boy setImage:[UIImage imageNamed: @"ic_boy_blue.png"]];
                self.ic_boy.tag=63;
            }else if (self.ic_boy.tag==63){
                tagname=[NSString stringWithFormat:@"ic_boy"];
                [self.ic_boy setImage:[UIImage imageNamed: @"ic_boy.png"]];
                self.ic_boy.tag=62;
            }
        }else if (touch.view == self.ic_music){
            [self deSelectAllImages];
            if (self.ic_music.tag==64) {
                tagname=[NSString stringWithFormat:@"ic_music"];
                [self.ic_music setImage:[UIImage imageNamed: @"ic_music_blue.png"]];
                self.ic_music.tag=65;
            }
            else if (self.ic_music.tag==65){
                tagname=[NSString stringWithFormat:@"ic_music"];
                [self.ic_music setImage:[UIImage imageNamed: @"ic_music.png"]];
                self.ic_music.tag=64;
            }
        }else if (touch.view == self.ic_square){
            [self deSelectAllImages];
            if (self.ic_square.tag==66) {
                tagname=[NSString stringWithFormat:@"ic_square"];
                [self.ic_square setImage:[UIImage imageNamed: @"ic_square_blue.png"]];
                self.ic_square.tag=67;
            }else if (self.ic_square.tag==67){
                tagname=[NSString stringWithFormat:@"ic_square"];
                [self.ic_square setImage:[UIImage imageNamed: @"ic_square.png"]];
                self.ic_square.tag=66;
            }

        
      }else if (touch.view == self.ic_circle){
          [self deSelectAllImages];
          if (self.ic_circle.tag==68) {
              tagname=[NSString stringWithFormat:@"ic_circle"];
              [self.ic_circle setImage:[UIImage imageNamed: @"ic_circle_blue.png"]];
              self.ic_circle.tag=69;
          }
          else if (self.ic_circle.tag==69){
              tagname=[NSString stringWithFormat:@"ic_circle"];
              [self.ic_circle setImage:[UIImage imageNamed: @"ic_circle.png"]];
              self.ic_circle.tag=68;
          }
      }
       else if (touch.view == self.ic_tri_angel){
          [self deSelectAllImages];
          if (self.ic_tri_angel.tag==70) {
              tagname=[NSString stringWithFormat:@"ic_tri_angle"];
              [self.ic_tri_angel setImage:[UIImage imageNamed: @"ic_tri_angle_blue.png"]];
              self.ic_tri_angel.tag=71;
          }
          else if (self.ic_tri_angel.tag==71){
              tagname=[NSString stringWithFormat:@"ic_tri_angle"];
              [self.ic_tri_angel setImage:[UIImage imageNamed: @"ic_tri_angle.png"]];
              self.ic_tri_angel.tag=70;
          }
          }
       else if (touch.view == self.ic_star){
           [self deSelectAllImages];
           if (self.ic_star.tag==72) {
               tagname=[NSString stringWithFormat:@"ic_star"];
               [self.ic_star setImage:[UIImage imageNamed: @"ic_star_blue.png"]];
               self.ic_star.tag=73;
           }
           else if (self.ic_star.tag==73){
               tagname=[NSString stringWithFormat:@"ic_star"];
               [self.ic_star setImage:[UIImage imageNamed: @"ic_star.png"]];
               self.ic_star.tag=72;
           }
       }

          if (touch.view == self.ic_black){
              [self deSelectAllColorImages];
              if (self.ic_black.tag==10) {
                  colorName=[NSString stringWithFormat:@"black"];
                  [self.ic_black setImage:[UIImage imageNamed: @"ic_circle_black_shadow.png"]];
                  self.ic_black.tag=11;
              }
              else if (self.ic_black.tag==11){
                  colorName=[NSString stringWithFormat:@"black"];
                  [self.ic_black setImage:[UIImage imageNamed: @"ic_black.png"]];
                  self.ic_black.tag=10;
                  
                  
              }
          }
          if (touch.view == self.ic_blue){
              [self deSelectAllColorImages];
              if (self.ic_blue.tag==12) {
                  colorName=[NSString stringWithFormat:@"blue"];
                  [self.ic_blue setImage:[UIImage imageNamed: @"ic_circle_blue_shadow.png"]];
                  self.ic_blue.tag=13;
              }
              else if (self.ic_blue.tag==13){
                  colorName=[NSString stringWithFormat:@"blue"];
                  [self.ic_blue setImage:[UIImage imageNamed: @"ic_blue.png"]];
                  self.ic_blue.tag=12;
                  
                  
              }
          }
          
          if (touch.view == self.ic_green){
              [self deSelectAllColorImages];
              if (self.ic_green.tag==14) {
                  colorName=[NSString stringWithFormat:@"green"];
                  [self.ic_green setImage:[UIImage imageNamed: @"ic_circle_green_shadow.png"]];
                  self.ic_green.tag=15;
              }
              else if (self.ic_green.tag==15){
                  colorName=[NSString stringWithFormat:@"green"];
                  [self.ic_green setImage:[UIImage imageNamed: @"ic_green.png"]];
                  self.ic_green.tag=14;
                  
                  
              }
          }
          if (touch.view == self.ic_yellow){
              [self deSelectAllColorImages];
              if (self.ic_yellow.tag==16) {
                  colorName=[NSString stringWithFormat:@"yellow"];
                  [self.ic_yellow setImage:[UIImage imageNamed: @"ic_circle_yellow_shadow.png"]];
                  self.ic_yellow.tag=17;
              }
              else if (self.ic_yellow.tag==17){
                  colorName=[NSString stringWithFormat:@"yellow"];
                  [self.ic_yellow setImage:[UIImage imageNamed: @"ic_yellow.png"]];
                  self.ic_yellow.tag=16;
                  
                  
              }
          }
          if (touch.view == self.ic_orange){
              [self deSelectAllColorImages];
              if (self.ic_orange.tag==18) {
                  colorName=[NSString stringWithFormat:@"orange"];
                  [self.ic_orange setImage:[UIImage imageNamed: @"ic_circle_orange_shadow.png"]];
                  self.ic_orange.tag=19;
              }
              else if (self.ic_orange.tag==19){
                  colorName=[NSString stringWithFormat:@"orange"];
                  [self.ic_orange setImage:[UIImage imageNamed: @"ic_orange.png"]];
                  self.ic_orange.tag=18;
                  
                  
              }
          }
          if (touch.view == self.ic_red){
              [self deSelectAllColorImages];
              if (self.ic_red.tag==20) {
                  colorName=[NSString stringWithFormat:@"red"];
                  [self.ic_red setImage:[UIImage imageNamed: @"ic_circle_red_shadow.png"]];
                  self.ic_red.tag=21;
              }
              else if (self.ic_red.tag==21){
                  colorName=[NSString stringWithFormat:@"red"];
                  [self.ic_red setImage:[UIImage imageNamed: @"ic_red.png"]];
                  self.ic_red.tag=20;
                  
                  
              }
          }
          if (touch.view == self.ic_dark_golden){
              [self deSelectAllColorImages];
              if (self.ic_dark_golden.tag==22) {
                  colorName=[NSString stringWithFormat:@"dark_golden"];
                  [self.ic_dark_golden setImage:[UIImage imageNamed: @"ic_circle_dark_golden_shadow.png"]];
                  self.ic_dark_golden.tag=23;
              }
              else if (self.ic_dark_golden.tag==23){
                  colorName=[NSString stringWithFormat:@"dark_golden"];
                  [self.ic_dark_golden setImage:[UIImage imageNamed: @"ic_dark_golden.png"]];
                  self.ic_dark_golden.tag=22;
                  
                  
              }
          }
          if (touch.view == self.ic_gray){
              [self deSelectAllColorImages];
              if (self.ic_gray.tag==24) {
                  colorName=[NSString stringWithFormat:@"gray"];
                  [self.ic_gray setImage:[UIImage imageNamed: @"ic_circle_gray_shadow.png"]];
                  self.ic_gray.tag=25;
              }
              else if (self.ic_gray.tag==25){
                  colorName=[NSString stringWithFormat:@"gray"];
                  [self.ic_gray setImage:[UIImage imageNamed: @"ic_gray.png"]];
                  self.ic_gray.tag=24;
                  
              }
          }
          
          if (touch.view == self.ic_teal){
              [self deSelectAllColorImages];
              if (self.ic_teal.tag==26) {
                  colorName=[NSString stringWithFormat:@"teal"];
                  [self.ic_teal setImage:[UIImage imageNamed: @"ic_circle_teal_shadow.png"]];
                  self.ic_teal.tag=27;
              }
              else if (self.ic_teal.tag==27){
                  colorName=[NSString stringWithFormat:@"teal"];
                  [self.ic_teal setImage:[UIImage imageNamed: @"ic_teal.png"]];
                  self.ic_teal.tag=26;
             
              }
          }
          
          if (touch.view == self.ic_white){
              [self deSelectAllColorImages];
              if (self.ic_white.tag==28) {
                  colorName=[NSString stringWithFormat:@"white"];
                  [self.ic_white setImage:[UIImage imageNamed: @"ic_circle_white_shadow.png"]];
                  self.ic_white.tag=29;
              }
              else if (self.ic_white.tag==29){
                  colorName=[NSString stringWithFormat:@"white"];
                  [self.ic_white setImage:[UIImage imageNamed: @"ic_white.png"]];
                  self.ic_white.tag=28;
                  
                  
              }
          }
          if (touch.view == self.ic_pink){
              [self deSelectAllColorImages];
              if (self.ic_pink.tag==30) {
                  colorName=[NSString stringWithFormat:@"pink"];
                  [self.ic_pink setImage:[UIImage imageNamed: @"ic_circle_pink_shadow.png"]];
                  self.ic_pink.tag=31;
              }
              else if (self.ic_pink.tag==31){
                  colorName=[NSString stringWithFormat:@"pink"];
                  [self.ic_pink setImage:[UIImage imageNamed: @"ic_pink.png"]];
                  self.ic_pink.tag=30;
                  
                  
              }
          }
          
          if (touch.view == self.ic_purple){
              [self deSelectAllColorImages];
              if (self.ic_purple.tag==32) {
                  colorName=[NSString stringWithFormat:@"purple"];
                  [self.ic_purple setImage:[UIImage imageNamed: @"ic_circle_purple_shadow.png"]];
                  self.ic_purple.tag=33;
              }
              else if (self.ic_purple.tag==33){
                  colorName=[NSString stringWithFormat:@"purple"];
                  [self.ic_purple setImage:[UIImage imageNamed: @"ic_purple.png"]];
                  self.ic_purple.tag=32;
             
              }
          }
        
        return YES;
    
    }
    return NO;

}
-(void)deSelectAllColorImages{
    [self.ic_black setImage:[UIImage imageNamed:@"ic_black.png"]];
    [self.ic_blue setImage:[UIImage imageNamed:@"ic_blue.png"]];
    [self.ic_green setImage:[UIImage imageNamed:@"ic_green.png"]];
    [self.ic_yellow setImage:[UIImage imageNamed:@"ic_yellow.png"]];
    [self.ic_orange setImage:[UIImage imageNamed:@"ic_orange.png"]];
    [self.ic_red setImage:[UIImage imageNamed:@"ic_red.png"]];
    [self.ic_dark_golden setImage:[UIImage imageNamed:@"ic_dark_golden.png"]];
    [self.ic_gray setImage:[UIImage imageNamed:@"ic_gray.png"]];
    [self.ic_teal setImage:[UIImage imageNamed:@"ic_teal.png"]];
    [self.ic_white setImage:[UIImage imageNamed:@"ic_white.png"]];
    [self.ic_pink setImage:[UIImage imageNamed:@"ic_pink.png"]];
    [self.ic_purple setImage:[UIImage imageNamed:@"ic_purple.png"]];
}
-(void) deSelectAllImages{
    [self.ic_bag setImage:[UIImage imageNamed: @"ic_bag.png"]];
    [self.ic_message setImage:[UIImage imageNamed: @"ic_message.png"]];
    [self.ic_account setImage:[UIImage imageNamed: @"ic_account.png"]];
    [self.ic_pet setImage:[UIImage imageNamed: @"ic_pet.png"]];
    [self.ic_camera setImage:[UIImage imageNamed: @"ic_camera.png"]];
    [self.ic_girl setImage:[UIImage imageNamed: @"ic_girl.png"]];
    [self.ic_boy setImage:[UIImage imageNamed: @"ic_boy.png"]];
    [self.ic_music setImage:[UIImage imageNamed: @"ic_music.png"]];
    [self.ic_tri_angel setImage:[UIImage imageNamed:@"ic_tri_angle.png"]];
    [self.ic_square setImage:[UIImage imageNamed:@"ic_square.png"]];
    [self.ic_circle setImage:[UIImage imageNamed:@"ic_circle.png"]];
    [self.ic_star setImage:[UIImage imageNamed:@"ic_star.png"]];
   
}

- (IBAction)backButtonClicked:(id)sender {
    selectData=FALSE;
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.layer.borderColor=[[UIColor grayColor]CGColor];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text length] > 15) {
        textField.text = [textField.text substringToIndex:15-1];
        return NO;
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor greenColor]CGColor];
    textField.layer.borderWidth= 2.0f;
    // activeField = textField;
    [self.scroller setContentOffset:CGPointMake(0,textField.center.y-60) animated:YES];
}
- (void)loadTagDetails {
    if (!selectData) {
        self.deviceNameLabel.text=self.updateTagData.deviceName;
        colorName=self.updateTagData.colorName;
        tagname=self.updateTagData.imageData;
        if (self.updateTagData.isLongDistance) {
            [self.distanceButton setImage:[UIImage imageNamed:@"ic_long.png"] forState:UIControlStateNormal];
            [self.distanceButton setSelected:NO];
        }
        else{
            [self.distanceButton setImage:[UIImage imageNamed:@"ic_short.png"] forState:UIControlStateNormal];
            [self.distanceButton setSelected:YES];
        }
        
        [self.alertSwitch setOn:self.updateTagData.alert];
        alerData=self.updateTagData.alert;
        if (self.ringtoneName.text==Nil) {
            self.ringtoneName.text=ringtoneSelectedData;
        }
        
        self.nameTextField.text=self.updateTagData.deviceName;
        float bateryLeft=[self.updateTagData.batterypercentage floatValue];
        if (self.updateTagData.batterypercentage!=Nil) {
            self.batteryStatusLabel.text=[NSString stringWithFormat:@"%.f %%",round(bateryLeft)];
        }
        if ([tagname isEqual:@"ic_bag"]) {
            // [NSString stringWithFormat:@"%@_%@.png",tagname,colorName];
            [self.ic_bag setImage:[UIImage imageNamed:@"ic_bag_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_pet"]) {
            [self.ic_pet setImage:[UIImage imageNamed:@"ic_pet_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_camera"]) {
            [self.ic_camera setImage:[UIImage imageNamed:@"ic_camera_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_boy"]) {
            [self.ic_boy setImage:[UIImage imageNamed:@"ic_boy_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_music"]) {
            [self.ic_music setImage:[UIImage imageNamed:@"ic_music_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_account"]) {
            [self.ic_account setImage:[UIImage imageNamed:@"ic_account_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_girl"]) {
            [self.ic_girl setImage:[UIImage imageNamed:@"ic_girl_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_message"]) {
            [self.ic_message setImage:[UIImage imageNamed:@"ic_message_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_square"]) {
            [self.ic_square setImage:[UIImage imageNamed:@"ic_square_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_circle"]) {
            [self.ic_circle setImage:[UIImage imageNamed:@"ic_circle_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_star"]) {
            [self.ic_star setImage:[UIImage imageNamed:@"ic_star_blue.png"]];
        }
        else if ([tagname isEqual:@"ic_tri_angle"]) {
            [self.ic_tri_angel setImage:[UIImage imageNamed:@"ic_tri_angle_blue.png"]];
        }
        
        if ([colorName isEqual:@"black"]) {
            // [NSString stringWithFormat:@"%@_%@.png",tagname,colorName];
            [self.ic_black setImage:[UIImage imageNamed:@"ic_circle_black_shadow.png"]];
        }
        else if ([colorName isEqual:@"blue"]) {
            [self.ic_blue setImage:[UIImage imageNamed:@"ic_circle_blue_shadow.png"]];
        }
        else if ([colorName isEqual:@"green"]) {
            [self.ic_green setImage:[UIImage imageNamed:@"ic_circle_green_shadow.png"]];
        }
        else if ([colorName isEqual:@"yellow"]) {
            [self.ic_yellow setImage:[UIImage imageNamed:@"ic_circle_yellow_shadow.png"]];
        }
        else if ([colorName isEqual:@"orange"]) {
            [self.ic_orange setImage:[UIImage imageNamed:@"ic_circle_orange_shadow.png"]];
        }
        else if ([colorName isEqual:@"red"]) {
            [self.ic_red setImage:[UIImage imageNamed:@"ic_circle_red_shadow.png"]];
        }
        else if ([colorName isEqual:@"dark_golden"]) {
            [self.ic_dark_golden setImage:[UIImage imageNamed:@"ic_circle_dark_golden_shadow.png"]];
        }
        else if ([colorName isEqual:@"gray"]) {
            [self.ic_gray setImage:[UIImage imageNamed:@"ic_circle_gray_shadow.png"]];
        }
        else if ([colorName isEqual:@"teal"]) {
            [self.ic_teal setImage:[UIImage imageNamed:@"ic_circle_teal_shadow.png"]];
        }
        else if ([colorName isEqual:@"white"]) {
            [self.ic_white setImage:[UIImage imageNamed:@"ic_circle_white_shadow.png"]];
        }
        else if ([colorName isEqual:@"pink"]) {
            [self.ic_pink setImage:[UIImage imageNamed:@"ic_circle_pink_shadow.png"]];
        }
        else if ([colorName isEqual:@"purple"]) {
            [self.ic_purple setImage:[UIImage imageNamed:@"ic_circle_purple_shadow.png"]];
        }

    }
    selectData=TRUE;
    
  }


- (IBAction)browseClicked:(id)sender {
     UIActionSheet *ringToneGetaActionSheet=[[UIActionSheet alloc]initWithTitle:[Language get:@"Choose one" alter:Nil]  delegate:self cancelButtonTitle:[Language get:@"Cancel" alter:Nil] destructiveButtonTitle:Nil otherButtonTitles:[Language get:@"Phone" alter:Nil],[Language get:@"SD CARD" alter:Nil],nil];
      [ringToneGetaActionSheet showInView:self.view];
    }

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            self.updateTagData.isRingTone=FALSE;
             objSoundViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:objSoundViewController animated:YES];
            break;
            
        case 1:
        {
            self.updateTagData.isRingTone=TRUE;
            self.objMusicViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:self.objMusicViewController animated:YES];
            break;
        }
            
        default:
            break;
    }
 }
-(void)addMusicItemViewController:(MusicViewController *)controller didFinishEnteringItem1:(NSString *)item{
    self.ringtoneName.text=item;
}
- (IBAction)okClicked:(id)sender {
    
    AppDelegate *objAppDeleagate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.updateTagData.deviceName=self.nameTextField.text;
    self.updateTagData.alert=alerData;
    self.updateTagData.colorName=colorName;
    self.updateTagData.imageData=tagname;
    NSError *error;
    if([objAppDeleagate.managedObjectContext save:&error]){
       self.nameTextField.text=nil;
       [self deSelectAllImages];
        self.tabBarController.selectedIndex=1;
        selectData=FALSE;
        [self performSelector:@selector(goBacktoView) withObject:self afterDelay:0.5];
 }
}
- (void)goBacktoView{
 [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)addItemViewController:(SoundListViewController *)controller didFinishEnteringItem:(NSString *)item
{
    self.updateTagData.ringTone=item;
    ringtoneData=item;
    NSString *ringtoneDataForSplit=ringtoneData;
    NSArray *ringTonesplittedArray=[ringtoneDataForSplit componentsSeparatedByString:@"/"];
    NSString *ringtoneExactName=[ringTonesplittedArray objectAtIndex:ringTonesplittedArray.count-1];
    NSArray *ringToneExactArray=[ringtoneExactName componentsSeparatedByString:@"."];
    self.ringtoneName.text=[ringToneExactArray objectAtIndex:0];
  }

- (IBAction)alertSwichUsed:(id)sender {
    
    if ([self.alertSwitch isOn]) {
        alerData=YES;
    }
    else{
        alerData=NO;
    
    }
}

- (IBAction)disConnectButton:(id)sender {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"connected"]) {
    UIAlertView *disconnectAlert=[[UIAlertView alloc]initWithTitle:@"Do You Want to disconnect this Tag from Your Tags" message:Nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO", nil];
    [disconnectAlert show];
    }
}        // [ALToastView toastInView:self.view withText:[Language get:@"Please remove the Tag Connection" alter:Nil]];
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    switch (buttonIndex) {
        case 0:
            if (alertView.tag!=111) {
                [self disconnectTag];
            }
            break;
        default:
            break;
    }

}
- (void)disconnectTag{
    AppDelegate *objAppDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [objAppDelegate.managedObjectContext deleteObject:self.updateTagData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection

{
    MPMediaItem *songName=[mediaItemCollection.items objectAtIndex:0];
    
    self.ringtoneName.text=[songName valueForKey:MPMediaItemPropertyTitle];
    //Here I am filling RingTone Data of Database with mediaItem Property Title
    self.updateTagData.ringTone=[songName valueForKey:MPMediaItemPropertyTitle];
    NSURL *url = [songName valueForProperty:MPMediaItemPropertyAssetURL];
    ringtoneData=[url absoluteString];
    ringtoneData=[NSString stringWithFormat:@"%@_%@",ringtoneData,self.ringtoneName.text];
    [musicplayer setQueueWithItemCollection: mediaItemCollection];
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (IBAction)lastFoundClick:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 480)
        {
            objMapViewController=[[UIStoryboard storyboardWithName:@"Main_4" bundle:Nil]instantiateViewControllerWithIdentifier:@"MapViewController"];
        }
        else{
         objMapViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"MapViewController"];
        }
        
    }
    else{
       objMapViewController=[[UIStoryboard storyboardWithName:@"Main_ipad" bundle:Nil]instantiateViewControllerWithIdentifier:@"MapViewController"];
    }
    objMapViewController.latitudeNumber=updateTagData.latitude;
    objMapViewController.longitudeNumber=updateTagData.longitude;
    objMapViewController.lastFoundTime=updateTagData.lastFoundDate;
    if (updateTagData.lastFoundDate==Nil) {
        UIAlertView *lastFoundAlert=[[UIAlertView alloc]initWithTitle:@"Last Found Location" message:@"Last Found Location not stored" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
        lastFoundAlert.tag=111;
        [lastFoundAlert show];
    }
    else{
        Reachability *kCFHostReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [kCFHostReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            UIAlertView *internetAlert=[[UIAlertView alloc]initWithTitle:@"Internet Connection" message:@"Check the Internet Connection" delegate:self cancelButtonTitle:Nil otherButtonTitles:[Language get:@"OK" alter:Nil], nil];
            [internetAlert show];
        }else
        {
       objMapViewController.hidesBottomBarWhenPushed=YES;
       [self.navigationController pushViewController:objMapViewController animated:YES];
        }
    }
}

- (IBAction)distanceButtonClicked:(id)sender {
    
    if ([sender isSelected]) {
        [self.distanceButton setImage:[UIImage imageNamed:@"ic_long.png"] forState:UIControlStateNormal];
        self.updateTagData.isLongDistance=YES;
        [sender setSelected:NO];

           }
    else{
        
        [self.distanceButton setImage:[UIImage imageNamed:@"ic_short.png"] forState:UIControlStateNormal];
        self.updateTagData.isLongDistance=NO;
        [sender setSelected:YES];
    }
 }

- (void)setLocalizedText{
    [self.distanceLabel setText:[Language get:@"Distance" alter:Nil]];
    [self.deviceNameLabel setText:[Language get:@"Device Name" alter:Nil]];
    [self.alertLabel setText:[Language get:@"Alert" alter:Nil]];
    [self.batteryLabel setText:[Language get:@"Battery" alter:Nil]];
    [self.nameLabel setText:[Language get:@"Name" alter:Nil]];
    [self.ringtoneLabel setText:[Language get:@"Ringtone" alter:Nil]];
    [self.lastFoundButton setTitle:[Language get:@"Last Found location" alter:Nil] forState:UIControlStateNormal];
    [self.iconLabel setText:[Language get:@"Icon" alter:Nil]];
    [self.colorLabel setText:[Language get:@"color" alter:Nil]];
    [self.diconnectButton setTitle:[Language get:@"Disconnected"  alter:Nil] forState:UIControlStateNormal];
    [self.diconnectTextLabel setText:[Language get:@"Once You have disconnected tag.You will have to pairing for next used." alter:Nil]];
    [self.browse setTitle:[Language get:@"Browse" alter:Nil] forState:UIControlStateNormal];
}
@end
