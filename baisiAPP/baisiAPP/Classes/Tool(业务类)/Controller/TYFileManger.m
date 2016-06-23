//
//  TYFileManger.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/22.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYFileManger.h"

@implementation TYFileManger

//计算文件大小是个耗时操作,所以我们需要开启子线程来计算文件夹大小
#pragma mark - 计算文件夹的大小
+ (void)getDirectorySizeOfDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger))completionBlock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //1.创建文件管理者(defaultManager 单例)
        NSFileManager *mgr = [NSFileManager defaultManager];
        //判断穿过来的参数是否是文件夹
        BOOL isDirectory;
        BOOL exist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if(!exist || !isDirectory) //如果不存在或者不是文件夹就抛出错误
        {
            //创建错误
            NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"传入了路径不存在/传入的不是文件夹" userInfo:nil];
            //抛出错误
            [exception raise];
        }
        
        //2.获取文件夹下的所有文件
        /*
         第一个参数:搜索区域
         第二个参数:磁盘类型
         第三个参数:是否展开路径
         */
        //    NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //3.拼接路径
        NSString *defaultPath = [directoryPath stringByAppendingPathComponent:@"default"];
        //3.1去除文件夹下的所有子路径
        NSArray *subPaths = [mgr subpathsAtPath:defaultPath];
        //4.遍历文件夹
        NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            //5.获取文件信息,获取文件的大小,进行累加,
            //处理数据(隐藏文件和文件夹都有大小)
            //如果有隐藏文件就忽略
            if([subPath containsString:@".DS_Store"]) continue;
            //拼接路径
            NSString *filePath = [defaultPath stringByAppendingPathComponent:subPath];
            //如果是文件夹就忽略
            [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if(isDirectory) continue;
            NSDictionary *fileInfo = [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize += [fileInfo fileSize];
        }
        //回到主线程刷新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            //调用blcok
            completionBlock(totalSize);
        });
    });
}

#pragma mark - 清空缓存
+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    //清楚缓存
    //创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if(!exist || !isDirectory) //如果不存在或者不是文件夹就抛出错误
    {
        //创建错误
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"传入了路径不存在/传入的不是文件夹" userInfo:nil];
        //抛出错误
        [exception raise];
    }
    //删除caches文件夹
    [mgr removeItemAtPath:directoryPath error:nil];
    //创建一个新的caches文件夹
    [mgr createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}



@end
