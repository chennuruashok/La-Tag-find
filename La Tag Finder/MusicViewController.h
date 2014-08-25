//
//  MusicViewController.h
//  LaTag_v2.0
//
//  Created by Apple on 23/05/14.
//  Copyright (c) 2014 Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MusicListCell.h"
@class MusicViewController;
@protocol MusicViewControllerDelegate<NSObject>
- (void)addMusicItemViewController:(MusicViewController *)controller didFinishEnteringItem1:(NSString *)item;

@end
@interface MusicViewController : UITableViewController
{
NSArray *audioFileList;
NSString *songPath;
int radioSelection;
}
@property (nonatomic,retain) IBOutlet UITableView *songsTable;
@property (nonatomic, weak) id <MusicViewControllerDelegate> delegate;
@property(nonatomic,retain)AVPlayer *playRingtone;
@end
