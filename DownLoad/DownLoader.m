//
//  DownLoader.m
//  DownLoad
//
//  Created by 李言 on 15/11/26.
//  Copyright © 2015年 李言. All rights reserved.
//

#import "DownLoader.h"
@interface DownLoader()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic, strong)NSURL  *requestUrl;
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
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:MAXFLOAT];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}
/**
 *  请求失败的回掉
 *
 *  @param connection 当前的connection
 *  @param error      错误描述
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {


}

/**
 *  接到数据响应回掉，这里可以获取到文件的总大小
 *
 *  @param connection 当前的connection
 *  @param response   响应 这里可以获取到文件的总大小
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {


}

/**
 *  当接到具体数据的回掉，下载过程中会调用多次
 *
 *  @param connection 当前的connection
 *  @param data       当次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {


}

/**
 *  下载完成时的回掉
 *
 *  @param connection 当前的connection
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {


}
@end
