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
    
    [self iterateColors];
    
    viewController = nil;
    
    NSLog(@"%@",@"Made window key");
    
    return YES;
}

- (void)iterateColors
{
    NSMutableArray *colors = @[UIColor.redColor,UIColor.blueColor,UIColor.orangeColor].mutableCopy;
    
    while (colors.count)
    {
        self.window.rootViewController.view.backgroundColor = colors.lastObject;
        [self.window.rootViewController.view setNeedsDisplay];
        [colors removeLastObject];
    }
}

@end
