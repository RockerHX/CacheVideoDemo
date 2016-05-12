//
//  AppDelegate.m
//  CacheVideoDemo
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSUInteger megabytes = 1024 * 1024;
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:(250 * megabytes) diskCapacity:(250 * megabytes) diskPath:@"Video"];
    [NSURLCache setSharedURLCache:urlCache];
    
    return YES;
}

@end
