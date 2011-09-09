//
//  SGFoursquareClientTest.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/14/11.
//  Copyright 2011 Dsmitts. All rights reserved.
//

#import <GHUnitiOS/GHUnit.h>

#import "SGFoursquareClient.h"

@interface SGFoursquareClientTest : GHAsyncTestCase {

    SGFoursquareClient* client;
}

@end

@implementation SGFoursquareClientTest

- (id) init
{
    self = [super init];
    if(self) {
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* path = [mainBundle pathForResource:@"credentials" ofType:@"plist"];
        NSDictionary* credentials = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"foursquare"];
        client = [[SGFoursquareClient alloc] initWithAccessToken:[credentials objectForKey:@"access_token"]];
    }

    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark User
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)testUserLeaderboard
{
    [self prepare];

    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(userLeaderboardDidSucceed:)
                                              failureMethod:@selector(userLeaderboardDidFail:)];
    [client userLeaderboard:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)userLeaderboardDidSucceed:(NSDictionary *)response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testUserLeaderboard)];
}

- (void)userLeaderboardDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testUserLeaderboard)];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Check in
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)testRecentCheckin
{
    [self prepare];
    SGCallback *callback = [SGCallback callbackWithDelegate:self
                                              successMethod:@selector(recentCheckinDidSucceed:)
                                              failureMethod:@selector(recentCheckinDidFail:)];
    [client recentCheckins:nil callback:callback];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void)recentCheckinDidSucceed:(NSDictionary *)response
{
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testRecentCheckin)];
}

- (void)recentCheckinDidFail:(NSError *)error
{
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testRecentCheckin)];
}


@end
