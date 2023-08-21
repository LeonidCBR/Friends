//
//  RecordsDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "ApiRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// A type that decodes data to an array of records
@protocol RecordsDecoder <NSObject>

/// Get records from given data
///
/// - Parameters:
///   - data: The data
///   - error: The error if the method fails
///
/// - Returns: An array of records
- (NSArray<id<ApiRecord>> * _Nullable)decodeData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
