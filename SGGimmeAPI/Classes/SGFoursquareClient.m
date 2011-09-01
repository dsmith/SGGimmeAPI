//
//  SGFoursquareClient.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 Dsmitts. All rights reserved.
//

#import "SGFoursquareClient.h"

static NSString* foursquareURL = @"https://api.foursquare.com/v2";

@interface SGFoursquareClient ()

- (void)sendHTTPRequest:(NSString *)type
                  toFile:(NSString *)file
             withParams:(NSDictionary *)params 
               callback:(SGCallback *)callback;

@end

@implementation SGFoursquareClient

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Check in methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)informationForCheckin:(NSString *)checkinId callback:(SGCallback *)callback;
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/checkins/%@", checkinId]
               withParams:nil
                 callback:callback];
}

- (void)checkinToVenue:(NSString *)venueId withMessage:(NSString *)message options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params addEntriesFromDictionary:options];
    
    if(message)
        [params setValue:message forKey:@"shout"];
    
    if(venueId)
        [params setValue:venueId forKey:@"venueId"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/checkins/add"
               withParams:params
                 callback:callback];
    
}

- (void)shout:(NSString *)message options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self checkinToVenue:nil withMessage:message options:options callback:callback];
}

- (void)recentCheckins:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/checkins/recent"
               withParams:options
                 callback:callback];
}

- (void)addComment:(NSString *)comment toCheckin:(NSString *)checkinId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/checkins/%@/addcomment", checkinId]
               withParams:[NSDictionary dictionaryWithObject:comment forKey:@"text"]
                 callback:callback];
}

- (void)deleteComment:(NSString *)commentId fromCheckin:(NSString *)checkinId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/checkins/%@/deletecomment", checkinId]
               withParams:[NSDictionary dictionaryWithObject:commentId forKey:@"commentId"]
                 callback:callback];    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark User methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void) userInformation:(NSString*)userId callback:(SGCallback*)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@", userId]
               withParams:nil
                 callback:callback];
}

- (void)userLeaderboard:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/leaderboard"
               withParams:nil
                 callback:callback];
}

- (void)searchForUsers:(NSDictionary *)searchParams callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/search"
               withParams:searchParams
                 callback:callback];
}

- (void)pendingFriendRequests:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/requests"
               withParams:nil
                 callback:callback];
}

- (void)badgesForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/badges", userId]
               withParams:options
                 callback:callback];
}

- (void)checkinsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/checkins", userId]
               withParams:options
                 callback:callback];    
}

- (void)friendsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/friends", userId]
               withParams:options
                 callback:callback];    
}

- (void)mayorshipsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/mayorships", userId]
               withParams:options
                 callback:callback];
}

- (void)tipsFromUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/tips", userId]
               withParams:options
                 callback:callback];
}

- (void)todosFromUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/todos", userId]
               withParams:options
                 callback:callback];

}

- (void)venueHistoryForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/%@/venuehistory", userId]
               withParams:options
                 callback:callback];
}

- (void)sendFriendRequestToUser:(NSString *)userId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/users/%@/request", userId]
               withParams:nil
                 callback:callback];
}

- (void)unfriendUser:(NSString *)userId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/users/%@/unfriend", userId]
               withParams:nil
                 callback:callback];
}

- (void)approveFriendRequestFromUser:(NSString *)userId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/users/%@/approve", userId]
               withParams:nil
                 callback:callback];
}

- (void)denyFriendRequestFromUser:(NSString *)userId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/users/%@/deny", userId]
               withParams:nil
                 callback:callback];
}

- (void)enablePings:(BOOL)enabled fromUser:(NSString *)userId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/users/%@/setpings", userId]
               withParams:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:enabled] forKey:@"value"]
                 callback:callback];    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Venue
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)informationForVenue:(NSString *)venueId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/venues/%@", venueId]
               withParams:nil
                 callback:callback];
}

- (void)addVenue:(NSString *)name options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params addEntriesFromDictionary:options];
    
    if(name)
        [params setValue:name forKey:@"name"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/venues/add"
               withParams:params
                 callback:callback];
}

