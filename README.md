# NGPromise
## The drop-dead easiest Promise class in the West :cactus:

Hand-crafted in [San Diego, Ca](http://en.wikipedia.org/wiki/North_Park,_San_Diego). :sailboat:

## Raison d'etre

In looking through the existing promise-like classes available via Github I felt they all overcomplicated the process by focusing on adherence to the JavaScript specification(s). IMHO the focus rather should be on **ease-of-use for developers** and to simply `make:` a "promise" to perform a task in a non-blocking fashion and `deliver:` on the promise **returning the result as soon as the task has come to completion**.

## Documentation
Documentation for Promise is available [here](http://nblgstr.com/promise/).

## Example :point_down:
```
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
```

As you can see, you pass a block that performs a synchronous operation that'd normally block your UI thread (a bad thing™), and return the result of said operation. While that is executing, you can go about your business. NGPromise executes your code on a background thread. When that operation completes, NGPromise calls the block you passed to the deliver parameter, with the result of your operation. This call is made on the main thread and can perform UI operations. NGPromise achieves all this in the least amount of code possible, so as not to bog down your important project.

## Demos :point_down:

From the demos provided you can see how an NGPromise can load HTML from a URL synchronously while other UI operations (background colors in the demos) are being carried on. This enables you to take advantage of the cleanliness and simplicity of synchronous Cocoa APIs without locking up the UI.

There is a demo of this Promise class for iOS:

![Promise Demo—iOS Code](https://dl.dropboxusercontent.com/u/1925537/promise-demo_iOS_code.png)
![Promise Demo—iOS Device](https://dl.dropboxusercontent.com/u/1925537/promise-demo_iOS_device.png)

And a demo of the Promise class for Mac OS X:

![Promise Demo—OSX Code](https://dl.dropboxusercontent.com/u/1925537/promise-demo_OSX_code.png)
![Promise Demo—OSX Window](https://dl.dropboxusercontent.com/u/1925537/promise-demo_OSX_window.png)

Objective-C Promise Framework | Promise OS X | Promise iOS | Promise Class for iPhone | Promise Class for iPad | Simple Promises API
