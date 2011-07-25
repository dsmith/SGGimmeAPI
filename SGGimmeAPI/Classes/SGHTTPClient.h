//
//  SGHTTPClient.h
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 Dsmitts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

#if NS_BLOCKS_AVAILABLE
typedef void (^SGFailureBlock)(NSError *error);
typedef void (^SGSuccessBlock)(NSObject *response);
#endif

@interface SGCallback : NSObject
{
    @private
    id delegate;
    SEL successMethod;
    SEL failureMethod;

#if NS_BLOCKS_AVAILABLE
    SGFailureBlock failureBlock;
    SGSuccessBlock successBlock;
#endif
}

@property (nonatomic, readonly) id delegate;
@property (nonatomic, readonly) SEL successMethod;
@property (nonatomic, readonly) SEL failureMethod;

#if NS_BLOCKS_AVAILABLE
@property (nonatomic, readonly) SGSuccessBlock successBlock;
@property (nonatomic, readonly) SGFailureBlock failureBlock;
#endif

+ (SGCallback *)callback;

+ (SGCallback *)callbackWithDelegate:(id)delegate successMethod:(SEL)method failureMethod:(SEL)method;
- (id)initWithDelegate:(id)delegate successMethod:(SEL)method failureMethod:(SEL)method;

#if NS_BLOCKS_AVAILABLE
+ (SGCallback *)callbackWithSuccessBlock:(SGSuccessBlock)sBlock failureBlock:(SGFailureBlock)fBlock;
- (id)initWithSuccessBlock:(SGSuccessBlock)sBlock failureBlock:(SGFailureBlock)fBlock;
#endif

@end

@class SGInternalClient;

@interface SGHTTPClient : NSObject {

    NSString *userAgent;

    NSString *oauthCallback;
    NSString *verifier;

    NSString *consumerKey;
    NSString *consumerSecret;
    NSString *accessToken;
    NSString *accessSecret;
}

@property (nonatomic, retain) NSString *verifier;
@property (nonatomic, retain) NSString *oauthCallback;

@property (nonatomic, retain) NSString *consumerKey;
@property (nonatomic, retain) NSString *consumerSecret;
@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *accessSecret;


- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (id)initWithConsumerKey:(NSString *)key
           consumerSecret:(NSString *)secret 
              accessToken:(NSString *)accessToken 
             accessSecret:(NSString *)accessSecret;
- (id)initWithAccessToken:(NSString *)accessToken;

- (void)sendHTTPRequest:(NSString *)type
                  toURL:(NSURL *)url
             withParams:(NSDictionary *)params 
               callback:(SGCallback *)callback;

- (void)handleFailure:(ASIHTTPRequest *)request withCallback:(SGCallback *)callback;
- (void)handleSuccess:(ASIHTTPRequest *)request withCallback:(SGCallback *)callback;

@end
