//
//  UIView+Toast.m
//  FirstPodFramework
//
//  Created by ahao on 2020/8/21.
//  Copyright © 2020 ahao. All rights reserved.
//

#import "UIView+Toast.h"
#import <objc/objc.h>
#import <objc/message.h>

@implementation UIView (Toast)
- (void)toast:(NSString *)message duration:(NSInteger)duration{
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = self;
    UIViewController* vc=nil;
    
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]]){
            vc= (UIViewController *)responder;
            break;
        }
    }
    // 如果没有找到则返回nil
    if(vc==nil){
        return;
    }
    
    UIView* archor=vc.view;
    UIView* v=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel* text=[[UILabel alloc] initWithFrame:CGRectMake(20, v.frame.size.height/2-80/2, v.frame.size.width-40, 80)];
        [v addSubview:text];
        
        [text setText:message];
        [text setFont:[UIFont systemFontOfSize:18]];
        text.layer.cornerRadius=8;
        text.layer.backgroundColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.48] CGColor];
        text.textColor=[UIColor whiteColor];
        //文字居中且超出时换行
        text.textAlignment=NSTextAlignmentCenter;
        text.lineBreakMode=NSLineBreakByCharWrapping;
        text.numberOfLines=0;
        
        [archor addSubview:v];
    });
    
    //移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [v removeFromSuperview];
    });
    
}

-(id<ILoadingProtocol>)showLoading:(NSString*)message{
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = self;
    UIViewController* vc=nil;
    
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]]){
            vc= (UIViewController *)responder;
            break;
        }
    }
    // 如果没有找到则返回nil
    if(vc==nil){
        return self;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView* archor=vc.view;
        
        UIView* v=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIView* container=[UIView new];
        
        UIActivityIndicatorView* spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        UILabel* text=[UILabel new];
        [text setText:message];
        [text setFont:[UIFont systemFontOfSize:18]];
        [text setTextColor:[UIColor whiteColor]];
        text.lineBreakMode=NSLineBreakByCharWrapping;
        text.numberOfLines=0;
        text.textAlignment=NSTextAlignmentCenter;
        
        [spinner startAnimating];//旋转起来
        
        // spinner.center=CGPointMake(v.frame.size.width/2, v.frame.size.height/2);
        spinner.color=[UIColor whiteColor];
        
        [archor addSubview:v];
        [v addSubview:container];
        [container addSubview:spinner];
        [container addSubview:text];
        
        [container setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.48]];
        container.layer.cornerRadius=8;
        container.translatesAutoresizingMaskIntoConstraints = NO; //设置contraints之前
        spinner.translatesAutoresizingMaskIntoConstraints=NO;
        text.translatesAutoresizingMaskIntoConstraints=NO;
        
        [container addConstraint:[NSLayoutConstraint constraintWithItem:spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [container addConstraint:[NSLayoutConstraint constraintWithItem:spinner attribute:NSLayoutAttributeTop  relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:20]];
        
        [container addConstraint:[NSLayoutConstraint constraintWithItem:text attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [container addConstraint:[NSLayoutConstraint constraintWithItem:text attribute:NSLayoutAttributeTop  relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:spinner attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
        
        [v addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:text attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
        
        //发现可以通过constraint限制最大宽度和最大宽度内进行宽度自适应
        [v addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:text attribute:NSLayoutAttributeLeft multiplier:1 constant:-10]];
        
        [v addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
        
        
        [v addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [v addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self setLibLoadingViewInternal:v];
        
    });
    return self;
}

-(void)hideLoading{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView* v=self.libLoadingViewInternal;
        if(v!=nil){
            [v removeFromSuperview];
            //移除
            objc_setAssociatedObject(self, @"_libLoadingViewInternal", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
    });
}
- (void)setLibLoadingViewInternal:(UIView *)libLoadingViewInternal{
    objc_setAssociatedObject(self, @"_libLoadingViewInternal", libLoadingViewInternal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)libLoadingViewInternal{
    return objc_getAssociatedObject(self, @"_libLoadingViewInternal");
}
@end
