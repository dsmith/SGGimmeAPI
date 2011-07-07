//
//  SGFoursquareClient.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 CrashCorp. All rights reserved.
//

#import "SGFoursquareClient.h"

static NSString* foursquareURL = @"https://api.foursquare.com/v2";

@interface SGFoursquareClient (Private)

- (void) _updateStatus:(NSString*)status ofTip:(NSString*)tid callback:(SGCallback*)callback;
- (void) _updateFriendRequest:(NSString*)uid status:(NSString*)status callback:(SGCallback*)callback;
- (void) _findFriends:(NSString*)keyword byMedium:(NSString*)meduim callback:(SGCallback*)callback;

- (NSMutableDictionary*) getLatLonParams:(CLLocationCoordinate2D)coordinate;

- (void)sendHTTPRequest:(NSString *)type
                  toFile:(NSString *)file
             withParams:(NSDictionary *)params 
               callback:(SGCallback *)callback;

@end

@implementation SGFoursquareClient

//////////////////////////////////////////////////////////////////////////////////////////////// 
#pragma mark -
#pragma mark Geo methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) activeCitiesCallback:(SGCallback*)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:@"/cities"
               withParams:nil
                 callback:callback];
}

- (void) closestCityToCoordinate:(CLLocationCoordinate2D)coordinate cityId:(NSString*)cityId callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [self getLatLonParams:coordinate];
    if(cityId)
        [params setObject:cityId forKey:@"cityid"];
    [self sendHTTPRequest:@"GET"
                    toFile:@"/checkcity"
               withParams:params
                 callback:callback];
}

- (void) updateDefaultCity:(NSString*)cityId callback:(SGCallback*)callback
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:cityId, @"cityid", nil];    
    [self sendHTTPRequest:@"POST"
                    toFile:@"/switchcity"
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Check in methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) checkIns:(NSString*)cityId callback:(SGCallback*)callback
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:cityId, @"cityid", nil];    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/checkins"
               withParams:params
                 callback:callback];
}

- (void) shoutMessage:(NSString*)message coordinate:(CLLocationCoordinate2D)coordinate twitter:(BOOL)enabled callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [self getLatLonParams:coordinate];
    [params setObject:[NSString stringWithFormat:@"%i", enabled] forKey:@"twitter"];
    [params setObject:message forKey:@"shout"];
    [self sendHTTPRequest:@"POST"
                    toFile:@"/checkin"
               withParams:params
                 callback:callback];
}

- (void) checkIntoVenue:(NSString*)vid coordinate:(CLLocationCoordinate2D)coord callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [self getLatLonParams:coord];
    [params setObject:vid forKey:@"vid"];
    
    [self sendHTTPRequest:@"POST"
                    toFile:@"/checkin"
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark User methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) userInformation:(NSString*)userId badges:(BOOL)badges mayor:(BOOL)mayor callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%i", badges], @"badges",
                                   [NSString stringWithFormat:@"%i", badges], @"mayor",
                                   nil];
    if(userId)
        [params setObject:userId forKey:@"uid"];
    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/user"
               withParams:params
                 callback:callback];
}

- (void) historySince:(NSString*)sinceid limit:(int)limit callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    if(sinceid)
        [params setObject:sinceid forKey:@"sinceid"];
    
    if(limit > 0)
        [params setObject:[NSString stringWithFormat:@"%i", limit] forKey:@"l"];
    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/history"
               withParams:params
                 callback:callback];
}

- (void) friends:(NSString*)uid callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    if(uid)
        [params setObject:uid forKey:@"uid"];
    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/friends"
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Venue methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) venuesNearbyCoordinate:(CLLocationCoordinate2D)coordinate limit:(int)limit keyword:(NSString*)keyword callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [self getLatLonParams:coordinate];
    if(limit > 0)
        [params setObject:[NSString stringWithFormat:@"%i", limit] forKey:@"limit"];
    
    if(keyword)
        [params setObject:keyword forKey:@"query"];
    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/venues/search"
               withParams:params
                 callback:callback];
}

- (void) venueInformation:(NSString*)vid callback:(SGCallback*)callback
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:vid, @"vid", nil];
    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/venue"
               withParams:params
                 callback:callback];
}

- (void) addVenue:(NSString*)name addressDictionary:(NSDictionary*)addressDictionary callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [NSDictionary dictionaryWithDictionary:addressDictionary];
    [params setObject:name forKey:@"vid"];
    
    [self sendHTTPRequest:@"POST"
                    toFile:@"/addvenue"
               withParams:params
                 callback:callback];
}

