//
//  ViewController.m
//  CacheVideoDemo
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <
NSURLSessionDownloadDelegate
>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.URL
//    NSString *urlStr = @"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4";
//    NSString *urlStr = @"";
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    //2.NSURLRequest
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];
//    
//    //3.NSURLSession
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *downLoad = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"error = %@",error.localizedDescription);
//        } else {
//            // location是下载的临时文件目录
//            NSLog(@"%@", location);
//            // 如果要保存文件,需要将文件保存至沙盒
//            // 1. 根据URL获取到下载的文件名
//            NSString *fileName = [urlStr lastPathComponent];
//            // 2. 生成沙盒的路径
//            NSArray *docs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//            NSString *path = [[docs firstObject] stringByAppendingPathComponent:fileName];
//            NSURL *toURL = [NSURL fileURLWithPath:path];
//            // 3. 将文件从临时文件夹复制到沙盒,在iOS中所有的文件操作都是使用NSFileManager
//            [[NSFileManager defaultManager] copyItemAtURL:location toURL:toURL error:nil];
////            // 4. 将图像设置到UIImageView
////            dispatch_async(dispatch_get_main_queue(), ^{
////                UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
//////                _imageView.image = image;
////            });
//        }
//    }];
//    //4.因为任务默认是挂起状态，需要恢复任务（执行任务）
//    [downLoad resume];
    
}

- (IBAction)downButtonPressed {
    NSURL *url = [NSURL URLWithString:@"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue new]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];
    
    //创建一个下载任务
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@", location);
//    }];
    //创建一个下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    //启动下载任务
    [task resume];
}

#pragma mark - Private
- (void)setDownloadProgress:(double)progress {
    NSString *progressStr = [NSString stringWithFormat:@"%.1f", progress * 100];
    progressStr = [progressStr stringByAppendingString:@"%"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.progress = progress;
        _progressLabel.text = progressStr;
    });
}

#pragma mark - NSURLSessionDelegate Methods
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"didWriteData:%@", @(bytesWritten).stringValue);
    NSLog(@"totalBytesWritten:%@", @(totalBytesWritten).stringValue);
    NSLog(@"totalBytesExpectedToWrite:%@", @(totalBytesExpectedToWrite).stringValue);
    
    double progress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    [self setDownloadProgress:progress];
    NSLog(@"progress:%f", progress);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%@", location);
}

@end
