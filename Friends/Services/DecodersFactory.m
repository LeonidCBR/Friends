//
//  DecodersFactory.m
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import "DecodersFactory.h"

@implementation DecodersFactory

+ (id<RecordsDecoder>)getDecoderForRecordsProviderType:(RecordsProviderType)recordsProviderType {
    id<RecordsDecoder> recordsDecoder;
    switch (recordsProviderType) {
        case iTunes:
            recordsDecoder = [ITunesDecoder new];
            break;
        case gitHub:
            recordsDecoder = [GithubDecoder new];
            break;
        default:
            NSLog(@"Unexpected records provider type!");
            recordsDecoder = nil;
            break;
    }
    return recordsDecoder;
}

@end
