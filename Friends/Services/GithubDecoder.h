//
//  GithubDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "RecordsDecoder.h"
#import "GithubRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface GithubDecoder : NSObject <RecordsDecoder>

- (nonnull NSArray<ApiRecord> *)decode:(NSData * _Nonnull)data;

@end

NS_ASSUME_NONNULL_END
