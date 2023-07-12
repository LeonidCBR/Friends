//
//  MockURLProtocol.m
//  FriendsTests
//
//  Created by Яна Латышева on 11.07.2023.
//

#import "MockURLProtocol.h"

static NSError *_stubError = nil;
static NSData *_stubData = nil;
static NSURLResponse *_stubResponse = nil;

@implementation MockURLProtocol

+ (NSError *)stubError {
    return _stubError;
}

+ (void)setStubError:(NSError * _Nullable)stubError {
    _stubError = stubError;
}

+ (NSData *)stubData {
    return _stubData;
}

+ (void)setStubData:(NSData * _Nullable)stubData {
    _stubData = stubData;
}

+ (NSURLResponse *)stubResponse {
    return _stubResponse;
}

+ (void)setStubResponse:(NSURLResponse * _Nullable)stubResponse {
    _stubResponse = stubResponse;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    if (_stubError) {
        [self.client URLProtocol:self didFailWithError:_stubError];
    } else {
        if (_stubResponse && _stubData) {
            [self.client URLProtocol:self didReceiveResponse:_stubResponse cacheStoragePolicy:NSURLCacheStorageAllowedInMemoryOnly];
            [self.client URLProtocol:self didLoadData:_stubData];
        }
    }
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
}

@end
