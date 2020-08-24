//
//  NSFileManager+Dir.m
//  AFNetworking
//
//  Created by ahao on 2020/8/21.
//

#import "NSFileManager+sandDir.h"

@implementation NSFileManager (Dir)
+ (NSString *)dirHome{
    return NSHomeDirectory();
}
+ (NSString *)dirTemp{
    return NSTemporaryDirectory();
}
+ (NSString *)dirCaches{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)dirLibrary{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)dirDocument{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)dirPreferences{
    return [[NSFileManager dirLibrary] stringByAppendingPathComponent:@"Preferences"];
}
@end
