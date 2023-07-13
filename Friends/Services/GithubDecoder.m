//
//  GithubDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "GithubDecoder.h"

@implementation GithubDecoder

#warning TODO: Refactor the method
- (nonnull NSArray<ApiRecord> *)decode:(NSData * _Nonnull)data {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
#warning TODO: Check for error is NULL

    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
#warning TODO: Throw wrong data format error
        return nil;
    }

    NSDictionary *results = jsonObject;
    id items = [results objectForKey:@"items"];

    if (![items isKindOfClass:[NSArray class]]) {
#warning TODO: Throw wrong data format error
        return nil;
    }

    NSMutableArray<ApiRecord> *githubRecords;

    id totalCount = [results objectForKey:@"total_count"];
    if (totalCount && [totalCount isKindOfClass:[NSNumber class]] && totalCount > 0) {
        NSLog(@"INFO: Create an empty array with capacity = %@", totalCount);
        githubRecords = [NSMutableArray<ApiRecord> arrayWithCapacity:[totalCount intValue]];
    } else {
        NSLog(@"INFO: Create an empty array with default capacity.");
        githubRecords = [NSMutableArray<ApiRecord> array];
    }

    for (NSDictionary *record in items) {
        NSString *login = [record objectForKey:@"login"];
        NSString *account = [record objectForKey:@"url"];
        NSString *avatar = [record objectForKey:@"avatar_url"];
        GithubRecord *githubRecord = [[GithubRecord alloc] initWithLogin:login account:account avatar:avatar];
        [githubRecords addObject:githubRecord];
    }

    NSArray<ApiRecord> *resultRecords = [githubRecords copy];
    return resultRecords;
}

@end
