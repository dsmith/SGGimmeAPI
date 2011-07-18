//
//  SGHTTPClient.h
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 Dsmitts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGCallback : NSObject
{
    @private
    id delegate;
    SEL successMethod;
    SEL failureMethod;
}

@property (nonatomic, readonly) id delegate;
@property (nonatomic, readonly) SEL successMethod;
@property (nonatomic, readonly) SEL failureMethod;

+ (SGCallback *)callbackWithDelegate:(id)delegate successMethod:(SEL)method failureMethod:(SEL)method;
- (id)initWithDelegate:(id)delegate successMethod:(SEL)method failureMethod:(SEL)method;

@end

@interface SGHTTPClient : NSObject {

    NSString *userAgent;

    @private
    NSString *consumerKey;
    NSString *consumerSecret;
    NSString *accessToken;
    NSString *accessSecret;
}

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

@end
