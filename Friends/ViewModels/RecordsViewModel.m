//
//  RecordsViewModel.m
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import "RecordsViewModel.h"

@interface RecordsViewModel()

@property (strong, nonatomic) DataProvider *dataProvider;
@property (strong, nonatomic) NSArray *records;

@end

@implementation RecordsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataProvider = [DataProvider new];
        _records = @[];
    }
    return self;
}

- (instancetype)initWithDataProvider:(DataProvider *)dataProvider {
    self = [super init];
    if (self) {
        _dataProvider = dataProvider;
        _records = @[];
    }
    return self;
}

- (NSInteger)getRecordsCount {
    return _records.count;
}

- (void)loadRecordsForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearhText:(NSString *)searchText {
    NSLog(@"TODO - loading data with search text [%@] for provider %ld...", searchText, recordsProviderType);
    __weak RecordsViewModel *weakSelf = self;
    [_dataProvider downloadDataForRecordsProviderType:recordsProviderType andSearchText:searchText completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
#warning REMEMBER about background queue
        if (!data) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.delegate handleError:error];
                });
            } else {
                // main queue
#warning TODO: throw error
                // [weakSelf handleError:[NSError new! - unexpected error]]
                NSLog(@"DEBUG: There is neither data nor error");
            }
        }
#warning TODO - Create FactoryDecoders
        id<RecordsDecoder> recordsDecoder;
        switch (recordsProviderType) {
            case iTunes:
                recordsDecoder = [ITunesDecoder new];
                break;
            case gitHub:
                recordsDecoder = [GithubDecoder new];
                break;
            default:
                NSLog(@"Unexpected records provider type!");
                recordsDecoder = nil;
                break;
        }
        NSArray *decodedRecords = [recordsDecoder decode:data];
        NSLog(@"DEBUG: Got %lu records!", decodedRecords.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setRecords:decodedRecords];
            [weakSelf.delegate handleUpdatedRecords];
        });
    }];
}

- (id<ApiRecord>)getRecordAtRow:(NSInteger)row {
    if (row < 0 || row >= _records.count) {
        return nil;
    }
    return [_records objectAtIndex:row];
}

@end
