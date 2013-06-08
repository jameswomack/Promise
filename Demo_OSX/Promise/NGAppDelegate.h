//
//  NGAppDelegate.h
//  Promise
//
//  Created by James Womack on 6/8/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface NGAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet WebView *webView;

@end
