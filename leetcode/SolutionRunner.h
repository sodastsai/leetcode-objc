//
//  SolutionRunner.h
//  leetcode
//
//  Created by sodas on 2/1/17.
//  Copyright © 2017 sodastsai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpectedResult : NSObject

@property (nonatomic, nullable, readonly) NSArray *arguments;
@property (nonatomic, nullable, readonly) id expectedResult;

+ (instancetype)expectationWithArgs:(NSArray * _Nullable)arguments andResult:(id _Nullable)result;
- (instancetype)initWithArgs:(NSArray * _Nullable)arguments andResult:(id _Nullable)result;

@end

@interface SolutionRunner : NSObject

@property (nonatomic, readonly) Class solutionClass;
@property (nonatomic) SEL selector;

- (instancetype)initWithSolutionClass:(Class)SolutionClass;

- (void)runWithExpectedResults:(NSArray<ExpectedResult *> *)expectedResults;

@end

NS_ASSUME_NONNULL_END
