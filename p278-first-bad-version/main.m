//
//  main.m
//  p278-first-bad-version
//
//  Created by sodas on 2/1/17.
//  Copyright © 2017 sodastsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SolutionRunner.h"

@interface FirstBadVersion : NSObject

@end

@implementation FirstBadVersion

- (NSInteger)_findAndCheckFromVersion:(NSInteger)startVer
                            toVersion:(NSInteger)endVer
                              checker:(BOOL(^)(NSNumber *))isBadVersion {
    NSInteger checkVer = (startVer - endVer)/2 + startVer;
    if (isBadVersion(@(checkVer))) {
        return checkVer == startVer ? checkVer : [self _findAndCheckFromVersion:startVer
                                                                      toVersion:checkVer-1
                                                                        checker:isBadVersion];
    } else {
        return checkVer == endVer ? 0 : [self _findAndCheckFromVersion:checkVer+1
                                                             toVersion:endVer
                                                               checker:isBadVersion];
    }
}

- (NSNumber *)run_findFirstBadVersion:(NSNumber *)version checker:(BOOL(^)(NSNumber *))isBadVersion {
    return @([self _findAndCheckFromVersion:1 toVersion:version.integerValue checker:isBadVersion]);
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SolutionRunner *runner = [[SolutionRunner alloc] initWithSolutionClass:FirstBadVersion.class];
        [runner runWithExpectedResults:@[
            [ExpectedResult expectationWithArgs:@[@1, ^BOOL(NSNumber *version){return NO;}] andResult:@0],
            [ExpectedResult expectationWithArgs:@[@2, ^BOOL(NSNumber *version){return version.integerValue >= 1;}]
                                      andResult:@1],
            [ExpectedResult expectationWithArgs:@[@1, ^BOOL(NSNumber *version){return version.integerValue >= 1;}]
                                      andResult:@1],
            [ExpectedResult expectationWithArgs:@[@2, ^BOOL(NSNumber *version){return version.integerValue >= 2;}]
                                      andResult:@2],
        ]];
    }
    return 0;
}
