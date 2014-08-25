//
//  SettingsViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController : UIViewController<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *LabaIcon;
@property (strong, nonatomic) IBOutlet UILabel *LatagLabel;
@property (strong, nonatomic) IBOutlet UIImageView *forceClose;
@property (strong, nonatomic) IBOutlet UIImageView *aboutLaba;
@property (strong, nonatomic) IBOutlet UIImageView *descriptionImage;
@property (strong, nonatomic) IBOutlet UIImageView *languageImage;
@property (strong, nonatomic) IBOutlet UIButton *forceCloseButton;
@property (strong, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) IBOutlet UIButton *descriptionButton;
@property (strong, nonatomic) IBOutlet UIButton *languageButton;

- (IBAction)forceCloseAppButton:(id)sender;
- (IBAction)aboutLabaButton:(id)sender;
- (IBAction)descriptionButton:(id)sender;
- (IBAction)languageButton:(id)sender;

@end
