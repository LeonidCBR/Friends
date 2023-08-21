//
//  GithubDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "BaseDecoder.h"
#import "RecordsDecoder.h"
#import "GithubRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// A decoder of GitHub records
///
/// This is a decoder of data with users' descriptions recieved from GitHub API.
@interface GithubDecoder : BaseDecoder <RecordsDecoder>

/// Get records from given data
/// 
/// - Parameters:
///   - data: The data contains GitHub users
///   - error: The error if the method fails
///
/// - Returns: An array of GitHub records
- (NSArray<id<ApiRecord>> * _Nullable)decodeData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
