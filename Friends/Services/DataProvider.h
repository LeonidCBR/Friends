//
//  DataProvider.h
//  Friends
//
//  Created by Яна Латышева on 11.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RecordsProviderType) {
    iTunes = 0,
    gitHub
};

@interface DataProvider : NSObject

- (instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession;

- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText completionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
