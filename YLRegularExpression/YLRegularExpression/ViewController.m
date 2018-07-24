//
//  ViewController.m
//  YLRegularExpression
//
//  Created by guimi on 2018/7/3.
//  Copyright © 2018年 guimi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 学习链接：

// 正则表达式30分钟入门教程
// https://deerchao.net/tutorials/regex/regex.htm

// 在线正则表达式测试
// http://tool.oschina.net/regex

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"正则表达式";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self userPredicate];
    
    [self userRangeOfString];
    
    [self userRegularExpression];
    
    [self userRegularExpressionRangeOfFirst];
    
    [self userRegularExpressionMatches];
    
    [self userRegularExpressionNumberOfMatches];
    
    [self userRegularExpressionEnumerateMatches];
    
    [self userRegularExpressionReplacingMatchesString];
    
    [self userRegularExpressionReplaceMatchesAndReturnNumber];
}

#pragma mark - 使用谓词创建正则表达式
- (void)userPredicate
{
    NSString *regex = @"^[a-z0-9A-Z]+$";
    NSString *string = @"Hello100";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:string]) {
        NSLog(@"mathch");
    }
}

#pragma mark - NSString实例方法
- (void)userRangeOfString
{
    NSString *regex = @"^1[3]\\d{9}$";
    NSString *string = @"13143503442";
    
    NSRange range = [string rangeOfString:regex options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSLog(@"%@",[string substringWithRange:range]);
    }
}

#pragma mark - NSRegularExpressio 匹配第一个
- (void)userRegularExpression
{
    NSString *regex = @"[^@]*\\.";
    NSString *string = @"1229436624@qq.com";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        NSTextCheckingResult *match = [regular firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (match) {
            NSString *reslut = [string substringWithRange:match.range];
            NSLog(@"result : %@",reslut);
        }
    } else {
        NSLog(@"error : %@",error);
    }
}

#pragma mark - NSRegularExpressio 匹配第一个的范围
- (void)userRegularExpressionRangeOfFirst
{
    NSString *regex = @"[^@]*\\.";
    NSString *string = @"1229436624@qq.com";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange range = [regular rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    NSLog(@"first range : %ld ,%ld",range.location,range.length);
}

#pragma mark - NSRegularExpression 匹配多个结果
- (void)userRegularExpressionMatches
{
    // 以-开头.结尾中间1个到多个数字或字母的字符串
    NSString *regex = @"-\\w+\\.";
    NSString *string = @"-3ds.-76cvv.";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matchs = [regular matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult *match in matchs) {
        NSRange range = [match range];
        NSString *str = [string substringWithRange:range];
        NSLog(@"%@",str);
    }
}

#pragma mark - NSRegularExpression 匹配数量
- (void)userRegularExpressionNumberOfMatches
{
    NSString *regex = @"-\\w+\\.";
    NSString *string = @"-3ds.-76cvv.-sdf.";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSInteger number = [regular numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    NSLog(@"number : %ld",number);
}

#pragma mark - NSRegularExpression 遍历匹配的内容
- (void)userRegularExpressionEnumerateMatches
{
    NSString *regex = @"-\\w+\\.";
    NSString *string = @"-3ds.-76cvv.-sdf.";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    __block NSString *changeStr = string.copy;
    [regular enumerateMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        NSString *matchStr = [string substringWithRange:result.range];
        changeStr =  [changeStr stringByReplacingOccurrencesOfString:matchStr withString:@"syl|"];
    }];
    NSLog(@"change string : %@",changeStr);
}

#pragma mark - NSRegularExpression 替换匹配内容，返回新字符串
- (void)userRegularExpressionReplacingMatchesString
{
    NSString *regex = @"-\\w+\\.";
    NSString *string = @"-3ds.-76cvv.-sdf.";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString *changeStr = [regular stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@"syl|"];
    NSLog(@"change string : %@",changeStr);
}

#pragma mark - NSRegularExpression 修改字符串，替换匹配内容，返回匹配数量
- (void)userRegularExpressionReplaceMatchesAndReturnNumber
{
    NSString *regex = @"-\\w+\\.";
    NSMutableString *string = @"-3ds.-76cvv.-sdf.".mutableCopy;
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSInteger number =  [regular replaceMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@"syl|"];
    NSLog(@"change string : %@  number : %ld",string,number);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
