//
//  DownLoader.m
//  DownLoad
//
//  Created by 李言 on 15/11/26.
//  Copyright © 2015年 李言. All rights reserved.
//

#import "DownLoader.h"
#import <UIKit/UIKit.h>
#import "NSString+MD5.h"
@interface DownLoader()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic, strong)NSURL  *requestUrl;
@property (nonatomic, assign)long long     totalFileLength;
@property (nonatomic, assign)CGFloat       progress;
@property (nonatomic, strong)NSFileHandle  *fileHandle;
@property (nonatomic, assign)long long     currentFileLength;
@property (nonatomic, strong)NSURLConnection *connection;
@end

@implementation DownLoader

/**
 *  根据URL初始化
 *
 *  @param url 传入下载的URL
 *
 *  @return 当前的实例
 */
- (instancetype)initWithDownLoadUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _requestUrl = url;
           }
    return self;

}



/**
 *  开始下载
 */
- (void)startDownLoad{
    if (!self.requestUrl) {
        return;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:MAXFLOAT];

    /**
     *  这里用更新的方法，更新 可以实现读取和写入的功能
     */
    self.fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[kRootPath stringByAppendingPathComponent:[[self.requestUrl absoluteString] MD5String]]];
    
    long long  offset =  [self.fileHandle seekToEndOfFile];
    
    NSString *range = [NSString stringWithFormat:@"bytes=%lld-", offset];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.connection start];
}
/**
 *  暂停
 */
- (void)pauseDownLoad{
    
    self.state = DownloadTaskStatePause;
    [self.connection cancel];
    self.connection = nil;
    [self.fileHandle closeFile];
    self.fileHandle = nil;

}
/**
 *  取消  移除本地文件
 */

- (void)canclDownLoad{
    self.state = DownloadTaskStateCancel;
    [self.connection cancel];
    self.connection = nil;
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[kRootPath stringByAppendingPathComponent:[[self.requestUrl absoluteString] MD5String]] error:&error];
}

/**
 *  请求失败的回掉
 *
 *  @param connection 当前的connection
 *  @param error      错误描述
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    
    self.state = DownloadTaskStateError;
}

/**
 *  接到数据响应回掉，这里可以获取到文件的总大小
 *
 *  @param connection 当前的connection
 *  @param response   响应 这里可以获取到文件的总大小
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
;

    /**
     *  获取文件总长度
     */
    self.totalFileLength = response.expectedContentLength;
    
    self.state = DownloadTaskStateRunning;
    
    


}

/**
 *  当接到具体数据的回掉，下载过程中会调用多次
 *
 *  @param connection 当前的connection
 *  @param data       当次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [self.fileHandle seekToEndOfFile];
    
    [self.fileHandle writeData:data];
    
    
    self.currentFileLength += data.length;
    self.progress = (CGFloat)self.currentFileLength/self.totalFileLength;
    
    self.state = DownloadTaskStateRunning;
}

/**
 *  下载完成时的回掉
 *
 *  @param connection 当前的connection
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    self.currentFileLength = 0 ;
    self.totalFileLength = 0 ; 
    //下载完成 关闭filehandle
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    
    self.state = DownloadTaskStateFinished;
}
@end
