//
//  CustomIntegerArray.m
//  Objc_Blocks_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//

#import "CustomIntegerArray.h"

@implementation CustomIntegerArray {
    NSMutableArray<NSNumber *> *_storage;
}

- (instancetype)initWithValues:(NSArray<NSNumber *> *)values {

    self = [super init];
    
    if (self) {
        _storage = [values mutableCopy] ?: [NSMutableArray array];
    }
    
    return self;
}

- (NSArray<NSNumber *> *)allValues {
    return [_storage copy];
}

- (CustomIntegerArray *)filter:(FilterPredicateBlock)block {
    
    NSMutableArray<NSNumber *> *result = [NSMutableArray array];
    
    for (NSNumber *number in _storage) {
        
        NSInteger value = [number integerValue];
        
        if (block(value)) {
            [result addObject:number];
        }
    }
    
    return [[CustomIntegerArray alloc] initWithValues:result];
}

- (NSInteger)reduce:(ReduceBlock)block withInitial:(NSInteger)initialValue {
    
    NSInteger result = initialValue;
    
    for (NSNumber *number in _storage) {
        
        NSInteger value = [number integerValue];
        
        result = block(result, value);
    }
    
    return result;
}

- (CustomIntegerArray *)sortedArrayUsingBlock:(SortComparisonBlock)block {
    
    NSMutableArray<NSNumber *> *result = [_storage mutableCopy];
    
    NSUInteger count = result.count;
    
    for (NSUInteger i = 0; i < count; i++) {
        
        for (NSUInteger j = i + 1; j < count; j++) {
            
            NSInteger firstValue = [result[i] integerValue];
            NSInteger secondValue = [result[j] integerValue];
            
            NSComparisonResult comparison =
                block(firstValue, secondValue);
            
            if (comparison == NSOrderedDescending) {
                
                NSNumber *temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }
    
    return [[CustomIntegerArray alloc] initWithValues:result];
}

- (void)forEach:(ForEachBlock)block {
    
    for (NSNumber *number in _storage) {
        
        NSInteger value = [number integerValue];
        
        block(value);
    }
}

- (NSString *)description {
    return [_storage description];
}

@end