- (void) editVenue:(NSString*)vid addressDictionary:(NSDictionary*)addressDictionary callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:addressDictionary];
    [params setValue:@"vid" forKey:vid];
    
    [self sendHTTPRequest:@"POST"
                    toFile:@"/venue/proposeedit"
               withParams:addressDictionary
                 callback:callback];
}

- (void) venueClosed:(NSString*)vid callback:(SGCallback*)callback
{
    [self sendHTTPRequest:@"POST"
                    toFile:@"/venue/flagclosed"
               withParams:nil
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tips methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) tipsNearbyCoordinate:(CLLocationCoordinate2D)coordinate limit:(NSInteger)limit callback:(SGCallback*)callback
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%f", coordinate.latitude], @"geolat",
                                   [NSString stringWithFormat:@"%f", coordinate.longitude], @"geolong",
                                   nil];
    if(limit > 0)
        [params setObject:[NSString stringWithFormat:@"%i", limit] forKey:@"limit"];
    
    [self sendHTTPRequest:@"GET"
                    toFile:@"/tips"
               withParams:params
                 callback:callback];
}

- (void) addTipToVenue:(NSString*)vid tip:(NSString*)tip type:(NSString*)type callback:(SGCallback*)callback
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            vid, @"vid",
                            tip, @"tip",
                            type, @"type",
                            nil];
    
    [self sendHTTPRequest:@"POST"
                    toFile:@"/addtip"
               withParams:params
                 callback:callback];
}

- (void) markTipAsToDo:(NSString*)tid callback:(SGCallback*)callback
{
    return [self _updateStatus:@"marktodo" ofTip:tid callback:callback];
}

- (void) markTipAsDone:(NSString*)tid callback:(SGCallback*)callback
{
    return [self _updateStatus:@"markdone" ofTip:tid callback:callback];
}

- (void) unmarkTip:(NSString*)tid callback:(SGCallback*)callback
{
    return [self _updateStatus:@"unmark" ofTip:tid callback:callback];
}

- (void) _updateStatus:(NSString*)status ofTip:(NSString*)tid callback:(SGCallback*)callback
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:tid, @"tid", nil];
    [self sendHTTPRequest:@"POST"
                    toFile:[NSString stringWithFormat:@"/tip/%@", status]
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Friends methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) pendingFriendRequestsCallback:(SGCallback*)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:@"/friend/requests"
               withParams:nil
                 callback:callback];
}

- (void) approveFriendRequest:(NSString*)uid callback:(SGCallback*)callback
{
    [self _updateFriendRequest:uid status:@"approve" callback:callback];
}

- (void) denyFriendRequest:(NSString*)uid callback:(SGCallback*)callback
{
    [self _updateFriendRequest:uid status:@"deny" callback:callback];
}

- (void) sendFriendRequest:(NSString*)uid callback:(SGCallback*)callback
{
    [self _updateFriendRequest:uid status:@"sendrequest" callback:callback];
}

- (void) _updateFriendRequest:(NSString*)uid status:(NSString*)status callback:(SGCallback*)callback
{
    [self sendHTTPRequest:@"POST"
                    toFile:[NSString stringWithFormat:@"/friend/%@", status]
               withParams:nil
                 callback:callback];
}

- (void) findFriendsViaName:(NSString*)keyword callback:(SGCallback*)callback
{
    [self _findFriends:keyword byMedium:@"byname" callback:callback];
}

- (void) findFriendsViaTwitter:(NSString*)keyword callback:(SGCallback*)callback
{
    [self _findFriends:keyword byMedium:@"bytwitter" callback:callback];
}

- (void) findFriendsViaPhone:(NSString*)keyword callback:(SGCallback*)callback
{
    [self _findFriends:keyword byMedium:@"byphone" callback:callback];
}

- (void) _findFriends:(NSString*)keyword byMedium:(NSString*)meduim callback:(SGCallback*)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:[NSString stringWithFormat:@"/findfriends/%@", meduim]
               withParams:nil
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Utility methods
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)sendHTTPRequest:(NSString *)type
                 toFile:(NSString *)file
             withParams:(NSDictionary *)params 
               callback:(SGCallback *)callback
{
    [self sendHTTPRequest:type 
                    toURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.json"]]
               withParams:params
                 callback:callback];
}

- (NSMutableDictionary*) getLatLonParams:(CLLocationCoordinate2D)coordinate
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude], @"ll",
                                   nil];
    return params;
}

@end
