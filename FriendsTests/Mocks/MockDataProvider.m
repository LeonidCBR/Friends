//
//  MockDataProvider.m
//  FriendsTests
//
//  Created by Яна Латышева on 16.07.2023.
//

#import "MockDataProvider.h"

@implementation MockDataProvider

- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(nonnull NSString *)searchText completionHandler:(nonnull void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler { 
    completionHandler(_shouldReturnData, _shouldReturnResponse, _shouldReturnError);
}

@end
