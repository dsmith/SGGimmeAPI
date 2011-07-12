//
//  SGTwitterClient.h
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 CrashCorp. All rights reserved.
//

#import "SGHTTPClient.h"

#import <UIKit/UIKit.h>

@interface SGTwitterClient : SGHTTPClient {
    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Account
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)verifyCredentials:(SGCallback *)callback;
- (void)rateLimitStatus:(SGCallback *)callback;
- (void)totals:(SGCallback *)callback;
- (void)settings:(SGCallback *)callback; 
- (void)updateSettings:(NSDictionary *)settings callback:(SGCallback *)callback;
- (void)updateProfileColors:(NSDictionary *)colors callback:(SGCallback *)callback;
- (void)updateProfileImage:(UIImage *)image callback:(SGCallback *)callback;
- (void)updateProfileBackgroundImage:(UIImage *)image tile:(BOOL)tile callback:(SGCallback *)callback;
- (void)updateProfile:(NSDictionary*)settings callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Timelines
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)homeTimeline:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)mentions:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)publicTimeline:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)retweetedByMe:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)retweetedToMe:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)timelineForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)retweetedToUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)retweetedByUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tweets
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)usersWhoRetweetedStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)userIdsWhoRetweetedStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)retweetsForStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)showStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)destroyStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)retweetStatus:(NSString *)statusId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)updateStatus:(NSString *)status options:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Search
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)search:(NSString *)query options:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Direct Messages
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)directMessages:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)directMessagesSent:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)destroyDirectMessage:(NSString *)messageId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)newDirectMessage:(NSString *)text options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)getDirectMessage:(NSString *)messageId callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Friends and Followers
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)followersForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)friendsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)friendshipExistsBetweenUser:(NSString *)userIdA 
                            andUser:(NSString *)userIdB
                            options:(NSDictionary *)options 
                           callback:(SGCallback *)callback;
- (void)incomingFriendships:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)outgoingFriendships:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)showFriendships:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)createFriendshipWithFriend:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)deleteFriendshipWithFriend:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)lookupFriendshipWithFriend:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)updateFriendship:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Users
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)lookupUsers:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)profileImageForScreenName:(NSString *)screenName size:(NSString *)size callback:(SGCallback *)callback;
- (void)searchUsers:(NSString *)query options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)showUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)contributeesForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)contributorsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Suggested Users
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)suggestedUsersInLang:(NSString *)lang callback:(SGCallback *)callback;
- (void)suggestedUsersForCategory:(NSString *)category options:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Favorites
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)favoritesForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)createFavorite:(NSString *)favoriteId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)destroyFavorite:(NSString *)favoriteId callback:(SGCallback *)callback;


@end
