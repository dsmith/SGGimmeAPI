//
//  SGTwitterClientTest.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/12/11.
//  Copyright 2011 SimpleGeo. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "SGTwitterClient.h"

@interface SGTwitterClientTest : GHAsyncTestCase {
 
    SGTwitterClient* client;
}

@end

@implementation SGTwitterClientTest

- (id) init
{

    self = [super init];
    if(self) {
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* path = [mainBundle pathForResource:@"credentials" ofType:@"plist"];
        NSDictionary* credentials = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"twitter"];
        client = [[SGTwitterClient alloc] initWithConsumerKey:[credentials objectForKey:@"consumer_key"]
                                               consumerSecret:[credentials objectForKey:@"consumer_secret"]
                                                  accessToken:[credentials objectForKey:@"access_token"]
                                                 accessSecret:[credentials objectForKey:@"access_secret"]];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Account
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)testVerifyCredentials
{
    [self prepare];
    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(verifyCredentialsDidSucceed:) 
                                              failureMethod:@selector(verifyCredentialsDidFail:)];
    [client verifyCredentials:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)verifyCredentialsDidSucceed:(NSDictionary* )response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testVerifyCredentials)];
}

- (void)verifyCredentialsDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testVerifyCredentials)];
}

- (void)testRateLimitStatus
{
    [self prepare];
    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(rateLimitStatusDidSucceed:)
                                              failureMethod:@selector(rateLImitStatusDidFail:)];
    [client rateLimitStatus:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)rateLimitStatusDidSucceed:(NSDictionary* )response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testRateLimitStatus)];
}

- (void)rateLImitStatusDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testRateLimitStatus)];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Timeline
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)testHomeTimeline
{
    [self prepare];
    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(homeTimelineDidSucceed:)
                                              failureMethod:@selector(homeTimelineDidFail:)];
    [client homeTimeline:nil callback:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)homeTimelineDidSucceed:(NSDictionary *)response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testHomeTimeline)];
}

- (void)homeTimelineDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testHomeTimeline)];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tweets
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)testUpdateStatus
{
    [self prepare];
    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(updateStatusDidSucceed:)
                                              failureMethod:@selector(updateStatusDidFail:)];

    // Use timestamp here because twitter is smart about not updating the same
    // status twice
    [client updateStatus:[NSString stringWithFormat:@"Stop looking at me swan %f", [[NSDate date] timeIntervalSince1970]]
               options:nil
              callback:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)updateStatusDidSucceed:(NSDictionary *)response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testUpdateStatus)];
}

- (void)updateStatusDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testUpdateStatus)];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Messages
////////////////////////////////////////////////////////////////////////////////////////////////

- (void) testNewDirectMessage
{
    [self prepare];
    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(newDirectMessageDidSucceed:)
                                              failureMethod:@selector(newDirectMessageDidFail:)];
    [client newDirectMessage:[NSString stringWithFormat:@"Stop looking at me swan %f", [[NSDate date] timeIntervalSince1970]]
                      toUser:nil
                     options:[NSDictionary dictionaryWithObject:@"caseycrites" forKey:@"screen_name"]
                    callback:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)newDirectMessageDidSucceed:(NSDictionary *)response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testNewDirectMessage)];
}

- (void)newDirectMessageDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testNewDirectMessage)];
}

@end
