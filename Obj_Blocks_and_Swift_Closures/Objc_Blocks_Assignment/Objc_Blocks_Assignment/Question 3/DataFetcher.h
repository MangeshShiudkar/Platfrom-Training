//
//  DataFetcher.h
//  Objc_Blocks_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//


#import <Foundation/Foundation.h>

typedef void (^FetchDataCompletion)(
    NSData * _Nullable data,
    NSError * _Nullable error
);

@interface DataFetcher : NSObject

// Blocks should be copy because a block may initially be on the stack.
// copy moves/copies it to the heap so it can safely be stored and used later.
@property (nonatomic, copy, nullable) FetchDataCompletion completion;

- (void)fetchData;

@end
