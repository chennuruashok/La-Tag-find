//
//  SoundListViewController.h
//  LaTag_v2.0
//
//  Created by Apple on 28/03/14.
//  Copyright (c) 2014 Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SoundListCell.h"
@class SoundListViewController;
@protocol SoundListViewControllerDelegate<NSObject>
- (void)addItemViewController:(SoundListViewController *)controller didFinishEnteringItem:(NSString *)item;

@end
@interface SoundListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
NSMutableArray *audioFileList;
NSString *songPath;
int radioSelection;
}
@property (nonatomic,retain) IBOutlet UITableView *songsTable;
@property (nonatomic, weak) id <SoundListViewControllerDelegate> delegate;
@property(nonatomic,retain)AVAudioPlayer *playRingtone;
@end
