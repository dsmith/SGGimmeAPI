//
//  SGTwitterClient.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 CrashCorp. All rights reserved.
//

#import "SGTwitterClient.h"

static NSString* twitterURL = @"http://api.twitter.com/2";

@interface SGTwitterClient (Private)

- (void)sendHTTPRequest:(NSString *)type
                 toFile:(NSString *)file
             withParams:(NSDictionary *)params 
               callback:(SGCallback *)callback;

@end

@implementation SGTwitterClient

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Account
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)verifyCredentials:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:@"/account/verify_credentials"
               withParams:nil
                 callback:callback];
}

- (void)rateLimitStatus:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:@"/account/rate_limit_status"
               withParams:nil
                 callback:callback];
}

- (void)totals:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:@"/account/totals"
               withParams:nil
                 callback:callback];
}

- (void)settings:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                    toFile:@"/account/settings"
               withParams:nil
                 callback:callback];
}

- (void)updateSettings:(NSDictionary *)settings callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                    toFile:@"/account/settings"
               withParams:settings
                 callback:callback];
}

- (void)updateProfileColors:(NSDictionary *)colors callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                    toFile:@"/account/update_profile_colors"
               withParams:colors
                 callback:callback];
}

- (void)updateProfileImage:(UIImage *)image callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(image)
        [params setValue:UIImagePNGRepresentation(image) forKey:@"image"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/account/update_profile_image"
               withParams:params
                 callback:callback];
}

- (void)updateProfileBackgroundImage:(UIImage *)image tile:(BOOL)tile callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithBool:tile]
                                                                     forKey:@"tile"];
    if(image)
        [params setValue:UIImagePNGRepresentation(image) forKey:@"image"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/account/update_profile_background_image"
               withParams:params
                 callback:callback];    
}

- (void)updateProfile:(NSDictionary*)settings callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:@"/account/update_profile"
               withParams:settings
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Timeline
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)homeTimeline:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/home_timeline"
               withParams:options
                 callback:callback];
}

- (void)mentions:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/mentions"
               withParams:options
                 callback:callback];
}

- (void)publicTimeline:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/public_timeline"
               withParams:options
                 callback:callback];
}

- (void)retweetedByMe:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/retweeted_by_me"
               withParams:options
                 callback:callback];
}

- (void)retweetedToMe:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/retweeted_to_me"
               withParams:options
                 callback:callback];
}

- (void)timelineForUser:(NSString*)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];

    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/user_timeline"
               withParams:params
                 callback:callback];
}

- (void)retweetedToUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];

    if(userId)
        [params setValue:userId forKey:@"user_id"];

    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/retweeted_to_user"
               withParams:options
                 callback:callback];
}

- (void)retweetedByUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];

    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/statuses/retweeted_by_user"
               withParams:options
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tweets
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)usersWhoRetweetedStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/statuses/%@/retweeted_by", statusId]
               withParams:options
                 callback:callback];
}

- (void)userIdsWhoRetweetedStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/statuses/%@/retweeted_by/ids", statusId]
               withParams:options
                 callback:callback];
}

- (void)retweetsForStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/statuses/retweets/%@", statusId]
               withParams:options
                 callback:callback];
}

- (void)showStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/statuses/show/%@", statusId]
               withParams:options
                 callback:callback];
}

- (void)destroyStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/statuses/destroy/%@", statusId]
               withParams:options
                 callback:callback];
}

- (void)retweetStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/statuses/retweet/%@", statusId]
               withParams:options
                 callback:callback];
}

- (void)updateStatus:(NSString *)status options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(status)
        [params setValue:status forKey:@"status"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/statuses/update"
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Search
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)search:(NSString *)query options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(query)
        [params setValue:query forKey:@"q"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/search"
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Direct Messages
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)directMessages:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/direct_messages"
               withParams:options
                 callback:callback];
}

- (void)directMessagesSent:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/direct_messages/sent"
               withParams:options
                 callback:callback];
}

- (void)destroyDirectMessage:(NSString *)messageId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"POST"
                   toFile:[NSString stringWithFormat:@"/direct_messages/destroy/%@", messageId]
               withParams:options
                 callback:callback];
}

