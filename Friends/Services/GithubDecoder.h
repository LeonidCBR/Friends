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

@interface GithubDecoder : BaseDecoder <RecordsDecoder>

- (NSArray<id<ApiRecord>> * _Nullable)decode:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
