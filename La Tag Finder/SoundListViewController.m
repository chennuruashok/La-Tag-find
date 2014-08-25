//
//  SoundListViewController.m
//  LaTag_v2.0
//
//  Created by Apple on 28/03/14.
//  Copyright (c) 2014 Prakash. All rights reserved.
//

#import "SoundListViewController.h"

@interface SoundListViewController ()

@end

@implementation SoundListViewController
@synthesize songsTable;
@synthesize playRingtone;

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
    UIBarButtonItem *btnOk = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked:) ];
  //[btnOk setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor greenColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    NSDictionary *attrs = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:20] };
    [btnOk setTitleTextAttributes:attrs forState:UIControlStateNormal];
   // [btnOk setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Bold" size:26.0], UITextAttributeFont,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = btnOk;
    [self loadAudioFileList];
    [self tableViewDesign];

	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    radioSelection=-1;
    self.navigationController.navigationBarHidden=NO;
    //self.tabBarController.tabBar.hidden=YES;
    
}
- (void)tableViewDesign{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    self.songsTable.backgroundView = imageView;
    //self.songsTable.tableFooterView = [[UIView alloc] init];
    [self.songsTable reloadData];
}
- (void)addItemViewController:(SoundListViewController *)controller didFinishEnteringItem:(NSString *)item{
    
    
}
-(void)doneButtonClicked:(id)sender{
    [self.playRingtone pause];
    [self.delegate addItemViewController:self didFinishEnteringItem:songPath];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}
-(void)loadAudioFileList{
    audioFileList = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *directoryURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
        }
        else if (! [isDirectory boolValue]) {
            [audioFileList addObject:url];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [audioFileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundListCell *cell =(SoundListCell *) [tableView
                                            dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SongCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if (radioSelection==indexPath.row) {
        cell.imageView.image=[UIImage imageNamed:@"radio-button-on.png"];
    }
    else{
        cell.imageView.image=[UIImage imageNamed:@"radio-button-off.png"];
    }
    cell.songName.text=[[audioFileList objectAtIndex:indexPath.row] lastPathComponent];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        return 65;
    }
    else{
        return 100;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    radioSelection=indexPath.row;
    songPath=[[audioFileList objectAtIndex:indexPath.row] description];
    NSString *tonePathForPlay= [songPath substringFromIndex:6];
    NSURL *songPath1=[[NSURL alloc]initFileURLWithPath:tonePathForPlay];
    self.playRingtone=[[AVAudioPlayer alloc]initWithContentsOfURL:songPath1 error:Nil];
    [self.playRingtone play];
    [self.songsTable reloadData];
    
}

@end
