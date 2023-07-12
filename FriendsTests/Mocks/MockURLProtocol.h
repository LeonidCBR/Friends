//
//  MockURLProtocol.h
//  FriendsTests
//
//  Created by Яна Латышева on 11.07.2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MockURLProtocol : NSURLProtocol

+ (NSError *)stubError;

+ (void)setStubError:(NSError * _Nullable)stubError;

+ (NSData *)stubData;

+ (void)setStubData:(NSData * _Nullable)stubData;

+ (NSURLResponse *)stubResponse;

+ (void)setStubResponse:(NSURLResponse * _Nullable)stubResponse;

@end

NS_ASSUME_NONNULL_END
