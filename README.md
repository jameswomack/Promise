# NGPromise
# The drop-dead easiest Objective-C Promise class in the West... hand-crafted in San Diego, Ca.

## Example:
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

As you can see, you pass a block that performs a syncronous operation that'd normally block your UI thread (a bad thing™), and return the result of said operation. While that is executing, you can go about your business. NGPromise executes your code on a background thread. When that operation completes, NGPromise calls the block you passed to the deliver parameter, with the result of your operation. This call is made on the main thread and can perform UI operations. NGPromise achieves all this in the least amount of code possible, so as not to bog down your important project.
