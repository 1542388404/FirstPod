//
//  NSString+Method.h
//  FirstPodFramework
//
//  Created by ahao on 2020/8/18.
//  Copyright © 2020 ahao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Method)
//包含
-(BOOL) contains:(NSString*)words;
//前缀
-(BOOL) startsWith:(NSString*)words;
//后缀
-(BOOL) endsWith:(NSString*)words;
//首次出现的位置
-(NSInteger) indexOf:(NSString*)words;
//最后出现的位置
-(NSInteger) lastIndexOf:(NSString*)words;
//裁剪从 from 到 to
-(NSString*) substring:(NSInteger) from to:(NSInteger) to;
//裁剪 从from到结束
-(NSString*) substring:(NSInteger) from;
//翻转
-(NSString*)reverse;
//计数
-(NSInteger)totalCount:(NSString*)words;
//替换 将from替换为to
-(NSString*)replace:(NSString*) from target:(NSString*) to;
//替换 所有,将所有的from替换为to，且from支持正则
-(NSString*)replaceAll:(NSString*)from target:(NSString*)to;
//转大写
-(NSString*)toUpperCase;
//转小写
-(NSString*)toLowerCase;
//移除两端的空格
-(NSString*)trim;

@end

NS_ASSUME_NONNULL_END
