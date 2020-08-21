//
//  UIView+Toast.h
//  FirstPodFramework
//
//  Created by ahao on 2020/8/21.
//  Copyright © 2020 ahao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILoadingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Toast)<ILoadingProtocol>
@property UIView* libLoadingViewInternal;
-(void)toast:(NSString*)message duration:(NSInteger)duration;
-(id<ILoadingProtocol>)showLoading:(NSString*)message;
-(void)hideLoading;
@end

NS_ASSUME_NONNULL_END
