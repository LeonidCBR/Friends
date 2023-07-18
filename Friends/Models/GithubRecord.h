//
//  GithubRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "ApiRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface GithubRecord : NSObject <ApiRecord>

- (instancetype)initWithLogin:(NSString *)login account:(NSString *)account avatar:(NSString *)avatar;

- (NSString * _Nonnull)user;

- (NSString * _Nonnull)label;

//- (NSURL * _Nullable)icon;
- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
