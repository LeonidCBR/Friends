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

- (nonnull NSArray<id<ApiRecord>> *)decode:(NSData * _Nonnull)data;

@end

NS_ASSUME_NONNULL_END
