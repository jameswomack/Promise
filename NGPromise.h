//
//  NGPromise.h
//  Promise
//
//  Created by James Womack on 6/7/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NGPromiseBlock)(NSObject *result);
typedef NSObject*(^NGOperationBlock)(void);


@interface NGPromise : NSObject

+ (NGPromise *)make:(NGOperationBlock)operationBlock;

- (void)deliver:(NGPromiseBlock)deliver;


@end
