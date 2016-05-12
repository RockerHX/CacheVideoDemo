//
//  HXSessionDelegateViewController.m
//  CacheVideoDemo
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSessionDelegateViewController.h"


@interface HXSessionDelegateViewController () <
NSURLSessionDownloadDelegate
>
@end


@implementation HXSessionDelegateViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Event Response
- (IBAction)downButtonPressed {
    NSURL *url = [NSURL URLWithString:@"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue new]];
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    NSLog(cachedResponse ? @"Cached response found!" : @"No cached response found.");
    
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request];
    [downLoadTask resume];
}

#pragma mark - Private Methods
- (void)setDownloadProgress:(double)progress {
    NSString *progressStr = [NSString stringWithFormat:@"%.1f", progress * 100];
    progressStr = [progressStr stringByAppendingString:@"%"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.progress = progress;
        _progressLabel.text = progressStr;
    });
}

#pragma mark - NSURLSessionDownloadDelegate Methods
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    double progress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    [self setDownloadProgress:progress];
//    NSLog(@"didWriteData:%@", @(bytesWritten).stringValue);
//    NSLog(@"totalBytesWritten:%@", @(totalBytesWritten).stringValue);
//    NSLog(@"totalBytesExpectedToWrite:%@", @(totalBytesExpectedToWrite).stringValue);
//    NSLog(@"progress:%f", progress);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
//    NSLog(@"%@", location);
    NSURLRequest *request = downloadTask.originalRequest;
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    if (!cachedResponse.data) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        NSCachedURLResponse *cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:downloadTask.response data:data];
        [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse forRequest:request];
    }
    NSLog(@"DiskCache: %@ of %@", @([[NSURLCache sharedURLCache] currentDiskUsage]), @([[NSURLCache sharedURLCache] diskCapacity]));
    NSLog(@"MemoryCache: %@ of %@", @([[NSURLCache sharedURLCache] currentMemoryUsage]), @([[NSURLCache sharedURLCache] memoryCapacity]));
}

@end
