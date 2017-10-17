//
//  PromotionsCellsTests.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/31/16.
//  Copyright © 2016 mounika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h> 

#import "Promotion.h"
#import "PromotionsCell.h"
#import "PromotionsController.h"

@interface PromotionsCell()
- (void)setupPromotionImageForPromoiton:(Promotion *)promotion;
@end

@interface PromotionsCellsTests : XCTestCase

@end

@implementation PromotionsCellsTests {
    
    Promotion *testPromotion;
    PromotionsCell *cell;
    
    id mockCell;
    id mockData;
    id mockImage;
    id mockImageView;
}

- (void)setUp {
    [super setUp];
    [self givenPromitionCell];
}

- (void)tearDown {
    
    [mockCell stopMocking];
    [mockData stopMocking];
    [mockImage stopMocking];
    [mockImageView stopMocking];
    [super tearDown];
}

#pragma mark - Given

- (void)givenMockCell {
    
    mockCell = OCMClassMock([PromotionsCell class)];
}

- (void)givenMockData {
    
    mockData = OCMClassMock([NSData class]);
    OCMStub([mockData dataWithContentsOfURL:OCMOCK_ANY]).andReturn(mockData);
}

- (void)givenMockImage {
    
    mockImage = OCMClassMock([UIImage class]);
    OCMStub([mockImage imageWithData:OCMOCK_ANY]).andReturn(mockImage);
}
                            
- (void)givenMockImageView {
     
    mockImageView = OCMClassMock([UIImageView class]);
    cell.promotionImage = mockImageView;
}

- (void)givenPromitionCell {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    PromotionsController *controller = [storyboard instantiateViewControllerWithIdentifier:@"PromotionsController"];
    [controller view];
    
    cell = [controller.tableView dequeueReusableCellWithIdentifier:@"PromotionsCell"];
}

- (void)givenTestPromotion {
    
    testPromotion = [[Promotion alloc] initWithDictionary:@{@"title":@"Test Promotion",
                                                            @"image":@"http://testImageUrl.com"}];
}

#pragma mark - Tests

- (void)test_configureCellWithPromotion_setsTitle {
    
    [self givenTestPromotion];
    [self givenMockCell];
    OCMStub([mockCell setupPromotionImageForPromoiton:OCMOCK_ANY]).andDo(nil);
    
    [cell configureCellWithPromotion:testPromotion];
    
    XCTAssertEqualObjects(@"Test Promotion", cell.promotionTitle.text);
}

//- (void)test_configureCellWithPromotion_setsPromotionImage {
//    
//    [self givenTestPromotion];
//    [self givenMockData];
//    [self givenMockImage];
//    [self givenMockImageView];
//    
//    [cell configureCellWithPromotion:testPromotion];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:@"Set Promotoin Image"];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        XCTAssertNotNil(cell.promotionImage.image);
//        XCTAssertEqualObjects(cell.promotionImage.image, mockImage);
//        [expectation fulfill];
//    });
//    [self waitForExpectationsWithTimeout:100 handler:nil];
//}

@end
