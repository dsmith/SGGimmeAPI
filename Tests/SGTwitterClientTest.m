//
//  SGTwitterClientTest.m
//  SGGimmeAPI
//
//  Created by Derek Smith on 7/12/11.
//  Copyright 2011 SimpleGeo. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "SGTwitterClient.h"

@interface SGTwitterClientTest : GHAsyncTestCase {
 
    SGTwitterClient* client;
    
}

@end

@implementation SGTwitterClientTest

- (id) init
{

    self = [super init];
    if(self) {
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* path = [mainBundle pathForResource:@"credentials" ofType:@"plist"];
        NSDictionary* credentials = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"twitter"];
        client = [[SGTwitterClient alloc] initWithConsumerKey:[credentials objectForKey:@"access_token"]
                                               consumerSecret:[credentials objectForKey:@"access_secret"]];
    }
    
    return self;
}

@end
