//
//  SettingsViewController.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "SettingsViewController.h"
#import "Language.h"

@interface SettingsViewController()

@end
static NSBundle *bundle=Nil;
@implementation SettingsViewController
@synthesize LabaIcon;
@synthesize LatagLabel;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setLocalizedText];
}
- (void)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex - 1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)forceCloseAppButton:(id)sender
{
    
}

- (IBAction)aboutLabaButton:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.8locations.com.tw/about.php"]];
}

- (IBAction)descriptionButton:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.8locations.com.tw"]];
}

- (IBAction)languageButton:(id)sender
{
    UIActionSheet *languageActionSheet=[[UIActionSheet alloc]initWithTitle:[Language get:@"Choose Language" alter:Nil] delegate:self cancelButtonTitle:[Language get:@"Cancel" alter:Nil] destructiveButtonTitle:Nil otherButtonTitles:[Language get:@"Chinese" alter:Nil],@"English", nil];
    languageActionSheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    [languageActionSheet showInView:self.view];
}
- (void)setLocalizedText{
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:[Language get:@"PAIRING" alter:Nil]];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:[Language get:@"RADAR" alter:Nil]];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:[Language get:@"MY TAGS" alter:Nil]];
    [[self.tabBarController.tabBar.items objectAtIndex:3] setTitle:[Language get:@"S.O.S" alter:Nil]];
    //[[self.tabBarController.tabBar.items objectAtIndex:4] setTitle:[Language get:@"SETTINGS" alter:Nil]];
    [self.tabBarItem setTitle:[Language get:@"SETTINGS" alter:Nil]];
    [self.languageButton setTitle:[Language get:@"Language" alter:Nil] forState:UIControlStateNormal];
    [self.aboutButton setTitle:[Language get:@"About LBA" alter:Nil] forState:UIControlStateNormal];
    [self.descriptionButton setTitle:[Language get:@"Description" alter:Nil] forState:UIControlStateNormal];
    [self.forceCloseButton setTitle:[Language get:@"Force close App" alter:Nil] forState:UIControlStateNormal];
    
}
@end
