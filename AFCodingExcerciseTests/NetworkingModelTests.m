//
//  NetworkingModelTests.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/31/16.
//  Copyright © 2016 Mounika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "NetworkingModel.h"
#import "Promotion.h"

@interface NetworkingModelTests : XCTestCase

@end

@implementation NetworkingModelTests {
    
    NetworkingModel *testModel;
    NSError *error;
    
    id partialTestModel;
    id mockError;
}

- (void)setUp {
    [super setUp];
    
    testModel = [NetworkingModel sharedInstance];
    partialTestModel = OCMPartialMock(testModel);
}

- (void)tearDown {
    
    [partialTestModel stopMocking];
    [mockError stopMocking];
    [super tearDown];
}

#pragma mark - Given

- (void)givenSuccessBlockReturnsPromotionsObjects {
    
    NSArray *testPromotions = [self givenTestPromotions];
    OCMStub([partialTestModel getPromotionsFromURL:OCMOCK_ANY
                                      successBlock:OCMOCK_ANY
                                      failureBlock:OCMOCK_ANY]).\
    andDo(^(NSInvocation *invocation)
          {
              __unsafe_unretained void (^successBlock)();
              [invocation getArgument:&successBlock atIndex:3];
              successBlock(testPromotions);
          });
}

- (void)givenFailureBlockReturnsError {
    
    error = [[NSError alloc] init];
    OCMStub([partialTestModel getPromotionsFromURL:OCMOCK_ANY
                                      successBlock:OCMOCK_ANY
                                      failureBlock:OCMOCK_ANY]).\
    andDo(^(NSInvocation *invocation)
          {
              __unsafe_unretained void (^failureBlock)();
              [invocation getArgument:&failureBlock atIndex:4];
              failureBlock(error);
          });
}

- (NSArray *)givenTestPromotions {
    
    NSMutableArray *promotions = [NSMutableArray array];
    for (NSInteger count = 0; count < 5; count ++) {
        
        NSString *title = [NSString stringWithFormat:@"Promotion %ld", (long)(count + 1)];
        Promotion *promotion = [[Promotion alloc] initWithDictionary:@{@"title":title}];
        [promotions addObject:promotion];
    }
    
    return promotions;
}

#pragma mark - Tests

- (void)test_sharedInstanceNotNil {
    
    XCTAssertNotNil(testModel);
}

- (void)testGetPromotionsFromURLSuccessBlockFailureBlock_OnSuccess_returnsPromotions {
    
    
    [self givenSuccessBlockReturnsPromotionsObjects];
    
    __block BOOL successBlockCalled = NO;
    __block NSArray *returnedPromotions = [NSArray array];
    
    [testModel getPromotionsFromURL:@"testURL.com"
                       successBlock:^(NSArray *promotions) {
                           successBlockCalled = YES;
                           returnedPromotions = promotions;
                       } failureBlock:^(NSError *error) {
                           XCTFail(@"Failure Block Should not be called");
                       }];
    
    XCTAssertTrue(successBlockCalled);
    XCTAssertTrue(returnedPromotions.count == 5);
}

- (void)testGetPromotionsFromURLSuccessBlockFailureBlock_OnFailure_returnsError {
    
    [self givenFailureBlockReturnsError];
    
    __block BOOL failureBlockCalled = NO;
    __block NSError *errorReturned = nil;
    [testModel getPromotionsFromURL:@"testURL.com"
                       successBlock:^(NSArray *promotions) {
                           XCTFail(@"Success Block should not be called");
                       } failureBlock:^(NSError *errorFromBlock) {
                           failureBlockCalled = YES;
                           errorReturned = errorFromBlock;
                       }];
    
    XCTAssertTrue(failureBlockCalled);
    XCTAssertNotNil(errorReturned);
}


@end
