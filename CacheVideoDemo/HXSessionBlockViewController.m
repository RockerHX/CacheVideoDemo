//
//  HXSessionBlockViewController.m
//  CacheVideoDemo
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSessionBlockViewController.h"


@interface HXSessionBlockViewController ()
@end


@implementation HXSessionBlockViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Event Response
- (IBAction)downButtonPressed {
    NSURL *url = [NSURL URLWithString:@"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];
    NSURLSession *session = [NSURLSession sharedSession];
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    NSLog(cachedResponse.data ? @"Cached response found!" : @"No cached response found.");
    
    //创建一个下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", location);
        if (!cachedResponse.data) {
            NSData *data = [NSData dataWithContentsOfURL:location];
            NSCachedURLResponse *cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse forRequest:request];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载成功！"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        });
    }];
    [task resume];
}

@end
