//
//  GithubDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "GithubDecoder.h"

@implementation GithubDecoder

- (nonnull NSArray<ApiRecord> *)decode:(NSData * _Nonnull)data {
    NSDictionary *jsonDictionary = [self getJSONDictionaryFromData:data];
    NSArray *jsonArray = [self getJSONArrayFromDictionary:jsonDictionary arrayForKey:@"items"];
    NSMutableArray<ApiRecord> *githubRecords = [self createEmptyArrayFromJSONDictionary:jsonDictionary withCapacityForKey:@"total_count"];
    for (NSDictionary *jsonItem in jsonArray) {
        GithubRecord *githubRecord = [self getRecordFromJSONItem:jsonItem];
        [githubRecords addObject:githubRecord];
    }
    NSArray<ApiRecord> *resultRecords = [githubRecords copy];
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
