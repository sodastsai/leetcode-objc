//
//  main.m
//  p283-move-zeroes
//
//  Created by sodas on 2/1/17.
//  Copyright © 2017 sodastsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SolutionRunner.h"

@interface MoveZeroes : NSObject

@end

@implementation MoveZeroes

- (NSArray *)run:(NSArray<NSNumber *> *)input {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:input.count];
    for (NSNumber *number in input) {
        if (number.integerValue) {
            [result addObject:number];
        }
    }
    while (result.count < input.count) {
        [result addObject:@0];
    }
    return [result copy];
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SolutionRunner *runner = [[SolutionRunner alloc] initWithSolutionClass:MoveZeroes.class];
        [runner runWithExpectedResults:@[
            [ExpectedResult expectationWithArgs:@[@[@1, @0, @2, @0, @1, @0, @3]]
                                      andResult:@[@1, @2, @1, @3, @0, @0, @0]],
            [ExpectedResult expectationWithArgs:@[@[@0, @0, @2, @0, @3, @0]] andResult:@[@2, @3, @0, @0, @0, @0]],
            [ExpectedResult expectationWithArgs:@[@[@1, @2, @3]] andResult:@[@1, @2, @3]],
            [ExpectedResult expectationWithArgs:@[@[@0, @0, @0]] andResult:@[@0, @0, @0]],
        ]];
    }
    return 0;
}
