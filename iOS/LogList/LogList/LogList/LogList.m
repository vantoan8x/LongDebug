//
//  LogList.m
//  LogList
//
//  Created by hangnguyen on 9/18/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "LogList.h"

@interface LogList () <WKUIDelegate, WKNavigationDelegate> {
    WKWebView *webView;
}
@end


@implementation LogList

+ (LogList *)shared {
    static LogList *sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[LogList alloc] initWithURL:LOG_SERVER];
    });

    return sharedObj;
}

- (instancetype)initWithURL:(NSString*)url {
    self = [super init];

    webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    });

    [self performSelector:@selector(clearList) withObject:nil afterDelay:2];

    return self;
}

- (void)clearList {
    NSString *msg = @"try { clearList(); } catch(e) {};";
    [webView evaluateJavaScript:msg completionHandler:^(id _Nullable data, NSError * _Nullable error){;}];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)log:(id)data {
    NSString *msg = @"NULL";
    if(data) {
        msg = [data description];
    }

    msg = [msg stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    msg = [NSString stringWithFormat:@"try { sendLog( \"%@\" ); } catch(e) {};", msg];
    [webView evaluateJavaScript:msg completionHandler:^(id _Nullable data, NSError * _Nullable error){;}];
}
#pragma clang diagnostic pop

@end
