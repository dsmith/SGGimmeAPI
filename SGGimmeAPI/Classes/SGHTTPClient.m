//
//  SGHTTPClient.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/7/11.
//  Copyright 2011 SimpleGeo. All rights reserved.
//

#import "SGHTTPClient.h"

#import "ASIHTTPRequest.h"
#import "ASIHTTPRequest+OAuth.h"
#import "ASIFormDataRequest.h"
#import "ASIFormDataRequest+OAuth.h"

#import "JSON.h"

@interface SGHTTPClient (Private)

- (void)handleFailure:(ASIHTTPRequest *)request;
- (void)handleSuccess:(ASIHTTPRequest *)request;

- (NSString *)normalizeRequestParams:(NSDictionary *)params;
- (NSObject *)jsonObjectForResponseData:(NSData *)data;

@end

@implementation SGHTTPClient

- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret
{
    return [self initWithConsumerKey:key consumerSecret:secret accessToken:nil];
}

- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret accessToken:(NSString *)token
{
    self = [super init];
    if(self) {
        NSDictionary *infoDictionary = [[NSBundle bundleForClass:[self class]] infoDictionary];
        userAgent = [[NSString stringWithFormat:@"%@ %@; SimpleGeo/Obj-C %@; %@ %@",
                      [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion],
                      @"1.0",
                      [infoDictionary objectForKey:@"CFBundleName"], [infoDictionary objectForKey:@"CFBundleVersion"]] retain];
        
        consumerKey = [key retain];
        consumerSecret = [secret retain];
        accessToken = [token retain];
    }
    
    return self;    
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ASIHTTPRequest delegate methods 
//////////////////////////////////////////////////////////////////////////////////////////////// 

- (void)requestFinished:(ASIHTTPRequest*)request
{    
    if(0 <= ([request responseStatusCode] - 200) <= 99)
        [self handleSuccess:request];
    else
        [self handleFailure:request];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self handleFailure:request];
}

- (void)handleSuccess:(ASIHTTPRequest *)request
{
    NSDictionary* userInfo = [request userInfo];
    if(userInfo) {
        SGCallback *callback = [userInfo objectForKey:@"callback"];
        if(callback && [callback respondsToSelector:callback.successMethod])
            [callback.delegate performSelector:callback.successMethod 
                                    withObject:[self jsonObjectForResponseData:[request responseData]]];    
    }
}

- (void)handleFailure:(ASIHTTPRequest *)request
{
    NSDictionary* userInfo = [request userInfo];
    if(userInfo) {
        SGCallback *callback = [userInfo objectForKey:@"callback"];
        if(callback) {
            NSDictionary *userInfo = (NSDictionary*)[self jsonObjectForResponseData:[request responseData]];
            if(!userInfo || ![userInfo isKindOfClass:[NSDictionary class]])
                userInfo = [NSDictionary dictionary];

            NSError* error = [NSError errorWithDomain:[request.url description]
                                                 code:[request responseStatusCode]
                                             userInfo:userInfo];
            [callback.delegate performSelector:callback.failureMethod withObject:error];  
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Utility methods
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)sendHTTPRequest:(NSString *)type
                  toURL:(NSURL *)url
             withParams:(NSDictionary *)params 
               callback:(SGCallback *)callback
{	
    SGLog(@"Sending %@ to %@", type, [url description]);

    ASIHTTPRequest* request = nil;
    if([type isEqualToString:@"POST"]) {
        ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:url];
        for(NSString *key in [[params allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            [postRequest setPostValue:[params objectForKey:key] forKey:key];
        }
        request = postRequest;
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", [url absoluteString], [self normalizeRequestParams:params]]];
        request = [ASIHTTPRequest requestWithURL:url];        
    }

    request.userInfo = [NSDictionary dictionaryWithObject:callback forKey:@"callback"];
    request.requestMethod = type;
    [request signRequestWithClientIdentifier:consumerKey
                                      secret:consumerSecret
                             tokenIdentifier:accessToken
                                      secret:nil
                                 usingMethod:ASIOAuthHMAC_SHA1SignatureMethod];

    [request setDelegate:self];
    [request addRequestHeader:@"User-Agent" value:userAgent];
    [request startAsynchronous];
}

- (NSString *)normalizeRequestParams:(NSDictionary *)params
{
    NSMutableArray *parameterPairs = [NSMutableArray arrayWithCapacity:([params count])];
    NSString *value= nil;
    for(NSString* param in params) {
        value = [params objectForKey:param];

        // No need to URL encode here as it is done by ASI
        param = [NSString stringWithFormat:@"%@=%@", param, value];
        [parameterPairs addObject:param];
    }
    
    NSArray* sortedPairs = [parameterPairs sortedArrayUsingSelector:@selector(compare:)];
    return [sortedPairs componentsJoinedByString:@"&"];
}

- (void) dealloc
{
    [consumerKey release];
    [accessToken release];
    [consumerSecret release];
    [userAgent release];
    [super dealloc];
}

@end
