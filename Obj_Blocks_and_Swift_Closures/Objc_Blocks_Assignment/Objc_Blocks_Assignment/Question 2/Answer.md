
### Fixed Version

- (void)startDownload {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkClient fetchDataWithCompletion:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        
        if (!strongSelf) {
            return;
        }
        
        strongSelf.completionBlock = ^{
            [weakSelf updateUI];
        };
    }];
}

### Explanation

The memory leak occurs because DownloadViewController strongly retains completionBlock through its copy property, and 
the stored block strongly captures strongSelf, which refers to the same DownloadViewController instance. This creates 
a retain cycle: self → completionBlock → self, preventing the view controller from being deallocated.

The issue is fixed by capturing self weakly inside the stored completionBlock. The weak reference does not keep the 
view controller alive, so the retain cycle is broken.

The outer weakSelf/strongSelf pattern is not itself a problem. According to the assignment, fetchDataWithCompletion: 
calls its completion block once and does not store it. strongSelf is only used temporarily while the outer completion 
block is executing.
