//
//  MyTagsViewController.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "MyTagsViewController.h"
#import "Tags.h"

@interface MyTagsViewController()

@end

@implementation MyTagsViewController
@synthesize tagDetailViewController=_tagDetailViewController;
@synthesize tags;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tags=[[NSMutableArray alloc]init];

}
- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self.myTagsTable reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tagCustomCell *cell =(tagCustomCell *) [tableView
                                            dequeueReusableCellWithIdentifier:@"apple"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"tagCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Tags *objTags=[self.tags objectAtIndex:indexPath.row];
    NSString *imageNamePrepair=[NSString stringWithFormat:@"%@_%@.png",objTags.imageData,objTags.colorName];
    
    cell.deviceImageView.image=[UIImage imageNamed:imageNamePrepair];
    cell.deviceName.text=objTags.deviceName;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        return 75;
    }
    else{
        return 100;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    UITableViewCell  *cell =[tableView cellForRowAtIndexPath:indexPath];
    
    [self setCellColor:[UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f] ForCell:cell];  //highlight colour
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    UITableViewCell  *cell =[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor clearColor] ForCell:cell]; //normal color
}
- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [Language get:@"Delete" alter:Nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"connected"])
        {
            AppDelegate *objAppDelegate=[[UIApplication sharedApplication]delegate];
            [objAppDelegate.managedObjectContext deleteObject:[self.tags objectAtIndex:indexPath.row]];
            [objAppDelegate saveContext];
            [self.tags removeObjectAtIndex:indexPath.row];
            [self.myTagsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.myTagsTable reloadData];
            
        }
        
        
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 480)
        {
            self.tagDetailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TagDetailViewController"];
        }
    [self.tagDetailViewController setValue:[self.tags objectAtIndex:indexPath.row] forKey:@"updateTagData"];
    [self.tabBarController hidesBottomBarWhenPushed];
    [self.navigationController pushViewController:self.tagDetailViewController animated:YES];
    }
}
@end
