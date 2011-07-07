//
//  SGFoursquareClient.h
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 CrashCorp. All rights reserved.
//

#import "SGHTTPClient.h"

#import <CoreLocation/CoreLocation.h>

@interface SGFoursquareClient : SGHTTPClient {
    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Geo methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)activeCitiesCallback:(SGCallback *)callback;
- (void)closestCityToCoordinate:(CLLocationCoordinate2D)coordinate cityId:(NSString*)cityId callback:(SGCallback *)callback;
- (void)updateDefaultCity:(NSString *)cityId callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Check in methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)checkIns:(NSString *)cityId callback:(SGCallback*)callback;
- (void)shoutMessage:(NSString *)message coordinate:(CLLocationCoordinate2D)coordinate twitter:(BOOL)enabled callback:(SGCallback *)callback;
- (void)checkIntoVenue:(NSString*)venueId coordinate:(CLLocationCoordinate2D)coordinate callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark User methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)userInformation:(NSString *)userId badges:(BOOL)badges mayor:(BOOL)mayor callback:(SGCallback *)callback;
- (void)historySince:(NSString *)sinceid limit:(int)limit callback:(SGCallback *)callback;
- (void)friends:(NSString* )uid callback:(SGCallback*)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Venue methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)venuesNearbyCoordinate:(CLLocationCoordinate2D)coordinate limit:(int)limit keyword:(NSString *)keyword callback:(SGCallback *)callback;
- (void)venueInformation:(NSString *)vid callback:(SGCallback*)callback;
- (void)addVenue:(NSString *)vid addressDictionary:(NSDictionary *)addressDictionary callback:(SGCallback *)callback;
- (void)editVenue:(NSString *)vid addressDictionary:(NSDictionary *)addressDictionary callback:(SGCallback *)callback;
- (void)venueClosed:(NSString *)vid callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tips methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)tipsNearbyCoordinate:(CLLocationCoordinate2D)coordinate limit:(NSInteger)limit callback:(SGCallback *)callback;
- (void)addTipToVenue:(NSString *)vid tip:(NSString *)tip type:(NSString *)type callback:(SGCallback *)callback;
- (void)markTipAsToDo:(NSString *)tid callback:(SGCallback *)callback;
- (void)markTipAsDone:(NSString *)tid callback:(SGCallback *)callback;
- (void)unmarkTip:(NSString *)tid callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Friends methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)pendingFriendRequestsCallback:(SGCallback *)callback;
- (void)approveFriendRequest:(NSString *)uid callback:(SGCallback *)callback;
- (void)denyFriendRequest:(NSString *)uid callback:(SGCallback *)callback;
- (void)sendFriendRequest:(NSString *)uid callback:(SGCallback *)callback;
- (void)findFriendsViaName:(NSString *)keyword callback:(SGCallback *)callback;
- (void)findFriendsViaTwitter:(NSString *)keyword callback:(SGCallback *)callback;
- (void)findFriendsViaPhone:(NSString *)keyword callback:(SGCallback *)callback;

@end
