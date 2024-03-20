//
//  ServerPlanUtilTests.m
//  Amplitude
//
//  Created by Qingzhuo Zhen on 10/20/21.
//  Copyright © 2021 Amplitude. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AMPServerZone.h"
#import "PosemeshAMPServerZoneUtil.h"
#import "AMPConstants.h"

@interface ServerZoneUtilTests : XCTestCase

@end

@implementation ServerZoneUtilTests { }

- (void) testGetEventLogApi {
    XCTAssertEqualObjects(kAMPEventLogUrl, [PosemeshAMPServerZoneUtil getEventLogApi:US]);
    XCTAssertEqualObjects(kAMPEventLogEuUrl, [PosemeshAMPServerZoneUtil getEventLogApi:EU]);
}

- (void) testGetDynamicConfigApi {
    XCTAssertEqualObjects(kAMPDyanmicConfigUrl, [PosemeshAMPServerZoneUtil getDynamicConfigApi:US]);
    XCTAssertEqualObjects(kAMPDyanmicConfigEuUrl, [PosemeshAMPServerZoneUtil getDynamicConfigApi:EU]);
}

@end
