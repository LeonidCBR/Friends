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
    NSArray *jsonArray = [self getJSONArrayFromDictionary:jsonDictionary];
    NSMutableArray<ApiRecord> *githubRecords = [self createEmptyArrayFromJSONDictionary:jsonDictionary withCapacityForKey:@"total_count"];
    for (NSDictionary *jsonItem in jsonArray) {
        GithubRecord *githubRecord = [self getRecordFromJSONItem:jsonItem];
        [githubRecords addObject:githubRecord];
    }
    NSArray<ApiRecord> *resultRecords = [githubRecords copy];
    return resultRecords;
}

#pragma mark - Private Methods

#warning Consider to move the method to super class
- (NSDictionary * _Nonnull)getJSONDictionaryFromData:(NSData * _Nonnull)data {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
#warning TODO: Throw wrong data format error
        return nil;
    }
    if (!jsonObject) {
#warning TODO: Throw wrong data format error
        return nil;
    }
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
#warning TODO: Throw wrong data format error
        return nil;
    }
    return jsonObject;
}

/// Create Mutable Array with particular capacity
- (NSMutableArray<ApiRecord> * _Nonnull)createEmptyArrayFromJSONDictionary:(NSDictionary * _Nonnull)jsonDictionary withCapacityForKey:(NSString *)countKey {
    NSMutableArray<ApiRecord> *apiRecords;
    id totalCount = [jsonDictionary objectForKey:countKey];
    if (totalCount && [totalCount isKindOfClass:[NSNumber class]] && totalCount > 0) {
        NSLog(@"INFO: Create an empty array with capacity = %@", totalCount);
        apiRecords = [NSMutableArray<ApiRecord> arrayWithCapacity:[totalCount intValue]];
    } else {
        NSLog(@"INFO: Create an empty array with default capacity.");
        apiRecords = [NSMutableArray<ApiRecord> array];
    }
    return apiRecords;
}

- (NSArray * _Nonnull)getJSONArrayFromDictionary:(NSDictionary * _Nonnull)jsonDictionary {
    id jsonArray = [jsonDictionary objectForKey:@"items"];

    if (!jsonArray) {
#warning TODO: Throw wrong data format error
        return nil;
    }

    if (![jsonArray isKindOfClass:[NSArray class]]) {
#warning TODO: Throw wrong data format error
        return nil;
    }
    return jsonArray;
}

- (GithubRecord *)getRecordFromJSONItem:(NSDictionary *)jsonItem {
    NSString *login = [jsonItem objectForKey:@"login"];
    NSString *account = [jsonItem objectForKey:@"url"];
    NSString *avatar = [jsonItem objectForKey:@"avatar_url"];
    GithubRecord *githubRecord = [[GithubRecord alloc] initWithLogin:login account:account avatar:avatar];
    return githubRecord;
}

@end
