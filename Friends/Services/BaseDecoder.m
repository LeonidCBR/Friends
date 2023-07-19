//
//  BaseDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "BaseDecoder.h"

@implementation BaseDecoder

- (NSDictionary * _Nullable)getJSONDictionaryFromData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (!jsonObject) {
        return nil;
    }
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        [details setValue:@"Invalid data format" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"Friends" code:901 userInfo:details];
        return nil;
    }
    return jsonObject;
}

/// Create Mutable Array with particular capacity
- (NSMutableArray<id<ApiRecord>> * _Nonnull)createEmptyArrayFromJSONDictionary:(NSDictionary * _Nonnull)jsonDictionary withCapacityForKey:(NSString *)countKey {
    NSMutableArray<id<ApiRecord>> *apiRecords;
    id totalCount = [jsonDictionary objectForKey:countKey];
    if (totalCount && [totalCount isKindOfClass:[NSNumber class]] && totalCount > 0) {
        /// Create an empty array with <totalCount> capacity
        apiRecords = [NSMutableArray<id<ApiRecord>> arrayWithCapacity:[totalCount intValue]];
    } else {
        /// Create an empty array with default capacity
        apiRecords = [NSMutableArray<id<ApiRecord>> array];
    }
    return apiRecords;
}

- (NSArray * _Nullable)getJSONArrayFromDictionary:(NSDictionary * _Nonnull)jsonDictionary arrayForKey:(NSString *)arrayKey error:(NSError * _Nullable *)error {
    id jsonArray = [jsonDictionary objectForKey:arrayKey];
    if (!jsonArray || ![jsonArray isKindOfClass:[NSArray class]]) {
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        [details setValue:@"Invalid data format" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"Friends" code:901 userInfo:details];
        return nil;
    }
    return jsonArray;
}

@end
