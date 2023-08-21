//
//  ITunesRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "ApiRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// A record of iTunes media content
@interface ITunesRecord : NSObject <ApiRecord>

/// Create a record from given an artist name, a name of a track and an icon's url
- (instancetype)initWithArtist:(NSString * _Nullable)artist track:(NSString * _Nullable)track artwork:(NSString * _Nullable)artwork;

/// An artist
- (NSString * _Nonnull)user;

/// A track
- (NSString * _Nonnull)label;

/// An icon's url
- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