- (void)venueCategories:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/venues/categories"
               withParams:nil
                 callback:callback];
}

- (void)exploreVenuesWithLatitude:(double)lat andLongitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params addEntriesFromDictionary:options];
    
    [params setObject:[NSString stringWithFormat:@"%f,%f", lat,lon] forKey:@"ll"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/venues/explore"
               withParams:params
                 callback:callback];
}

- (void)searchVenuesWithLatitude:(double)lat andLongitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params addEntriesFromDictionary:options];
    
    [params setObject:[NSString stringWithFormat:@"%f,%f", lat,lon] forKey:@"ll"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/venues/search"
               withParams:params
                 callback:callback];
}

- (void)trendingVenuesWithLatitude:(double)lat andLongitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params addEntriesFromDictionary:options];
    
    [params setObject:[NSString stringWithFormat:@"%f,%f", lat,lon] forKey:@"ll"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/venues/trending"
               withParams:params
                 callback:callback];    
}

- (void)hereNowAtVenue:(NSString *)venueId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/venues/%@/herenow", venueId]
               withParams:options
                 callback:callback];
}

- (void)tipsForVenue:(NSString *)venueId options:(NSDictionary *)options callback:(SGCallback *)callback;
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/venues/%@/tips", venueId]
               withParams:options
                 callback:callback];    
}

- (void)photosFromVenue:(NSString *)venueId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/venues/%@/photos", venueId]
               withParams:options
                 callback:callback];
}

- (void)linksForVenue:(NSString *)venueId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/venues/%@/links", venueId]
               withParams:nil
                 callback:callback];    
}

- (void)markVenue:(NSString *)venueId asToDo:(NSString *)message callback:(SGCallback *)callback
{
    NSDictionary *params = nil;
    if(message)
        params = [NSDictionary dictionaryWithObject:message forKey:@"text"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/venues/%@/links", venueId]
               withParams:params
                 callback:callback];
}

- (void)flagVenue:(NSString *)venueId withProblem:(NSString *)problem callback:(SGCallback *)callback
{
    NSDictionary *params = nil;
    if(problem)
        params = [NSDictionary dictionaryWithObject:problem forKey:@"problem"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/venues/%@/flag", venueId]
               withParams:params
                 callback:callback];    
}

- (void)editVenue:(NSString *)venueId withOptions:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/venues/%@/edit", venueId]
               withParams:options
                 callback:callback];
}

- (void)proposeEditToVenue:(NSString *)venueId withOptions:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/venues/%@/proposeedit", venueId]
               withParams:options
                 callback:callback];    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tips
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)informationForTip:(NSString *)tipId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/tips/%@", tipId]
               withParams:nil
                 callback:callback];
}

- (void)addTip:(NSString *)tip toVenue:(NSString *)venueId withURL:(NSString *)url callback:(SGCallback *)callback
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            venueId, @"venueId",
                            tip, @"message",
                            url, @"url", 
                            nil];

    [self sendHTTPRequest:@"POST"
                   toFile:@"/tips/add"
               withParams:params
                 callback:callback];
}

- (void)searchTipsWithLatitude:(double)lat longitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params addEntriesFromDictionary:options];
    
    [params setObject:[NSString stringWithFormat:@"%f,%f", lat, lon] forKey:@"ll"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/tips/search"
               withParams:params
                 callback:callback];
}

- (void)markToDoForTip:(NSString *)tipId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/tips/%@/marktodo", tipId]
              withParams:nil 
                 callback:callback];
}

- (void)markDoneForTip:(NSString *)tipId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/tips/%@/markdone", tipId]
               withParams:nil 
                 callback:callback];
}

- (void)unmarkToDoForTip:(NSString *)tipId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/tips/%@/unmarktodo", tipId]
               withParams:nil 
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Settings
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)settingsForUser:(NSString *)userId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/settings/all"
               withParams:nil
                 callback:callback];
}

- (void)enable:(BOOL)enable setting:(NSString *)settingId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/settings/%@/set", settingId]
               withParams:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:enable]
                                                      forKey:@"value"]
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
                    toURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.json", foursquareURL, file]]
               withParams:params
                 callback:callback];
}

@end
