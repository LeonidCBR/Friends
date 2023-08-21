//
//  ITunesDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#define ITEMS @"results"
#define ITEMS_COUNT @"resultCount"

#import "ITunesDecoder.h"

@implementation ITunesDecoder

- (NSArray<id<ApiRecord>> * _Nullable)decodeData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error {
    NSDictionary *jsonDictionary = [self getJSONDictionaryFromData:data error:error];
    if (!jsonDictionary) {
        return nil;
    }
    NSArray *jsonArray = [self getJSONArrayFromDictionary:jsonDictionary arrayForKey:ITEMS error:error];
    if (!jsonArray) {
        return nil;
    }
    NSMutableArray<id<ApiRecord>> *itunesRecords = [self createEmptyArrayFromJSONDictionary:jsonDictionary withCapacityForKey:ITEMS_COUNT];
    for (NSDictionary *jsonItem in jsonArray) {
        ITunesRecord *itunesRecord = [self getRecordFromJSONItem:jsonItem];
        [itunesRecords addObject:itunesRecord];
    }
    NSArray<id<ApiRecord>> *resultRecords = [itunesRecords copy];
    return resultRecords;
}

 #pragma mark - Private Methods

- (ITunesRecord *)getRecordFromJSONItem:(NSDictionary *)jsonItem {
    NSString *artist = [jsonItem objectForKey:@"artistName"];
    NSString *track = [jsonItem objectForKey:@"trackName"];
    NSString *artwork = [jsonItem objectForKey:@"artworkUrl100"];
    ITunesRecord *itunesRecord = [[ITunesRecord alloc] initWithArtist:artist track:track artwork:artwork];
    return itunesRecord;
}

@end
