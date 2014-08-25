//
//  SOSViewController.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "SOSViewController.h"

@interface SOSViewController()

@end

@implementation SOSViewController
@synthesize labaIcon;
@synthesize latagFinderLabel;
@synthesize sosLabel;
@synthesize nameLabel;
@synthesize emailLabel;
@synthesize messageBox;
@synthesize messageLabel;
@synthesize sosButton;
@synthesize nameTextFeild;
@synthesize emailTextField;


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
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [self.scroller setContentSize:CGSizeMake(320, 600)];
    }
    self.emailTextField.keyboardType=UIKeyboardTypeEmailAddress;
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self showExistedDataInTextFields];
    [self.nameLabel setText:[Language get:@"Name" alter:Nil]];
    [self.emailLabel setText:[Language get:@"Email" alter:Nil]];
    [self.messageLabel setText:[Language get:@"Message" alter:Nil]];
}
- (void)showExistedDataInTextFields
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor grayColor]CGColor];
    if (textField==self.emailTextField) {
        if (![self validateEmailWithString:self.emailTextField.text]) {
            [self.emailTextField setTextColor:[UIColor redColor]];
            if (![self.emailTextField.text isEqualToString:@""]) {
                UIAlertView *emailALert=[[UIAlertView alloc]initWithTitle:@" Invalid Email Address" message:@"Plaese Provide valid Email Address" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"ok", nil];
                emailALert.tag=2;
                sosEmailCheck=Nil;
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 40, 40)];
                // NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ic_sos_phone.png"]];
                // UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
                UIImage *bkgImg = [UIImage imageNamed:@"ic_notification_phone.png"];
                [imageView setImage:bkgImg];
                [emailALert addSubview:imageView];
                [emailALert show];
            }
        }
        else{
            sosEmailCheck=self.emailTextField.text;
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            if (alertView.tag==1) {
                // [self.sosPhoneTextField setText:Nil];
                sosEmailCheck=Nil;
            }
            else if (alertView.tag==2) {
                //[self.sosEmailTextField setText:Nil];
                sosEmailCheck=Nil;
            }
            break;
            
        default:
            break;
    }
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
 [textField resignFirstResponder];
 return YES;
 
 }*/

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor greenColor]CGColor];
    textField.layer.borderWidth= 2.0f;
    // activeField = textField;
    if(textField==self.emailTextField)
    {
        [self.emailTextField setTextColor:[UIColor whiteColor]];
    }
    [self.scroller setContentOffset:CGPointMake(0,textField.center.y-60) animated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self.scroller setContentOffset:CGPointMake(0,textView.center.y-60) animated:YES];
    
    textView.layer.cornerRadius=8.0f;
    textView.layer.masksToBounds=YES;
    textView.layer.borderColor=[[UIColor greenColor]CGColor];
    textView.layer.borderWidth= 2.0f;
    
}
// called when click on the retun button.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [self.scroller setContentOffset:CGPointMake(0,textField.center.y-60) animated:YES];
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        [self.scroller setContentOffset:CGPointMake(0,0) animated:YES];
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.nameTextFeild) {
        if ([textField.text length] > 15) {
            textField.text = [textField.text substringToIndex:15-1];
            return NO;
        }
        
    }
    else if (textField==self.emailTextField){
        if ([textField.text length] >30) {
            textField.text = [textField.text substringToIndex:30-1];
            return NO;
        }
        
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    else
        return textView.text.length + (text.length - range.length) <= 80;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    textView.layer.borderColor=[[UIColor grayColor]CGColor];
    return YES;
}
- (void)goBacktoView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(BOOL)isNumeric:(NSString*)inputString
{
    NSCharacterSet *charcter =[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[inputString componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
    return [inputString isEqualToString:filtered];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [self.nameTextFeild setText:Nil];
    [self.messageBox setText:Nil];
    sosEmailCheck=Nil;
    [self.emailTextField setText:Nil];
    
}
- (IBAction)backButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)okButton:(id)sender
{
    [self.nameTextFeild resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.messageBox resignFirstResponder];
    if (![self validateEmailWithString:self.emailTextField.text])
    {
        sosEmailCheck=Nil;
        [self.emailTextField setTextColor:[UIColor redColor]];
        self.emailTextField.layer.borderColor=[[UIColor redColor]CGColor];
    }
    else
        sosEmailCheck=self.emailTextField.text;
    //  NSLog(@"%@,___%@____%@_____%@___%d",self.selectedTag.sosName,self.selectedTag.sosEmail,self.selectedTag.sosMessage,self.selectedTag.sosAlert) ;
    if ([self.nameTextFeild.text isEqualToString:@" " ]||sosEmailCheck==Nil||[self.messageBox.text isEqualToString:@""] ) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Invalid Details" message:@"Please Provide All The details Correctly\n Name\n Phone Number\n Email\n Message\n " delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else
    {
        AppDelegate *objAppDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSError *error;
        if([objAppDelegate.managedObjectContext save:&error]){
            [self.nameTextFeild setText:Nil];
            [self.messageBox setText:Nil];
            sosEmailCheck=Nil;
            [self.emailTextField setText:Nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)sosButton:(id)sender
{
    if ([self.sosButton isSelected]) {
        [self.sosButton setImage:[UIImage imageNamed:@"ic_sos_off.png"] forState:UIControlStateNormal];
        [self.sosButton setSelected:NO];
        self.nameTextFeild.enabled=NO;
        self.emailTextField.enabled=NO;
        self.messageBox.editable=NO;
    }
    else{
        [self.sosButton setImage:[UIImage imageNamed:@"ic_sos_on.png"] forState:UIControlStateNormal];
        [self.sosButton setSelected:YES];
        self.nameTextFeild.enabled=YES;
        self.emailTextField.enabled=YES;
        self.messageBox.editable=YES;
    }
}

@end
