//
//  RecordsDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "ApiRecord.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RecordsDecoder <NSObject>

- (NSArray<id<ApiRecord>> * _Nullable)decode:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
