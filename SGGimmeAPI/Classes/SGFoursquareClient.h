//
//  SGFoursquareClient.h
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 Dsmitts. All rights reserved.
//

#import "SGHTTPClient.h"

/**
 A HTTP client that interfaces with Foursquare's API.
*/
@interface SGFoursquareClient : SGHTTPClient {

}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Check in
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)informationForCheckin:(NSString *)checkinId callback:(SGCallback *)callback;
- (void)checkinToVenue:(NSString *)venueId withMessage:(NSString *)message options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)shout:(NSString *)message options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)recentCheckins:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)addComment:(NSString *)comment toCheckin:(NSString *)checkinId callback:(SGCallback *)callback;
- (void)deleteComment:(NSString *)commentId fromCheckin:(NSString *)checkinId callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark User
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)userInformation:(NSString *)userId callback:(SGCallback *)callback;
- (void)userLeaderboard:(SGCallback *)callback;
- (void)searchForUsers:(NSDictionary *)searchParams callback:(SGCallback *)callback;
- (void)pendingFriendRequests:(SGCallback *)callback;
- (void)badgesForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)checkinsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)friendsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)mayorshipsForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)tipsFromUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)todosFromUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)venueHistoryForUser:(NSString *)userId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)sendFriendRequestToUser:(NSString *)userId callback:(SGCallback *)callback;
- (void)unfriendUser:(NSString *)userId callback:(SGCallback *)callback;
- (void)approveFriendRequestFromUser:(NSString *)userId callback:(SGCallback *)callback;
- (void)denyFriendRequestFromUser:(NSString *)userId callback:(SGCallback *)callback;
- (void)enablePings:(BOOL)enabled fromUser:(NSString *)userId callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Venue
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)informationForVenue:(NSString *)venueId callback:(SGCallback *)callback;
- (void)addVenue:(NSString *)name options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)venueCategories:(SGCallback *)callback;
- (void)exploreVenuesWithLatitude:(double)lat andLongitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)searchVenuesWithLatitude:(double)lat andLongitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)trendingVenuesWithLatitude:(double)lat andLongitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)hereNowAtVenue:(NSString *)venueId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)tipsForVenue:(NSString *)venueId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)photosFromVenue:(NSString *)venueId options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)linksForVenue:(NSString *)venueId callback:(SGCallback *)callback;
- (void)markVenue:(NSString *)venueId asToDo:(NSString *)message callback:(SGCallback *)callback;
- (void)flagVenue:(NSString *)venueId withProblem:(NSString *)problem callback:(SGCallback *)callback;
- (void)editVenue:(NSString *)venueId withOptions:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)proposeEditToVenue:(NSString *)venueId withOptions:(NSDictionary *)options callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Tips
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)informationForTip:(NSString *)tipId callback:(SGCallback *)callback;
- (void)addTip:(NSString *)tip toVenue:(NSString *)venueId withURL:(NSString *)url callback:(SGCallback *)callback;
- (void)searchTipsWithLatitude:(double)lat longitude:(double)lon options:(NSDictionary *)options callback:(SGCallback *)callback;
- (void)markToDoForTip:(NSString *)tipId callback:(SGCallback *)callback;
- (void)unmarkToDoForTip:(NSString *)tipId callback:(SGCallback *)callback;
- (void)markDoneForTip:(NSString *)tipId callback:(SGCallback *)callback;

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Settings
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)settingsForUser:(NSString *)userId callback:(SGCallback *)callback;
- (void)enable:(BOOL)enable setting:(NSString *)setting callback:(SGCallback *)callback;


@end
