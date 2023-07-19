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

- (instancetype)initWithArtist:(NSString * _Nullable)artist track:(NSString * _Nullable)track artwork:(NSString * _Nullable)artwork;

- (NSString * _Nonnull)user;

- (NSString * _Nonnull)label;

- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
