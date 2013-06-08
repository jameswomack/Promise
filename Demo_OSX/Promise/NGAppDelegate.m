//
//  NGAppDelegate.m
//  Promise
//
//  Created by James Womack on 6/8/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NGAppDelegate.h"
#import "NGPromise.h"

@implementation NGAppDelegate
{
    NSTimer *_timer;
    NSMutableArray *_colors;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.webView.drawsBackground = NO;
    
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
            [self.webView.mainFrame loadHTMLString:(NSString *)result baseURL:nil];
        }
    }];
    
    _colors = @[NSColor.purpleColor,NSColor.blueColor,NSColor.orangeColor].mutableCopy;
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(iterateColors:) userInfo:nil repeats:YES];
    
    NSLog(@"%@",@"Finished launching");
}

- (void)iterateColors:(NSTimer *)timer
{    
    if(_colors.count)
    {
        self.window.backgroundColor = _colors.lastObject;
        
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
