//
//  DetailViewController.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "DetailViewController.h"
#import "Tags.h"
#import "AppDelegate.h"
#import "RadarViewController.h"
#import "Language.h"
#import "ALToastView.h"

@interface DetailViewController()

@end
@implementation DetailViewController

@synthesize address;
@synthesize sosIcon;
@synthesize petIcon;
@synthesize boy;
@synthesize questionMark;
@synthesize ringtoneIcon;
@synthesize selectIcon;
@synthesize distanceIcon;
@synthesize tagNameIcon;
@synthesize tagTitle;
@synthesize scroller;
@synthesize old;
@synthesize keyIcon;
@synthesize bagIcon;
@synthesize ringtoneName;
@synthesize browseButton;
@synthesize distanceButton;
@synthesize mvc;
@synthesize sosvc;

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    isDistanceLong=YES;
    self.navigationController.navigationBarHidden=YES;
    [self.ringtoneName setText:[Language get:@"Ringtone Name" alter:Nil]];
    [self setImagesInteractionEnable];
    [self scrollViewPrepare];
    [self makeTapGesture];
}

- (void)customBrowseButton{
    CALayer *btnLayer = [self.browseButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

- (void)makeTapGesture{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEventOnImage:)];
    [self.scroller addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.enabled = YES;
    tapGestureRecognizer.delegate = self;
    [tapGestureRecognizer setCancelsTouchesInView:NO];
}

- (void)setImagesInteractionEnable
{
    ic_bag.userInteractionEnabled = YES;
    ic_child.userInteractionEnabled = YES;
    ic_pet.userInteractionEnabled =YES;
    ic_key.userInteractionEnabled=YES;
    ic_old_people.userInteractionEnabled=YES;
    ic_question_mark.userInteractionEnabled=YES;
}

- (void)scrollViewPrepare
{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 568)
        {
            objSoundViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"SoundListViewController"];
            
            objMusicViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"MusicViewController"];

            [self.scroller setContentSize:CGSizeMake(320, 950)];
        }
        
    
    objMusicViewController.delegate=self;
    objSoundViewController.delegate=self;
    
    [self.scroller setShowsVerticalScrollIndicator:YES];
    [self.scroller setScrollEnabled:YES];
    self.scroller.delaysContentTouches = NO;
    [self.scroller setCanCancelContentTouches:NO];
    self.scroller.delegate=self;
    self.scroller.scrollsToTop=NO;
    self.scroller.canCancelContentTouches = NO;
    }
}
-(BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}

- (BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIImageView class]])
    {
        // we touched a button, slider, or other UIControl
        if (touch.view == self.old)
        {
            [self deSelectAllImages];
            if (self.old.tag==50)
            {
                tagname=[NSString stringWithFormat:@"ic_old"];
                [self.old setImage:[UIImage imageNamed: @"ic_old_people_dark.png"]];
                self.old.tag=51;
            }
            else if (self.old.tag==51)
            {
                tagname=[NSString stringWithFormat:@"ic_old"];
                [self.old setImage:[UIImage imageNamed: @"ic_old_people.png"]];
                self.old.tag=50;
            }
            
        }
        else if (touch.view == self.questionMark)
        {
            [self deSelectAllImages];
            if (self.questionMark.tag==52)
            {
                tagname=[NSString stringWithFormat:@"ic_question_mark"];
                [self.questionMark setImage:[UIImage imageNamed: @"ic_question_mark_dark.png"]];
                self.questionMark.tag=53;
            }
            else if (self.questionMark.tag==53)
            {
                tagname=[NSString stringWithFormat:@"ic_question_mark"];
                [self.questionMark setImage:[UIImage imageNamed: @"ic_question_mark.png"]];
                self.questionMark.tag=52;
            }
        }
        else if (touch.view == self.boy)
        {
            [self deSelectAllImages];
            if (self.boy.tag==54)
            {
                tagname=[NSString stringWithFormat:@"ic_child"];
                [self.boy setImage:[UIImage imageNamed: @"ic_child_dark.png"]];
                self.boy.tag=55;
            }
            else if (self.boy.tag==55)
            {
                tagname=[NSString stringWithFormat:@"ic_child"];
                [self.boy setImage:[UIImage imageNamed: @"ic_child_dark.png"]];
                self.boy.tag=54;
            }
            
        }
        else if (touch.view == self.petIcon)
        {
            [self deSelectAllImages];
            if (self.petIcon.tag==56)
            {
                tagname=[NSString stringWithFormat:@"ic_pet"];
                [self.petIcon setImage:[UIImage imageNamed: @"ic_pet_dark.png"]];
                self.petIcon.tag=57;
            }
            else if (self.petIcon.tag==57)
            {
                tagname=[NSString stringWithFormat:@"ic_pet"];
                [self.petIcon setImage:[UIImage imageNamed: @"ic_pet.png"]];
                self.petIcon.tag=56;
            }
        }
        else if (touch.view == self.keyIcon)
        {
            [self deSelectAllImages];
            if (self.keyIcon.tag==58)
            {
                tagname=[NSString stringWithFormat:@"ic_key"];
                [self.keyIcon setImage:[UIImage imageNamed: @"ic_key_dark.png"]];
                self.keyIcon.tag=59;
            }
            else if (self.keyIcon.tag==59)
            {
                tagname=[NSString stringWithFormat:@"ic_key"];
                [self.keyIcon setImage:[UIImage imageNamed: @"ic_key.png"]];
                self.keyIcon.tag=58;
            }
        }
        else if (touch.view == self.bagIcon)
        {
            [self deSelectAllImages];
            if (self.bagIcon.tag==60)
            {
                tagname=[NSString stringWithFormat:@"ic_bag"];
                [self.bagIcon setImage:[UIImage imageNamed: @"ic_bag_dark.png"]];
                self.bagIcon.tag=61;
            }
            else if (self.bagIcon.tag==61)
            {
                tagname=[NSString stringWithFormat:@"ic_bag"];
                [self.bagIcon setImage:[UIImage imageNamed: @"ic_bag.png"]];
                self.bagIcon.tag=60;
            }
        }
        
        return YES;
    }
