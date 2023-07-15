//
//  ITunesDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "RecordsDecoder.h"
#import "BaseDecoder.h"

NS_ASSUME_NONNULL_BEGIN

@interface ITunesDecoder : BaseDecoder <RecordsDecoder>

- (nonnull NSArray<id<ApiRecord>> *)decode:(NSData * _Nonnull)data;

@end

NS_ASSUME_NONNULL_END
