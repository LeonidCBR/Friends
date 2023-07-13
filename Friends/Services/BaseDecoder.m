//
//  BaseDecoder.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "BaseDecoder.h"

@implementation BaseDecoder

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

- (NSArray * _Nonnull)getJSONArrayFromDictionary:(NSDictionary * _Nonnull)jsonDictionary arrayForKey:(NSString *)arrayKey {
    id jsonArray = [jsonDictionary objectForKey:arrayKey];

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

@end
