//
//  MusicViewController.m
//  LaTag_v2.0
//
//  Created by Apple on 23/05/14.
//  Copyright (c) 2014 Prakash. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.playRingtone=[[AVPlayer alloc]init];
    [btnOk setTitleTextAttributes:attrs forState:UIControlStateNormal];
    // [btnOk setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Bold" size:26.0], UITextAttributeFont,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = btnOk;
    [self loadAudioFileList];
    [self tableViewDesign];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    radioSelection=-1;
    self.navigationController.navigationBarHidden=NO;

}
- (void)tableViewDesign{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_background.png"]];
    self.songsTable.backgroundView = imageView;
    //self.songsTable.tableFooterView = [[UIView alloc] init];
    [self.songsTable reloadData];
}
- (void)addMusicItemViewController:(MusicViewController *)controller didFinishEnteringItem1:(NSString *)item{
    
    
}
-(void)doneButtonClicked:(id)sender{
    [self.playRingtone pause];
    [self.delegate addMusicItemViewController:self didFinishEnteringItem1:songPath];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}
-(void)loadAudioFileList{
    audioFileList = [[NSArray alloc] init];
    MPMediaQuery *media=[[MPMediaQuery alloc]init];
    audioFileList=[media items];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [audioFileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicListCell *cell =(MusicListCell *) [tableView
                                            dequeueReusableCellWithIdentifier:@"CellItem"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MusicListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if (radioSelection==indexPath.row) {
        cell.imageView.image=[UIImage imageNamed:@"radio-button-on.png"];
    }
    else{
        cell.imageView.image=[UIImage imageNamed:@"radio-button-off.pnh"];
    }
    MPMediaItem *item=[audioFileList objectAtIndex:indexPath.row];
    NSLog(@"%@",[audioFileList objectAtIndex:indexPath.row]);
    cell.songName.text=[item valueForKey:MPMediaItemPropertyTitle];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        return 70;
    }
    else{
        return 100;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    radioSelection=indexPath.row;
    MPMediaItem *item=[audioFileList objectAtIndex:indexPath.row];
    AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[item valueForProperty:MPMediaItemPropertyAssetURL]];
    songPath=[item valueForKey:MPMediaItemPropertyTitle];
    [self.playRingtone replaceCurrentItemWithPlayerItem:currentItem];
    [self.playRingtone play];
    [self.songsTable reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
