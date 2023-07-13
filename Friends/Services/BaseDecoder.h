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

@interface BaseDecoder : NSObject

- (NSDictionary * _Nonnull)getJSONDictionaryFromData:(NSData * _Nonnull)data;

- (NSMutableArray<ApiRecord> * _Nonnull)createEmptyArrayFromJSONDictionary:(NSDictionary * _Nonnull)jsonDictionary withCapacityForKey:(NSString *)countKey;

- (NSArray * _Nonnull)getJSONArrayFromDictionary:(NSDictionary * _Nonnull)jsonDictionary arrayForKey:(NSString *)arrayKey;

@end


NS_ASSUME_NONNULL_END
