//
//  DataProviderProtocol.h
//  Friends
//
//  Created by Яна Латышева on 16.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 There are two API services:
 - Apple search API (iTunes)
 - GitHub search API (Users)
 */
typedef NS_ENUM(NSInteger, RecordsProviderType) {
    iTunes = 0,
    gitHub
};

/// A type that loads data from API endpoint
@protocol DataProviderProtocol <NSObject>
/// Loads data for a specific API service.
///
/// - Parameters:
///   - recordsProviderType: The type of API service.
///   - searchText: The text for searching.
///   - completionHandler: The completion handler to call when the load request is complete.
- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