- (void)newDirectMessage:(NSString *)text options:(NSDictionary *)options callback:(SGCallback *)callback
{    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(text)
        [params setValue:text forKey:@"text"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/direct_messages/new"
               withParams:params 
                 callback:callback];
}

- (void)getDirectMessage:(NSString *)messageId callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/direct_messages/%@", messageId]
               withParams:nil
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Friends and Followers
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)followersForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/followers/ids"
               withParams:params
                 callback:callback];
}

- (void)friendsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/friends/ids"
               withParams:params
                 callback:callback];    
}

- (void)friendshipExistsBetweenUser:(NSString *)userIdA 
                            andUser:(NSString *)userIdB
                            options:(NSDictionary *)options 
                           callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userIdA)
        [params setValue:userIdA forKey:@"user_id_a"];

    if(userIdA)
        [params setValue:userIdB forKey:@"user_id_b"];

    [self sendHTTPRequest:@"GET"
                   toFile:@"/friendships/exists"
               withParams:params
                 callback:callback];        
}

- (void)incomingFriendships:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/friendships/incoming"
               withParams:options
                 callback:callback];
}

- (void)outgoingFriendships:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/friendships/outgoing"
               withParams:options
                 callback:callback];
}

- (void)showFriendships:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/friendships/show"
               withParams:options
                 callback:callback];
}

- (void)createFriendshipWithFriend:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/friendships/create"
               withParams:params
                 callback:callback];
}

- (void)deleteFriendshipWithFriend:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/friendships/destroy"
               withParams:params
                 callback:callback];    
}

- (void)lookupFriendshipWithFriend:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/friendships/lookup"
               withParams:params
                 callback:callback];        
}

- (void)updateFriendship:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    [self sendHTTPRequest:@"POST"
                   toFile:@"/friendships/update"
               withParams:params
                 callback:callback];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Users
///////////////////////////////////////////////////////////////////////////////////////////////

- (void)lookupUsers:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/lookup"
               withParams:options
                 callback:callback];
}

- (void)profileImageForScreenName:(NSString *)screenName size:(NSString *)size callback:(SGCallback *)callback;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(size)
        [params setObject:size forKey:@"size"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/profile_image/%@", screenName]
               withParams:params
                 callback:callback];

}

- (void)searchUsers:(NSString *)query options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(query)
        [params setValue:query forKey:@"q"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/search"
               withParams:params
                 callback:callback];
}

- (void)showUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    

    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/show"
               withParams:params
                 callback:callback];
}

- (void)contributeesForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/contributees"
               withParams:params
                 callback:callback];
}

- (void)contributorsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"user_id"];
    
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/contributors"
               withParams:params
                 callback:callback];    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Suggested Users
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)suggestedUsersInLang:(NSString *)lang callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if(lang)
        [params setValue:lang forKey:@"lang"];
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/users/suggestions"
               withParams:params
                 callback:callback];
}

- (void)suggestedUsersForCategory:(NSString *)category options:(NSDictionary *)options callback:(SGCallback *)callback
{
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/users/suggestions/%@", category]
               withParams:options
                 callback:callback];        
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Favorites
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)favoritesForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(userId)
        [params setValue:userId forKey:@"id"];
    
    
    [self sendHTTPRequest:@"GET"
                   toFile:@"/favorites"
               withParams:params
                 callback:callback];    
}

- (void)createFavorite:(NSString *)favoriteId options:(NSDictionary *)options callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(options)
        [params setDictionary:options];
    
    if(favoriteId)
        [params setValue:favoriteId forKey:@"id"];
    
    
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/favorites/create/%@", favoriteId]
               withParams:params
                 callback:callback];
}

- (void)destroyFavorite:(NSString *)favoriteId callback:(SGCallback *)callback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(favoriteId)
        [params setValue:favoriteId forKey:@"id"];
    
    
    [self sendHTTPRequest:@"GET"
                   toFile:[NSString stringWithFormat:@"/favorites/destroy/%@", favoriteId]
               withParams:params
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
                    toURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.json", twitterURL, file]]
               withParams:params
                 callback:callback];
}

@end
