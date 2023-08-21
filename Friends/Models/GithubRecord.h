//
//  GithubRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "ApiRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// A record of an account of the GitHub
@interface GithubRecord : NSObject <ApiRecord>

/// Create a record from given a user's login, an account's url and an avatar's url
- (instancetype)initWithLogin:(NSString * _Nullable)login account:(NSString * _Nullable)account avatar:(NSString * _Nullable)avatar;

/// A user's login
- (NSString * _Nonnull)user;

/// An account's url
- (NSString * _Nonnull)label;

/// An avatar's url
- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
