//
//  CustomIntegerArray.h
//  Objc_Blocks_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//

#import <Foundation/Foundation.h>

typedef BOOL (^FilterPredicateBlock)(NSInteger value);

typedef NSInteger (^ReduceBlock)(NSInteger partial, NSInteger value);

typedef NSComparisonResult (^SortComparisonBlock)(NSInteger a, NSInteger b);

typedef void (^ForEachBlock)(NSInteger value);


@interface CustomIntegerArray : NSObject

- (instancetype)initWithValues:(NSArray<NSNumber *> *)values NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;


- (CustomIntegerArray *)filter:(FilterPredicateBlock)block;

- (NSInteger)reduce:(ReduceBlock)block withInitial:(NSInteger)initialValue;

- (CustomIntegerArray *)sortedArrayUsingBlock:(SortComparisonBlock)block;

- (void)forEach:(ForEachBlock)block;

- (NSArray<NSNumber *> *)allValues;

@end
