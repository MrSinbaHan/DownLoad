//
//  DownLoader.h
//  DownLoad
//
//  Created by 李言 on 15/11/26.
//  Copyright © 2015年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoader : NSObject

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
