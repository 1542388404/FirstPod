//
//  PersisitCacheHelper.m
//  FirstPodFramework
//
//  Created by ahao on 2020/8/21.
//  Copyright © 2020 ahao. All rights reserved.
//

#import "PersistCacheHelper.h"

@interface PersistCacheHelper()
@end

@implementation PersistCacheHelper

+ (instancetype)defaultManager{
    static PersistCacheHelper* m=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m=[[PersistCacheHelper alloc] initWithCategoryName:@"PersisitCacheHelper"];
    });
    return m;
}
- (instancetype)initWithCategoryName:(NSString *)categoryName{
    if(categoryName==nil){
          return nil;
    }
    self=[super init];
    self.categoryName=categoryName;
    return self;
}
-(void)save:(NSString *)name data:(NSString *)data{
    NSUserDefaults* saver=[self getSaver];
    [saver setObject:data forKey:name];
    [saver synchronize];
}
- (void)del:(NSString *)name{
    NSUserDefaults* saver=[self getSaver];
    [saver removeObjectForKey:name];
    [saver synchronize];
}
- (NSString*)query:(NSString *)name{
    NSUserDefaults* saver=[self getSaver];
    return [saver objectForKey:name];
}

- (void)clear{
    NSUserDefaults* saver=[self getSaver];
    NSDictionary* dict=saver.dictionaryRepresentation;
    for(NSString* a in dict.allKeys){
        [saver removeObjectForKey:a];
    }
}
-(NSUserDefaults*)getSaver{
    NSUserDefaults* saver=[[NSUserDefaults alloc]initWithSuiteName:self.categoryName ];
    return saver;
}
@end
