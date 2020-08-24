//
//  NSFileManager+Dir.h
//  AFNetworking
//
//  Created by ahao on 2020/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Dir)

+(NSString*)dirHome;
+(NSString*)dirTemp;
+(NSString*)dirLibrary;
+(NSString*)dirCaches;
+(NSString*)dirDocument;
+(NSString*)dirPreferences;

@end

NS_ASSUME_NONNULL_END
