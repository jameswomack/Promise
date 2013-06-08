//
//  NGPromise.m
//  Promise
//
//  Created by James Womack on 6/7/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NGPromise.h"

@implementation NGPromise
{
    NGPromiseBlock _deliver;
    NGOperationBlock _operationBlock;
    dispatch_queue_t _backgroundQueue;
}

+ (NGPromise *)make:(NGOperationBlock)operationBlock
{
    NGPromise *promise = NGPromise.new;
    promise->_operationBlock = operationBlock;
    return promise;
}

- (void)deliver:(NGPromiseBlock)deliver
{
    _deliver = deliver;
    _backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(_backgroundQueue, ^{
        [self perform];
    });
}

- (void)perform
{
    __block NGPromise *promise = self;
    NSObject *operationResult = _operationBlock();
    dispatch_async(dispatch_get_main_queue(), ^{
        _deliver(operationResult);
        dispatch_async(_backgroundQueue, ^{
            promise = nil;
        });
    });
}


@end
