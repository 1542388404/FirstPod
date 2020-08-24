//
//  PersisitCacheHelper.h
//  FirstPodFramework
//
//  Created by ahao on 2020/8/21.
//  Copyright © 2020 ahao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPersistCacheProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersistCacheHelper : NSObject<IPersistCacheProtocol>
@property(nonatomic,copy)NSString* categoryName;
-(instancetype)initWithCategoryName:(NSString*) categoryName;
+(instancetype)defaultManager;
@end

NS_ASSUME_NONNULL_END
