//
//  RecordsViewModel.m
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import "RecordsViewModel.h"

@interface RecordsViewModel()

@property (strong, nonatomic) DataProvider *dataProvider;
@property (strong, nonatomic) NSArray<id<ApiRecord>> *records;

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
    __weak RecordsViewModel *weakSelf = self;
    [_dataProvider downloadDataForRecordsProviderType:recordsProviderType andSearchText:searchText completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
        id<RecordsDecoder> recordsDecoder = [DecodersFactory getDecoderForRecordsProviderType:recordsProviderType];
        NSArray *decodedRecords = [recordsDecoder decode:data];
        NSLog(@"DEBUG: Got %lu records!", decodedRecords.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setRecords:decodedRecords];
            [weakSelf.delegate handleUpdatedRecordsForProvider:recordsProviderType search:searchText];
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
