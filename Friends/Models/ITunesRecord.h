//
//  ITunesRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "ApiRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface ITunesRecord : NSObject <ApiRecord>

- (instancetype)initWithArtist:(NSString *)artist track:(NSString *)track artwork:(NSString *)artwork;

- (NSString * _Nonnull)user;

- (NSString * _Nonnull)label;

//- (NSURL * _Nullable)icon;
- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
