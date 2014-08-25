//
//  AppDelegate.m
//  La Tag Finder
//
//  Created by @shu chennuru on 8/14/14.
//  Copyright (c) 2014 vedas. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Language initialize];
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone)
    {
        CGSize iOSDeviceScreenSize=[[UIScreen mainScreen]bounds].size;
        if (iOSDeviceScreenSize.height==480)
        {
            UIStoryboard *Main_iPhone = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *initialViewController = [Main_iPhone instantiateInitialViewController];
            
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            self.window.rootViewController  = initialViewController;
            
            MyTabViewController *tabVC = (MyTabViewController *)self.window.rootViewController;
            NSArray* unselectedImages =[NSArray arrayWithObjects:@"ic_pairing",@"ic_radar",@"ic_settings",@"ic_info", nil];
            NSArray* selectedImages =[NSArray arrayWithObjects:@"ic_pairing_dark",@"ic_radar_dark",@"ic_settings_dark1",@"ic_info_dark", nil];
            [[tabVC.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 320,500)];
            NSArray *items = tabVC.tabBar.items;
            for (int idx=0; idx < items.count;  idx++) {
                UITabBarItem *item = [items objectAtIndex:idx];
                UIImage *selectedImage = [UIImage imageNamed:[selectedImages objectAtIndex:idx]];
                UIImage *unSelectedImage = [UIImage imageNamed:[unselectedImages objectAtIndex:idx]];
                [item setImage:[unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            }
            tabVC.tabBar.frame=CGRectMake(0, 420, 320, 70);
            
            [tabVC.tabBar setBackgroundImage:[UIImage imageNamed:@"ic_background.png"]];
            tabVC.tabBar.autoresizesSubviews = NO;
            tabVC.tabBar.clipsToBounds = YES;
            tabVC.selectedIndex = 1;
        }
        if (iOSDeviceScreenSize.height == 568)
        {   // iPhone 5 and iPod Touch 5th generation: 4 inch screen (diagonally measured)
        
        // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
        UIStoryboard *Main_iPhone = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        // Instantiate the initial view controller object from the storyboard
        UIViewController *initialViewController = [Main_iPhone instantiateInitialViewController];
        
        // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        // tabVC.tabBar.frame=CGRectMake(0, 500, 320, 70);
        
        // Set the initial view controller to be the root view controller of the window object
        self.window.rootViewController  = initialViewController;
        MyTabViewController *tabVC = (MyTabViewController *)self.window.rootViewController;
            NSArray* unselectedImages =[NSArray arrayWithObjects:@"ic_pairing",@"ic_radar",@"ic_settings",@"ic_info", nil];
            NSArray* selectedImages =[NSArray arrayWithObjects:@"ic_pairing_dark",@"ic_radar_dark",@"ic_settings_dark1",@"ic_info_dark", nil];
        [[tabVC.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 320,530)];
        NSArray *items = tabVC.tabBar.items;
        for (int idx=0; idx < items.count;  idx++) {
            UITabBarItem *item = [items objectAtIndex:idx];
            UIImage *selectedImage = [UIImage imageNamed:[selectedImages objectAtIndex:idx]];
            UIImage *unSelectedImage = [UIImage imageNamed:[unselectedImages objectAtIndex:idx]];
            [item setImage:[unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        tabVC.tabBar.frame=CGRectMake(0, 500, 320, 70);
        
        [tabVC.tabBar setBackgroundImage:[UIImage imageNamed:@"background.png"]];
        tabVC.tabBar.autoresizesSubviews = NO;
        tabVC.tabBar.clipsToBounds = YES;
        tabVC.selectedIndex = 1;
        
        // Set the window object to be the key window and show it
        //[self.window makeKeyAndVisible];
    }
    
}
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    
    sleep(1);
    // Override point for customization after application launch.
    return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    // NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"project" withExtension:@"momd"];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"latagFinder.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
