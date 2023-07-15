//
//  GithubDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#define ITEMS @"items"
#define ITEMS_COUNT @"total_count"

#import "GithubDecoder.h"

@implementation GithubDecoder

- (nonnull NSArray<id<ApiRecord>> *)decode:(NSData * _Nonnull)data {
    NSDictionary *jsonDictionary = [self getJSONDictionaryFromData:data];
    NSArray *jsonArray = [self getJSONArrayFromDictionary:jsonDictionary arrayForKey:ITEMS];
    NSMutableArray<id<ApiRecord>> *githubRecords = [self createEmptyArrayFromJSONDictionary:jsonDictionary withCapacityForKey:ITEMS_COUNT];
    for (NSDictionary *jsonItem in jsonArray) {
        GithubRecord *githubRecord = [self getRecordFromJSONItem:jsonItem];
        [githubRecords addObject:githubRecord];
    }
    NSArray<id<ApiRecord>> *resultRecords = [githubRecords copy];
    return resultRecords;
}

 #pragma mark - Private Methods

- (GithubRecord *)getRecordFromJSONItem:(NSDictionary *)jsonItem {
    NSString *login = [jsonItem objectForKey:@"login"];
    NSString *account = [jsonItem objectForKey:@"url"];
    NSString *avatar = [jsonItem objectForKey:@"avatar_url"];
    GithubRecord *githubRecord = [[GithubRecord alloc] initWithLogin:login account:account avatar:avatar];
    return githubRecord;
}

@end
