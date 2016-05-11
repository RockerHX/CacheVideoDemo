//
//  ViewController.m
//  CacheVideoDemo
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSURL *url = [NSURL URLWithString:@"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4"];
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    configuration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    [session downloadTaskWithURL:url];
//    [session getTasksWithCompletionHandler:
//     ^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
//         NSLog(@"dataTasks:%@", dataTasks);
//         NSLog(@"uploadTasks:%@", uploadTasks);
//         NSLog(@"downloadTasks:%@", downloadTasks);
//    }];
    
    
    
    //1.URL
//    NSString *urlStr = @"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4";
//    NSString *urlStr = @"http://down.bigbaicai.com/down/BigBaiCai_v5.exe";
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
    //创建下载图片的url
    NSURL *url = [NSURL URLWithString:@"http://miadata1.ufile.ucloud.cn/piano_test/173.mp4"];
    
    //创建网络请求配置类
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue new]];
    
    //创建请求并设置缓存策略以及超时时长
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.f];
    //*也可通过configuration.requestCachePolicy 设置缓存策略
    
    //创建一个下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:imgRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        //下载完成后获取数据 此时已经自动缓存到本地，下次会直接从本地缓存获取，不再进行网络请求
//        NSData * data = [NSData dataWithContentsOfURL:location];
//        
//        //回到主线程
//        dispatch_async(dispatch_get_main_queue(), ^{
//        });
        NSLog(@"%@", location);
    }];
    //启动下载任务
    [task resume];
}

@end
