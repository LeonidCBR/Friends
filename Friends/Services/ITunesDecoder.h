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

/// A decoder of iTunes records
///
/// This is a decoder of data with content recieved from iTunes API.
@interface ITunesDecoder : BaseDecoder <RecordsDecoder>

/// Get records from given data
///
/// - Parameters:
///   - data: The data contains iTunes content
///   - error: The error if the method fails
///
/// - Returns: An array of iTunes records
- (NSArray<id<ApiRecord>> * _Nullable)decodeData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
