//
//  NGPromise.h
//  Promise
//
//  Created by James Womack on 6/7/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//  Created using  Xcode Version 4.6.2 (4H1003)
//  Comments formatted for appledoc 2.1 (build 840)
//

#import <Foundation/Foundation.h>

typedef void(^NGPromiseBlock)(NSObject *result);
typedef NSObject*(^NGOperationBlock)(void);

/**
 The Promise class. Has one class public class method (make:) and one public instance method (deliver:).
 Combined they comprise the entire accessible functionality of this simple but powerful class.
*/
@interface NGPromise : NSObject

/**---------------------------------------------------------------------------------------
 * @name Initialization and essential methods
 *  ---------------------------------------------------------------------------------------
 */

/** The Promise initializer factory class method.
 
Initialize with an NGOperationBlock.
When operationBlock completes, its value will be passed to the NGPromiseBlock via deliver:.

 @param operationBlock The block that will be executed in the background.
 @return An NGPromise pointer.
 @see deliver:
 @warning *Warning:* operationBlock cannot be nil.
*/
+ (NGPromise *)make:(NGOperationBlock)operationBlock;


/** The Promise delivery instance method.
 
Pass an NGPromiseBlock.
 deliverBlock will be executed on the main thread.
 
 @param deliverBlock The block that will be executed when operationBlock completes.
 @return void.
 @see make:
 @warning *Warning:* deliverBlock cannot be nil.
*/
- (void)deliver:(NGPromiseBlock)deliverBlock;


@end