return NO;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesEnded: touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

- (void) deSelectAllImages{
    [self.old setImage:[UIImage imageNamed: @"ic_old_people.png"]];
    [self.questionMark setImage:[UIImage imageNamed: @"ic_question_mark.png"]];
    [self.boy setImage:[UIImage imageNamed: @"ic_child.png"]];
    [self.petIcon setImage:[UIImage imageNamed: @"ic_pet.png"]];
    [self.keyIcon setImage:[UIImage imageNamed: @"ic_key.png"]];
    [self.bagIcon setImage:[UIImage imageNamed: @"ic_bag.png"]];
    
    
    
}

- (void) clickEventOnImage:(id) sender
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addItemViewController:(SoundListViewController *)controller didFinishEnteringItem:(NSString *)item{
    ringtoneData=item;
    NSString *ringtoneDataForSplit=ringtoneData;
    NSArray *ringTonesplittedArray=[ringtoneDataForSplit componentsSeparatedByString:@"/"];
    self.ringtoneName.text=[ringTonesplittedArray objectAtIndex:ringTonesplittedArray.count-1];
    NSArray *ringToneDataArray= [ringtoneData componentsSeparatedByString:@"/"];
    NSString *ringtoneExactName=[ringToneDataArray objectAtIndex:ringToneDataArray.count-1];
    NSArray *ringToneExactArray=[ringtoneExactName componentsSeparatedByString:@"."];
    self.ringtoneName.text=[ringToneExactArray objectAtIndex:0];
    
    
}
-(void)addMusicItemViewController:(MusicViewController *)controller didFinishEnteringItem1:(NSString *)item{
    ringtoneData=item;
    self.ringtoneName.text=item;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
   // [self setLocalizeText];
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    
}
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self becomeFirstResponder];
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

- (IBAction)distanceButtonClicked:(id)sender {
    if ([sender isSelected]) {
        [self.distanceButton setImage:[UIImage imageNamed:@"ic_long.png"] forState:UIControlStateNormal];
        isDistanceLong=YES;
        [sender setSelected:NO];
    }
    else{
        [self.distanceButton setImage:[UIImage imageNamed:@"ic_short.png"] forState:UIControlStateNormal];
        isDistanceLong=NO;
        [sender setSelected:YES];
    }
}

- (IBAction)okButtonClicked:(id)sender
{
    
    if (self.address==nil || tagname==nil || ringtoneData==nil || [self.tagTitle.text isEqualToString:@""] ) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Invalid Details" message:@"Please Provide All The details\n DeviceName\n ImageName\n Color\n Ringtone\n  Adrress\n" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else
    {
        AppDelegate *objapp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        Tags *objTags=(Tags *)[NSEntityDescription insertNewObjectForEntityForName:@"Tags" inManagedObjectContext:objapp.managedObjectContext];
        objTags.deviceName=self.tagTitle.text;
        objTags.address=self.address;
        objTags.imageData=tagname;
        objTags.alert=YES;
        objTags.ringTone=ringtoneData;
        objTags.isRingTone=isSDCard;
        objTags.isLongDistance=isDistanceLong;
        NSError *error;
        if([objapp.managedObjectContext save:&error])
        {
            self.tagTitle.text=Nil;
            [self deSelectAllImages];
            self.ringtoneName.text=@"";
            [self.distanceButton setImage:[UIImage imageNamed:@"ic_long.png"] forState:UIControlStateNormal];
            self.tabBarController.selectedIndex=1;
            [self performSelector:@selector(goBacktoView) withObject:self afterDelay:0.5];
        }
    }
}

- (void)goBacktoView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backButtonClicked:(id)sender
{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)browseButtonClicked:(id)sender
{
    UIActionSheet *ringTonePickupActionSheet=[[UIActionSheet alloc]initWithTitle:[Language get:@"Choose one" alter:Nil]  delegate:self cancelButtonTitle:[Language get:@"Cancel" alter:Nil] destructiveButtonTitle:Nil otherButtonTitles:[Language get:@"Phone" alter:Nil],[Language get:@"SD CARD" alter:Nil],nil];
    [ringTonePickupActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex)
    {
        case 0:
            isSDCard=FALSE;
            [self.tabBarController.tabBar setHidden:YES];
            objSoundViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:objSoundViewController animated:YES];
            break;
            
        case 1:
        {
            isSDCard=TRUE;
            [self.tabBarController.tabBar setHidden:YES];
            objMusicViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:objMusicViewController animated:YES];
            break;
        }
        default:
            break;
    }
}
- (void)setLocalizeText{
    [self.distanceLabel setText:[Language get:@"Distance" alter:Nil]];
    [self.ringtoneLabel setText:[Language get:@"Ringtone" alter:Nil]];
    [self.sosButton setTitle:[Language get:@"S.O.S" alter:Nil] forState:UIControlStateNormal];
    [self.browseButton setTitle:[Language get:@"Browse" alter:Nil] forState:UIControlStateNormal];
}

- (IBAction)sosButtonClicked:(id)sender
{
    sosvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SOSViewController"];
    [self.navigationController pushViewController:sosvc animated:YES];
}

@end
