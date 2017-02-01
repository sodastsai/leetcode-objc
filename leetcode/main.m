//
//  main.m
//  leetcode
//
//  Created by sodas on 2/1/17.
//  Copyright © 2017 sodastsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SolutionRunner.h"

@interface HappyLeetCode : NSObject

@end

@implementation HappyLeetCode

- (NSNumber *)runWithValue1:(NSNumber *)a andValue2:(NSNumber *)b {
    return @(a.integerValue * b.integerValue);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SolutionRunner *runner = [[SolutionRunner alloc] initWithSolutionClass:HappyLeetCode.class];
        [runner runWithExpectedResults:@[
            [ExpectedResult expectationWithArgs:@[@6, @7] andResult:@42],
        ]];
    }
    return 0;
}
