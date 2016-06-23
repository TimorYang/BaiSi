//
//  TYFileManger.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/22.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYFileManger : NSObject

+ (void)getDirectorySizeOfDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger))completionBlock;
 
@end
