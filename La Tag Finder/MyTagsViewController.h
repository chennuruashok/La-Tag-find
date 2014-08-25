//
//  MyTagsViewController.h
//  La Tag Finder
//
//  Created by @shu chennuru on 8/18/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "tagCustomCell.h"


@interface MyTagsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_tags;
    DetailViewController *_tagDetailViewController;
}

@property(retain) NSMutableArray *tags;
@property(retain) DetailViewController *tagDetailViewController;
@property (strong, nonatomic) IBOutlet UITableView *myTagsTable;

@end
