//
//  DataFetcher.m
//  Objc_Blocks_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//


#import "DataFetcher.h"

@implementation DataFetcher

- (void)fetchData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        
        NSData *data = [@"Sample Data" dataUsingEncoding:NSUTF8StringEncoding];
            
        if (self.completion) {
            self.completion(data, nil);
        }
    });
}

@end
