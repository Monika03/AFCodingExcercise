//
//  PromotionsTests.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/31/16.
//  Copyright © 2016 mounika. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Promotion.h"

@interface PromotionsTests : XCTestCase

@end

@implementation PromotionsTests {
    
    Promotion *testPromotion;
}

- (void)setUp {
    [super setUp];
    
    NSDictionary *rawDictionary = [self givenRawDictionary];
    testPromotion = [[Promotion alloc] initWithDictionary:rawDictionary];
}

#pragma mark - Given

- (NSDictionary *)givenRawDictionary {
    
    return @{ @"button": @{@"target": @"https://m.abercrombie.com",
                           @"title": @"Shop Now"
                           },
              @"description": @"GET READY FOR SUMMER DAYS",
              @"footer": @"In stores & online. Exclusions apply. <a href=\"https://www.abercrombie.com/anf/media/legalText/viewDetailsText20150618_Shorts25_US.html\" class=\"legal promo-details\">See details</a>",
              @"image": @"http://anf.scene7.com/is/image/anf/anf-US-20150629-app-women-shorts",
              @"title": @"Shorts Starting at $25"
        };
}

#pragma mark - Tests

- (void)test_initWithDictionary_setsProperties {
    
    XCTAssertEqualObjects(testPromotion.imageURL, @"http://anf.scene7.com/is/image/anf/anf-US-20150629-app-women-shorts");
    XCTAssertEqualObjects(testPromotion.title, @"Shorts Starting at $25");
    XCTAssertEqualObjects(testPromotion.promotionDescription, @"GET READY FOR SUMMER DAYS");
    XCTAssertEqualObjects(testPromotion.promotionFooterText, @"In stores & online. Exclusions apply. <a href=\"https://www.abercrombie.com/anf/media/legalText/viewDetailsText20150618_Shorts25_US.html\" class=\"legal promo-details\">See details</a>");
    
    XCTAssertNotNil(testPromotion.promotionsShopNowButtonModel);
}

@end
