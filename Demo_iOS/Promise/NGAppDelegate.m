//
//  NGAppDelegate.m
//  Promise
//
//  Created by James Womack on 6/7/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NGAppDelegate.h"
#import "NGPromise.h"

@implementation NGAppDelegate
{
    NSTimer *_timer;
    NSMutableArray *_colors;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    __block UIWebView *webView = [UIWebView.alloc initWithFrame:UIScreen.mainScreen.bounds];
    
    [[NGPromise make:^NSObject *{
        NSError *error;
        NSURL *URL = [NSURL URLWithString:@"http://google.com"];
        NSString *serverResponseString = [NSString stringWithContentsOfURL:URL
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:&error];
        return error ? error : serverResponseString;
    }] deliver:^(NSObject *result) {
        NSLog(@"%@", result);
        if ([result isKindOfClass:NSString.class])
        {
            [webView loadHTMLString:(NSString *)result baseURL:nil];
            [self.window.rootViewController.view addSubview:webView];
            webView = nil;
        }
    }];
    
    UIViewController *viewController = UIViewController.new;
    viewController.view.backgroundColor = UIColor.greenColor;
    
    self.window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    viewController = nil;
    
    _colors = @[UIColor.redColor,UIColor.blueColor,UIColor.orangeColor].mutableCopy;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2f target:self selector:@selector(iterateColors:) userInfo:nil repeats:YES];
    
    NSLog(@"%@",@"Made window key");
    
    return YES;
}

- (void)iterateColors:(NSTimer *)timer
{    
    if (_colors.count)
    {
        self.window.rootViewController.view.backgroundColor = _colors.lastObject;
        [self.window.rootViewController.view setNeedsDisplay];
        [_colors removeLastObject];
    }
    else
    {
        [_timer invalidate];
        _timer = nil;
        _colors = nil;
    }
}

@end
