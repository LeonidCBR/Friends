//
//  DataProvider.h
//  Friends
//
//  Created by Яна Латышева on 11.07.2023.
//

#import <Foundation/Foundation.h>
#import "DataProviderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// A service provides data from API endpoints
@interface DataProvider : NSObject <DataProviderProtocol>

- (instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession;

/// Loads data for particular endpoint
///
/// - Parameters:
///   - recordsProviderType: There are two types: iTunes and GitHub.
///   - searchText: The text for searching.
///   - completionHandler: The completion handler to call when the load request is complete.
- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
