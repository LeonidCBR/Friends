//
//  RecordsViewModel.h
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import <Foundation/Foundation.h>
#import "DataProvider.h"
#import "GithubDecoder.h"
#import "ITunesDecoder.h"
#import "DecodersFactory.h"
#import "Alignment.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RecordsViewModelDelegate;

/// A view model of records
@interface RecordsViewModel : NSObject

/// A delegate will be notified of updated records or received errors
@property(nullable, nonatomic, weak) id<RecordsViewModelDelegate> delegate;

- (instancetype)init;

- (instancetype)initWithDataProvider:(id<DataProviderProtocol>)dataProvider;

/// Get count of fetched records
- (NSInteger)getRecordsCount;

/// Load records for a specific API provider
- (void)loadRecordsForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearhText:(NSString *)searchText;

/// Get the record at specific row
- (id<ApiRecord>)getRecordAtRow:(NSInteger)row;

/// Get the alignment at specific row
- (Alignment)getAlignmentAtRow:(NSInteger)row;

@end

@protocol RecordsViewModelDelegate <NSObject>

/// Notify the delegate that records of the view model were updated
- (void)handleUpdatedRecordsForProvider:(RecordsProviderType)recordsProviderType search:(NSString *)searchText;

/// Notify the delegate there is an error while loading data
- (void)handleError:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
