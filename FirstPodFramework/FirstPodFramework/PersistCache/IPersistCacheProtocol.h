//
//  IPersistCacheProtocol.h
//  FirstPodFramework
//
//  Created by ahao on 2020/8/21.
//  Copyright © 2020 ahao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IPersistCacheProtocol <NSObject>
-(void)save:(NSString*) name data:(NSString*)data;
-(void)del:(NSString*)name;
-(NSString*)query:(NSString*)name;
-(void)clear;
@end

NS_ASSUME_NONNULL_END
