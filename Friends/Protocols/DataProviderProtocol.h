//
//  DataProviderProtocol.h
//  Friends
//
//  Created by Яна Латышева on 16.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RecordsProviderType) {
    iTunes = 0,
    gitHub
};

@protocol DataProviderProtocol <NSObject>

- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
