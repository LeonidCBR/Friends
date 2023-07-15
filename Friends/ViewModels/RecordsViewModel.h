//
//  RecordsViewModel.h
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import <Foundation/Foundation.h>
#import "RecordsViewModelDelegate.h"
#import "DataProvider.h"
#import "GithubDecoder.h"
#import "ITunesDecoder.h"
#import "DecodersFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordsViewModel : NSObject

@property(nullable, nonatomic, weak) id<RecordsViewModelDelegate> delegate;

- (instancetype)init;

- (instancetype)initWithDataProvider:(DataProvider *)dataProvider;

- (NSInteger)getRecordsCount;

- (void)loadRecordsForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearhText:(NSString *)searchText;

- (id<ApiRecord>)getRecordAtRow:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
