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

- (nonnull NSString *)user;

- (nonnull NSString *)label;

- (NSURL *)icon;

@end

NS_ASSUME_NONNULL_END
