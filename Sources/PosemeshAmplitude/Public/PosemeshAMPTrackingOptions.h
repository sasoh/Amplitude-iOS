//
//  AMPTrackingOptions.h
//  Copyright (c) 2018 Amplitude Inc. (https://amplitude.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/**
 Used with [Amplitude setTrackingOptions:] to disable individual fields.

    AMPTrackingOptions *options = [[[[AMPTrackingOptions options] disableCity] disableIPAddress] disablePlatform];
    [[Amplitude instance] setTrackingOptions:options];

*/
@interface PosemeshAMPTrackingOptions : NSObject

@property (nonatomic, strong, readonly) NSMutableSet *disabledFields;

- (PosemeshAMPTrackingOptions *)disableCarrier;
- (PosemeshAMPTrackingOptions *)disableCity;
- (PosemeshAMPTrackingOptions *)disableCountry;
- (PosemeshAMPTrackingOptions *)disableDeviceManufacturer;
- (PosemeshAMPTrackingOptions *)disableDeviceModel;
- (PosemeshAMPTrackingOptions *)disableDMA;
- (PosemeshAMPTrackingOptions *)disableIDFA;
- (PosemeshAMPTrackingOptions *)disableIDFV;
- (PosemeshAMPTrackingOptions *)disableIPAddress;
- (PosemeshAMPTrackingOptions *)disableLanguage;
- (PosemeshAMPTrackingOptions *)disableLatLng;
- (PosemeshAMPTrackingOptions *)disableOSName;
- (PosemeshAMPTrackingOptions *)disableOSVersion;
- (PosemeshAMPTrackingOptions *)disablePlatform;
- (PosemeshAMPTrackingOptions *)disableRegion;
- (PosemeshAMPTrackingOptions *)disableVersionName;

- (BOOL)shouldTrackCarrier;
- (BOOL)shouldTrackCity;
- (BOOL)shouldTrackCountry;
- (BOOL)shouldTrackDeviceManufacturer;
- (BOOL)shouldTrackDeviceModel;
- (BOOL)shouldTrackDMA;
- (BOOL)shouldTrackIDFA;
- (BOOL)shouldTrackIDFV;
- (BOOL)shouldTrackIPAddress;
- (BOOL)shouldTrackLanguage;
- (BOOL)shouldTrackLatLng;
- (BOOL)shouldTrackOSName;
- (BOOL)shouldTrackOSVersion;
- (BOOL)shouldTrackPlatform;
- (BOOL)shouldTrackRegion;
- (BOOL)shouldTrackVersionName;

- (NSMutableDictionary *)getApiPropertiesTrackingOption;
- (PosemeshAMPTrackingOptions *)mergeIn:(PosemeshAMPTrackingOptions *)options;
+ (instancetype)options;
+ (PosemeshAMPTrackingOptions *)forCoppaControl;
+ (PosemeshAMPTrackingOptions *)copyOf:(PosemeshAMPTrackingOptions *)origin;

@end
