//
//  MiddlewareRunnerTests.m
//  Amplitude
//
//  Created by Qingzhuo Zhen on 10/24/21.
//  Copyright © 2021 Amplitude. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AMPMiddleware.h"
#import "PosemeshAMPMiddlewareRunner.h"

@interface MiddlewareRunnerTests : XCTestCase

@property PosemeshAMPMiddlewareRunner *middlewareRunner;

@end


@implementation MiddlewareRunnerTests

- (void)setUp {
    _middlewareRunner = [PosemeshAMPMiddlewareRunner middleRunner];
}

- (void)tearDown {
    _middlewareRunner = nil;
}

- (void)testMiddlewareRun {
    NSString *eventType = @"middleware event";
    PosemeshAMPBlockMiddleware *updateEventTypeMiddleware = [[PosemeshAMPBlockMiddleware alloc] initWithBlock: ^(PosemeshAMPMiddlewarePayload * _Nonnull payload, AMPMiddlewareNext _Nonnull next) {
        [payload.event setValue:eventType forKey:@"event_type"];
        next(payload);
    }];
    NSString *deviceModel = @"middleware_device";
    PosemeshAMPBlockMiddleware *updateDeviceModelMiddleware = [[PosemeshAMPBlockMiddleware alloc] initWithBlock: ^(PosemeshAMPMiddlewarePayload * _Nonnull payload, AMPMiddlewareNext _Nonnull next) {
        [payload.event setValue:deviceModel forKey:@"device_model"];
        next(payload);
    }];
    [_middlewareRunner add:updateEventTypeMiddleware];
    [_middlewareRunner add:updateDeviceModelMiddleware];
    
    NSMutableDictionary *event = [NSMutableDictionary dictionary];
    [event setValue:@"sample_event" forKey:@"event_type"];
    [event setValue:@"sample_device" forKey:@"device_model"];
    NSMutableDictionary *extra = [NSMutableDictionary dictionary];
    
    PosemeshAMPMiddlewarePayload * middlewarePayload = [[PosemeshAMPMiddlewarePayload alloc] initWithEvent:event withExtra:extra];
    
    __block BOOL middlewareCompleted = NO;
    
    [_middlewareRunner run:middlewarePayload next:^(PosemeshAMPMiddlewarePayload *_Nullable newPayload){
        middlewareCompleted = YES;
    }];
    
    XCTAssertEqual(middlewareCompleted, YES);
    XCTAssertEqualObjects([event objectForKey:@"event_type"], eventType);
    XCTAssertEqualObjects([event objectForKey:@"device_model"], deviceModel);
}

- (void)testRunWithNotPassMiddleware {
    NSString *eventType = @"middleware event";
    PosemeshAMPBlockMiddleware *updateEventTypeMiddleware = [[PosemeshAMPBlockMiddleware alloc] initWithBlock: ^(PosemeshAMPMiddlewarePayload * _Nonnull payload, AMPMiddlewareNext _Nonnull next) {
        [payload.event setValue:eventType forKey:@"event_type"];
        next(payload);
    }];
    PosemeshAMPBlockMiddleware *swallowMiddleware = [[PosemeshAMPBlockMiddleware alloc] initWithBlock: ^(PosemeshAMPMiddlewarePayload * _Nonnull payload, AMPMiddlewareNext _Nonnull next) {
    }];
    [_middlewareRunner add:updateEventTypeMiddleware];
    [_middlewareRunner add:swallowMiddleware];
    
    NSMutableDictionary *event = [NSMutableDictionary dictionary];
    [event setValue:@"sample_event" forKey:@"event_type"];
    [event setValue:@"sample_device" forKey:@"device_model"];
    NSMutableDictionary *extra = [NSMutableDictionary dictionary];
    
    PosemeshAMPMiddlewarePayload * middlewarePayload = [[PosemeshAMPMiddlewarePayload alloc] initWithEvent:event withExtra:extra];
    
    __block BOOL middlewareCompleted = NO;
    
    [_middlewareRunner run:middlewarePayload next:^(PosemeshAMPMiddlewarePayload *_Nullable newPayload){
        middlewareCompleted = YES;
    }];
    
    XCTAssertEqual(middlewareCompleted, NO);
    XCTAssertEqualObjects([event objectForKey:@"event_type"], eventType);
}

@end
