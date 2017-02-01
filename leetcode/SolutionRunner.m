//
//  SolutionRunner.m
//  leetcode
//
//  Created by sodas on 2/1/17.
//  Copyright © 2017 sodastsai. All rights reserved.
//

#import "SolutionRunner.h"
#import <objc/runtime.h>

@implementation ExpectedResult

+ (instancetype)expectationWithArgs:(NSArray *)arguments andResult:(id)result {
    return [[self alloc] initWithArgs:arguments andResult:result];
}

- (instancetype)initWithArgs:(NSArray *)arguments andResult:(id)result {
    if (self = [super init]) {
        _arguments = [arguments copy];
        _expectedResult = result;
    }
    return self;
}

@end

@implementation SolutionRunner

- (instancetype)initWithSolutionClass:(Class)SolutionClass {
    if (self = [super init]) {
        _solutionClass = SolutionClass;
    }
    return self;
}

- (void)runWithExpectedResults:(NSArray<ExpectedResult *> *)expectedResults {
    for (ExpectedResult *expectedResult in expectedResults) {
        [self evaluateExpectedResult:expectedResult];
    }
}

- (void)evaluateExpectedResult:(ExpectedResult *)expectedResult {
    id solution = [[self.solutionClass alloc] init];
    id solutionReturnValue = [self runSolution:solution withArguments:expectedResult.arguments];
    if (expectedResult.expectedResult ?
        ([solutionReturnValue isEqual:expectedResult.expectedResult]) :
        (solutionReturnValue == expectedResult.expectedResult)) {
        return;
    }

    NSLog(@"%@ failed", self.solutionClass);
    NSLog(@"Arguments:");
    for (id arg in expectedResult.arguments) {
        NSLog(@"  - %@", arg);
    }
    NSLog(@"Expected: %@", expectedResult.expectedResult);
    NSLog(@"Got: %@", solutionReturnValue);
    NSLog(@"------------------------------------------------------------------");
}

#pragma mark - Invocation

- (id)runSolution:(id)solution withArguments:(NSArray *)arguments {
    NSInvocation *invocation = self.invocation;
    invocation.target = solution;
    invocation.selector = self.selector;

    [arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [invocation setArgument:&obj atIndex:idx+2];
    }];
    [invocation invoke];

    void *returnValue = NULL;
    [invocation getReturnValue:&returnValue];
    return (__bridge id)returnValue;
}

- (NSInvocation *)invocation {
    NSMethodSignature *methodSig = [self.solutionClass instanceMethodSignatureForSelector:self.selector];
    return [NSInvocation invocationWithMethodSignature:methodSig];
}

- (SEL)selector {
    if (_selector) {
        return _selector;
    }

    unsigned int metodCount = 0;
    Method * methodList = class_copyMethodList(self.solutionClass, &metodCount);
    NSMutableSet<NSString *> *selectorNames = [NSMutableSet setWithCapacity:metodCount];
    for (unsigned int i=0; i<metodCount; ++i) {
        NSString *selectorName = @(sel_getName(method_getName(methodList[i])));
        if ([selectorName hasPrefix:@"run"]) {
            [selectorNames addObject:selectorName];
        }
    }
    free(methodList), methodList = NULL;

    NSAssert(selectorNames.count == 1, @"Cannot get selector for running from %@", self.solutionClass);
    return _selector = NSSelectorFromString(selectorNames.anyObject);
}

@end
