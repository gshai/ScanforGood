//
//  SRAppDelegate.h
//  ScanForGood
//
//  Created by Gilad Shai on 3/3/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
