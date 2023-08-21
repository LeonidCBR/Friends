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

- (NSArray<id<ApiRecord>> * _Nullable)decodeData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error {
    NSDictionary *jsonDictionary = [self getJSONDictionaryFromData:data error:error];
    if (!jsonDictionary) {
        return nil;
    }
    NSArray *jsonArray = [self getJSONArrayFromDictionary:jsonDictionary arrayForKey:ITEMS error:error];
    if (!jsonArray) {
        return nil;
    }
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
