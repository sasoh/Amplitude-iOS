//
//  Amplitude+Test.m
//  Amplitude
//
//  Created by Allan on 3/11/15.
//  Copyright (c) 2015 Amplitude. All rights reserved.
//

#import "PosemeshAmplitude.h"
#import "Amplitude+Test.h"
#import "PosemeshAMPDatabaseHelper.h"

@implementation PosemeshAmplitude (Test)

@dynamic backgroundQueue;
@dynamic initializerQueue;
@dynamic eventsData;
@dynamic initialized;
@dynamic sessionId;
@dynamic lastEventTime;
@dynamic backoffUpload;
@dynamic backoffUploadBatchSize;
@dynamic sslPinningEnabled;

- (void)flushQueue {
    [self flushQueueWithQueue:[self backgroundQueue]];
}

- (void)flushQueueWithQueue:(NSOperationQueue*) queue {
    [queue waitUntilAllOperationsAreFinished];
}

- (NSDictionary *)getEvent:(NSInteger) fromEnd {
    NSArray *events = [[PosemeshAMPDatabaseHelper getDatabaseHelper] getEvents:-1 limit:-1];
    return [events objectAtIndex:[events count] - fromEnd - 1];
}

- (NSDictionary *)getLastEventFromInstanceName:(NSString *)instanceName {
    NSArray *events = [[PosemeshAMPDatabaseHelper getDatabaseHelper: instanceName] getEvents:-1 limit:-1];
    return [events lastObject];
}

- (NSDictionary *)getLastEventFromInstanceName:(NSString *)instanceName fromEnd:(NSInteger)fromEnd {
    NSArray *events = [[PosemeshAMPDatabaseHelper getDatabaseHelper: instanceName] getEvents:-1 limit:-1];
    return [events objectAtIndex:[events count] - fromEnd - 1];
}

- (NSDictionary *)getLastEvent {
    NSArray *events = [[PosemeshAMPDatabaseHelper getDatabaseHelper] getEvents:-1 limit:-1];
    return [events lastObject];
}

- (NSDictionary *)getLastIdentify {
    NSArray *identifys = [[PosemeshAMPDatabaseHelper getDatabaseHelper] getIdentifys:-1 limit:-1];
    return [identifys lastObject];
}

- (NSDictionary *)getIdentify:(NSInteger) fromEnd {
    NSArray *identifys = [[PosemeshAMPDatabaseHelper getDatabaseHelper] getIdentifys:-1 limit:-1];
    return [identifys objectAtIndex:[identifys count] - fromEnd - 1];
}

- (NSDictionary *)getLastInterceptedIdentify {
    NSArray *interceptedIdentifys = [[PosemeshAMPDatabaseHelper getDatabaseHelper] getInterceptedIdentifys:-1 limit:-1];
    return [interceptedIdentifys lastObject];
}

- (NSUInteger)queuedEventCount {
    return [[PosemeshAMPDatabaseHelper getDatabaseHelper] getEventCount];
}

- (NSUInteger)queuedEventCountFromInstanceName:(NSString *)instanceName {
    return [[PosemeshAMPDatabaseHelper getDatabaseHelper: instanceName] getEventCount];
}

- (void)flushUploads:(void (^)(void))handler {
    [self performSelector:@selector(uploadEvents)];
    [self flushQueue];

    // Wait a second for the upload response to get into the queue.
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [self flushQueue];
        handler();
    });
}

@end

