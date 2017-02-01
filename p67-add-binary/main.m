//
//  main.m
//  p67-add-binary
//
//  Created by sodas on 2/1/17.
//  Copyright © 2017 sodastsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SolutionRunner.h"

@interface AddBinary: NSObject

- (NSString *)run_addBinary:(NSString *)a with:(NSString *)b;

@end

@implementation AddBinary

#define ASCII_ZERO 48

- (NSUInteger)unsignedIntegerFromBinaryString:(NSString *)input {
    NSUInteger result = 0;
    for (NSUInteger i=0; i<input.length; ++i) {
        result += ([input characterAtIndex:i] - ASCII_ZERO) * pow(2, input.length - i - 1);
    }
    return result;
}

- (NSString *)binaryStringFromInteger:(NSInteger)input {
    if (!input) { return @"0"; }
    NSMutableString *result = [NSMutableString stringWithCapacity:ceil(log2(input)) + 1];
    NSInteger number = input;
    while (number) {
        [result insertString:@(number % 2).stringValue atIndex:0];
        number /= 2;
    }
    return [result copy];
}

- (NSString *)run_addBinary:(NSString *)a with:(NSString *)b {
    NSUInteger result = [self unsignedIntegerFromBinaryString:a] + [self unsignedIntegerFromBinaryString:b];
    return [self binaryStringFromInteger:result];
}

@end

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SolutionRunner *runner = [[SolutionRunner alloc] initWithSolutionClass:AddBinary.class];
        [runner runWithExpectedResults:@[
            [ExpectedResult expectationWithArgs:@[@"0", @"0"] andResult:@"0"],
            [ExpectedResult expectationWithArgs:@[@"1", @"0"] andResult:@"1"],
            [ExpectedResult expectationWithArgs:@[@"1", @"1"] andResult:@"10"],
            [ExpectedResult expectationWithArgs:@[@"1010", @"1011"] andResult:@"10101"],
        ]];
    }
    return 0;
}
