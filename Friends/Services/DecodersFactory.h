//
//  DecodersFactory.h
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import <Foundation/Foundation.h>
#import "DataProvider.h"
#import "ITunesDecoder.h"
#import "GithubDecoder.h"

NS_ASSUME_NONNULL_BEGIN

/// A factory of decoders
@interface DecodersFactory : NSObject

/// Instantiates a decoder for the selected API type
+ (id<RecordsDecoder>)getDecoderForRecordsProviderType: (RecordsProviderType)recordsProviderType;

@end

NS_ASSUME_NONNULL_END
