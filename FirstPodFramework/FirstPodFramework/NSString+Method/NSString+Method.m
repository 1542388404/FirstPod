//
//  NSString+Method.m
//  FirstPodFramework
//
//  Created by ahao on 2020/8/18.
//  Copyright © 2020 ahao. All rights reserved.
//

#import "NSString+Method.h"

@implementation NSString (Method)

//包含
- (BOOL)contains:(NSString *)words{
    if(words==nil || [NSNull isEqual:words] || words.length==0){
        return NO;
    }
    NSRange r=[self rangeOfString:words];
    if(r.length==0){
        return NO;
    }
    return YES;
}

//前缀
- (BOOL)startsWith:(NSString *)words{
    BOOL contains=[self contains:words];
    if(!contains){
        return contains;
    }
    NSRange r=[self rangeOfString:words];
    if(r.location==0){
        return YES;
    }
    return NO;
}

//后缀
- (BOOL)endsWith:(NSString *)words{
    BOOL contains=[self contains:words];
    if(!contains){
        return contains;
    }
    NSRange r=[self rangeOfString:words];
    if(r.length+r.location==self.length){
        return YES;
    }
    return NO;
}

//首次出现的位置
- (NSInteger)indexOf:(NSString *)words{
    BOOL contains=[self contains:words];
    if(!contains){
        return -1;
    }
    NSRange r=[self rangeOfString:words];
    NSInteger at=r.location;
    return at;
}

//最后出现的位置
- (NSInteger)lastIndexOf:(NSString *)words{
    if(![self contains:words]){
        return -1;
    }
    //从后往前看
    for(NSInteger i=self.length-1;i>=0;){
        NSInteger from=i-words.length+1;
        if(from<0){
            return -1;
        }
        NSRange r=NSMakeRange(from, words.length);
        NSString* node=[self substringWithRange:r];
        if([node isEqualToString:words]){
            return from;
        }
        i--;
    }
    return -1;
}

//裁剪 从from到结束
- (NSString *)substring:(NSInteger)from{
    return [self substringFromIndex:from];
}

//裁剪从 from 到 to
- (NSString *)substring:(NSInteger)from to:(NSInteger)to{
    return [self substringWithRange:NSMakeRange(from, to-from)];
}

//翻转
- (NSString *)reverse{
    NSMutableString* target=[NSMutableString new];
    for(NSInteger i=self.length-1;i>=0;i--){
        [target appendString: [self substringWithRange:NSMakeRange(i, 1)]];
    }
    return target;
}

//计数
- (NSInteger)totalCount:(NSString *)words{
    NSInteger num=0;
    NSString* s=self;
    while(true){
        NSInteger at=[s indexOf:words];
        if(at==-1){
            break;
        }
        s=[s substring:at+words.length];
        num++;
    }
    return num;
}

//替换 将from替换为to
-(NSString*)replace:(NSString*) from target:(NSString*) to{
    NSInteger at=[self indexOf:from];
    if(at==-1){
        return self;
    }
    NSString* a=[self substring:0 to:at];
    NSString* b=[self substring:at+from.length ];
    return [NSString stringWithFormat:@"%@%@%@",a,to,b];
 
}

//替换 所有,将所有的from替换为to，且from支持正则
-(NSString*)replaceAll:(NSString*)from target:(NSString*)to{
    NSRegularExpression* r=[[NSRegularExpression alloc] initWithPattern:from options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    if(r==nil){
        return self;
    }
    //NSMatchingReportProgress表明使用尽量长的匹配模式
    NSString * s=[r stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:to];
    return s;
}

//转大写
-(NSString*)toUpperCase{
    return [self uppercaseString];
}

//转小写
-(NSString*)toLowerCase{
    return [self lowercaseString];
}

//移除两端的空格
- (NSString *)trim{
    NSString* blank=@" ";
    NSString* s=self;
    while(true){
        NSInteger at=[s indexOf:blank];
        if(at==0){
            s=[s substring:1];
        }else{
            at=[s lastIndexOf:blank];
            if(at==-1){
                break;
            }
            if(at==s.length-1){
                s=[s substring:0 to:at];
            }else{
                break;
            }
        }
    }
    return s;
}
@end
