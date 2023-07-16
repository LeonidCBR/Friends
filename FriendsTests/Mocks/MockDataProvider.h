//
//  MockDataProvider.h
//  FriendsTests
//
//  Created by Яна Латышева on 16.07.2023.
//

#import <Foundation/Foundation.h>
#import "DataProviderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockDataProvider : NSObject <DataProviderProtocol>

@property (strong, nonatomic, nullable) NSData *shouldReturnData;
@property (strong, nonatomic, nullable) NSURLResponse *shouldReturnResponse;
@property (strong, nonatomic, nullable) NSError *shouldReturnError;

@end

NS_ASSUME_NONNULL_END
