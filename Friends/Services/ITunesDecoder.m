//
//  ITunesDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "ITunesDecoder.h"
#import "ITunesRecord.h"

@implementation ITunesDecoder

#warning TODO: Refactor the method
- (nonnull NSArray<ApiRecord> *)decode:(NSData * _Nonnull)data {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
#warning TODO: Check for error is NULL
    if (error) {
        NSLog(@"ERROR! While parsing data => %@", [error debugDescription]);
    }

    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
#warning TODO: Throw wrong data format error
        return nil;
    }

    NSDictionary *results = jsonObject;
    id items = [results objectForKey:@"results"];

    if (![items isKindOfClass:[NSArray class]]) {
#warning TODO: Throw wrong data format error
        return nil;
    }

    NSMutableArray<ApiRecord> *itunesRecords;

    id totalCount = [results objectForKey:@"resultCount"];
    if (totalCount && [totalCount isKindOfClass:[NSNumber class]] && totalCount > 0) {
        NSLog(@"INFO: Create an empty array with capacity = %@", totalCount);
        itunesRecords = [NSMutableArray<ApiRecord> arrayWithCapacity:[totalCount intValue]];
    } else {
        NSLog(@"INFO: Create an empty array with default capacity.");
        itunesRecords = [NSMutableArray<ApiRecord> array];
    }

    /**
     @property (strong, nonatomic) NSString *artist;
     @property (strong, nonatomic) NSString *track;
     @property (strong, nonatomic) NSString *artwork;
     "artistName":"Jake Kasdan"
     "trackName":"Jumanji: The Next Level"
     "artworkUrl100":"https://is3-ssl.mzstatic.com/image/thumb/Video114/v4/1d/50/26/1d502647-3349-738d-af07-f8714b9ffa8a/pr_source.lsr/100x100bb.jpg"


     */
    for (NSDictionary *record in items) {
        NSString *artist = [record objectForKey:@"artistName"];
        NSString *track = [record objectForKey:@"trackName"];
        NSString *artwork = [record objectForKey:@"artworkUrl100"];
        ITunesRecord *itunesRecord = [[ITunesRecord alloc] initWithArtist:artist track:track artwork:artwork];
        [itunesRecords addObject:itunesRecord];
    }

    NSArray<ApiRecord> *resultRecords = [itunesRecords copy];
    return resultRecords;
}

@end
