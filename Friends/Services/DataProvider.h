//
//  DataProvider.h
//  Friends
//
//  Created by Яна Латышева on 11.07.2023.
//

#import <Foundation/Foundation.h>
#import "DataProviderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataProvider : NSObject <DataProviderProtocol>

- (instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession;

- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
