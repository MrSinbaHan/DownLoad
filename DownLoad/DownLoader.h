//
//  DownLoader.h
//  DownLoad
//
//  Created by 李言 on 15/11/26.
//  Copyright © 2015年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kRootPath [NSString stringWithFormat:@"%@/Library/workshop", NSHomeDirectory()]
typedef NS_ENUM(NSInteger, DownloadState) {
    DownloadTaskStateInit    = 0,  // 任务初始状态 未开始下载
    DownloadTaskStateWaiting = 1,  // 等待状态
    DownloadTaskStateRunning = 2,  // 运行状态
    DownloadTaskStatePause   = 3,  // 暂停状态
    DownloadTaskStateFinished= 4,  // 结束状态
    DownloadTaskStateError   = 5,  // 错误状态
    DownloadTaskStateCancel   = 6,  // 错误状态

};

@interface DownLoader : NSObject

@property (nonatomic, assign)DownloadState state;

@property (nonatomic, readonly)NSURL  *requestUrl;
/**
 *  根据URL初始化
 *
 *  @param url 传入下载的URL
 *
 *  @return 当前的实例
 */
- (instancetype)initWithDownLoadUrl:(NSURL *)url;
@end
