//
//  ITunesDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "RecordsDecoder.h"
#import "BaseDecoder.h"
#import "ITunesRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface ITunesDecoder : BaseDecoder <RecordsDecoder>

- (NSArray<id<ApiRecord>> * _Nullable)decode:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
