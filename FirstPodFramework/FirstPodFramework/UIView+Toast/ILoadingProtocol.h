//
//  ILoadingProtocol.h
//  AFNetworking
//
//  Created by ahao on 2020/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ILoadingProtocol <NSObject>
-(id<ILoadingProtocol>) showLoading:(NSString*)message;
-(void)hideLoading;
@end

NS_ASSUME_NONNULL_END
