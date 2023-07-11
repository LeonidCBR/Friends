//
//  MockURLProtocol.m
//  FriendsTests
//
//  Created by Яна Латышева on 11.07.2023.
//

#import "MockURLProtocol.h"

@implementation MockURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
/*
        // does not work (EXC_BAD_ACCESS)
//        [self.client URLProtocol:self didReceiveResponse:stubResponse cacheStoragePolicy:NSURLCacheStorageAllowed];
        // it works
        NSURL *testUrl = [[NSURL alloc] initWithString:@"https://localhost"];
        NSArray *objects = [[NSArray alloc] initWithObjects:@"Content-Type", nil];
        NSArray *keys = [[NSArray alloc] initWithObjects:@"application/json", nil];
        NSDictionary *testHeaders = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
        NSHTTPURLResponse *testResponse = [[NSHTTPURLResponse alloc]
                                           initWithURL:testUrl
                                           statusCode:200
                                           HTTPVersion:@"1.1"
                                           headerFields:testHeaders];
        [self.client URLProtocol:self didReceiveResponse:testResponse cacheStoragePolicy:NSURLCacheStorageAllowed]; // stubResponse
*/
        // does not work
//        [self.client URLProtocol:self didLoadData:stubData];
        // it works
        NSString *testString = @"{\"status\":\"ok\"}";
        NSData *testData = [testString dataUsingEncoding:NSUTF8StringEncoding];
        [self.client URLProtocol:self didLoadData:testData]; //stubData
    }
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
}

@end
