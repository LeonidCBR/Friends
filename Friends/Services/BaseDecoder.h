//
//  BaseDecoder.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>
#import "RecordsDecoder.h"
#import "GithubRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// Abstract class
@interface BaseDecoder : NSObject

- (NSDictionary * _Nullable)getJSONDictionaryFromData:(NSData * _Nonnull)data error:(NSError * _Nullable *)error;

- (NSMutableArray<id<ApiRecord>> * _Nonnull)createEmptyArrayFromJSONDictionary:(NSDictionary * _Nonnull)jsonDictionary withCapacityForKey:(NSString *)countKey;

- (NSArray * _Nullable)getJSONArrayFromDictionary:(NSDictionary * _Nonnull)jsonDictionary arrayForKey:(NSString *)arrayKey error:(NSError * _Nullable *)error;

@end


NS_ASSUME_NONNULL_END
