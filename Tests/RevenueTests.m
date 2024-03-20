//
//  RevenueTests.m
//  Amplitude
//
//  Created by Daniel Jih on 04/18/16.
//  Copyright © 2016 Amplitude. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AMPRevenue.h"
#import "AMPConstants.h"

@interface RevenueTests : XCTestCase

@end

@implementation RevenueTests { }

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testProductId {
    PosemeshAMPRevenue *revenue = [PosemeshAMPRevenue revenue];
    XCTAssertNil(revenue.productId);

    NSString *productId = @"testProductId";
    [revenue setProductIdentifier:productId];
    XCTAssertEqualObjects(revenue.productId, productId);

    // test that ignore empty inputs
    [revenue setProductIdentifier:nil];
    XCTAssertEqualObjects(revenue.productId, productId);
    [revenue setProductIdentifier:@""];
    XCTAssertEqualObjects(revenue.productId, productId);

    NSDictionary *dict = [revenue toNSDictionary];
    XCTAssertEqualObjects([dict objectForKey:@"$productId"], productId);
}

- (void)testQuantity {
    PosemeshAMPRevenue *revenue = [PosemeshAMPRevenue revenue];
    XCTAssertEqual(revenue.quantity, 1);

    NSInteger quantity = 100;
    [revenue setQuantity:quantity];
    XCTAssertEqual(revenue.quantity, quantity);

    NSDictionary *dict = [revenue toNSDictionary];
    XCTAssertEqualObjects([dict objectForKey:@"$quantity"], [NSNumber numberWithInteger:quantity]);
}

- (void)testPrice {
    PosemeshAMPRevenue *revenue = [PosemeshAMPRevenue revenue];
    XCTAssertNil(revenue.price);

    NSNumber *price = [NSNumber numberWithDouble:10.99];
    [revenue setPrice:price];
    XCTAssertEqualObjects(revenue.price, price);

    NSDictionary *dict = [revenue toNSDictionary];
    XCTAssertEqualObjects([dict objectForKey:@"$price"], price);
}

- (void)testRevenueType {
    PosemeshAMPRevenue *revenue = [PosemeshAMPRevenue revenue];
    XCTAssertNil(revenue.revenueType);

    NSString *revenueType = @"testRevenueType";
    [revenue setRevenueType:revenueType];
    XCTAssertEqualObjects(revenue.revenueType, revenueType);

    // verify that null and empty strings allowed
    [revenue setRevenueType:nil];
    XCTAssertNil(revenue.revenueType);
    [revenue setRevenueType:@""];
    XCTAssertEqualObjects(revenue.revenueType, @"");

    [revenue setRevenueType:revenueType];
    XCTAssertEqualObjects(revenue.revenueType, revenueType);

    NSDictionary *dict = [revenue toNSDictionary];
    XCTAssertEqualObjects([dict objectForKey:@"$revenueType"], revenueType);
}

- (void)testRevenueProperties {
    PosemeshAMPRevenue *revenue = [PosemeshAMPRevenue revenue];
    XCTAssertNil(revenue.properties);

    NSDictionary *props = [NSDictionary dictionaryWithObject:@"Boston" forKey:@"city"];
    [revenue setEventProperties:props];
    XCTAssertEqualObjects(revenue.properties, props);

    NSDictionary *dict = [revenue toNSDictionary];
    XCTAssertEqualObjects([dict objectForKey:@"city"], @"Boston");
    XCTAssertEqualObjects([dict objectForKey:@"$quantity"], [NSNumber numberWithInt:1]);

    // assert original dict was not modified
    XCTAssertNil([props objectForKey:@"$quantity"]);
}

- (void)testValidRevenue {
    PosemeshAMPRevenue *revenue = [PosemeshAMPRevenue revenue];
    XCTAssertFalse([revenue isValidRevenue]);
    [revenue setProductIdentifier:@"testProductId"];
    XCTAssertFalse([revenue isValidRevenue]);
    [revenue setPrice:[NSNumber numberWithDouble:10.99]];
    XCTAssertTrue([revenue isValidRevenue]);

    PosemeshAMPRevenue *revenue2 = [PosemeshAMPRevenue revenue];
    XCTAssertFalse([revenue2 isValidRevenue]);
    [revenue2 setPrice:[NSNumber numberWithDouble:10.99]];
    [revenue2 setQuantity:10];
    XCTAssertTrue([revenue2 isValidRevenue]);
    [revenue2 setProductIdentifier:@"testProductId"];
    XCTAssertTrue([revenue2 isValidRevenue]);
}

- (void)testToNSDictionary {
    NSNumber *price = [NSNumber numberWithDouble:15.99];
    NSInteger quantity = 15;
    NSString *productId = @"testProductId";
    NSString *revenueType = @"testRevenueType";
    NSDictionary *props = [NSDictionary dictionaryWithObject:@"San Francisco" forKey:@"city"];

    PosemeshAMPRevenue *revenue = [[[[PosemeshAMPRevenue revenue] setProductIdentifier:productId] setPrice:price] setQuantity:quantity];
    [[revenue setRevenueType:revenueType] setEventProperties:props];

    NSDictionary *dict = [revenue toNSDictionary];
    XCTAssertEqualObjects([dict objectForKey:@"$productId"], productId);
    XCTAssertEqualObjects([dict objectForKey:@"$price"], price);
    XCTAssertEqualObjects([dict objectForKey:@"$quantity"], [NSNumber numberWithInteger:quantity]);
    XCTAssertEqualObjects([dict objectForKey:@"$revenueType"], revenueType);
    XCTAssertEqualObjects([dict objectForKey:@"city"], @"San Francisco");
}

@end
