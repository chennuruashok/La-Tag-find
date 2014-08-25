//
//  SOSViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tags.h"
#import "Language.h"
#import "AppDelegate.h"
#import "SOSViewController.h"
#import "DetailViewController.h"
#import "ALToastView.h"
#import <QuartzCore/QuartzCore.h>

@interface SOSViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    BOOL sosSwitchvalue;
    NSString *sosEmailCheck;
    int maxLength;
}
@property (strong, nonatomic) IBOutlet UIImageView *labaIcon;
@property (strong, nonatomic) IBOutlet UILabel *latagFinderLabel;
@property (strong, nonatomic) IBOutlet UILabel *sosLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIButton *sosButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextFeild;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextView *messageBox;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;

- (IBAction)backButton:(id)sender;
- (IBAction)okButton:(id)sender;
- (IBAction)sosButton:(id)sender;

@end