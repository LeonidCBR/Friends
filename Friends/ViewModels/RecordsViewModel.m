//
//  RecordsViewModel.m
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import "RecordsViewModel.h"

@interface RecordsViewModel()

@property (strong, nonatomic) id<DataProviderProtocol> dataProvider;
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

- (instancetype)initWithDataProvider:(id<DataProviderProtocol>)dataProvider {
    self = [super init];
    if (self) {
        _dataProvider = dataProvider;
        _records = @[];

#warning TEST
        ITunesRecord *rec1 = [[ITunesRecord alloc] initWithArtist:@"1 Reformed gangster and wrestler Ricky and his wife Julia make a living performing with their children Saraya and Zak." track:@"1 When brother and sister get the chance to audition for WWE, it seems the family dream is coming true but they are about to learn that becoming a WWE Superstar demands more than they ever imagined possible." artwork:nil];
        ITunesRecord *rec2 = [[ITunesRecord alloc] initWithArtist:@"2 Reformed gangster and wrestler Ricky and his wife Julia make a living performing with their children Saraya and Zak." track:@"2 When brother and sister get the chance to audition for WWE, it seems the family dream is coming true but they are about to learn that becoming a WWE Superstar demands more than they ever imagined possible." artwork:nil];
        ITunesRecord *rec3 = [[ITunesRecord alloc] initWithArtist:@"artist 3" track:@"track 3" artwork:nil];

        _records = @[rec1, rec2, rec3];

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
#warning TODO: throw unexpected error
                // [weakSelf handleError:[NSError new! -  error]]
            }
        }
        id<RecordsDecoder> recordsDecoder = [DecodersFactory getDecoderForRecordsProviderType:recordsProviderType];
        NSArray *decodedRecords = [recordsDecoder decode:data];
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

- (Alignment)getAlignmentAtRow:(NSInteger)row {
    id<ApiRecord> record = [_records objectAtIndex:row];
    if ([record isKindOfClass:[GithubRecord class]]) {
        if (row % 2 == 0) {
            return left;
        } else {
            return right;
        }
    } else if ([record isKindOfClass:[ITunesRecord class]]) {
        if (row % 2 == 0) {
            return right;
        } else {
            return left;
        }
    } else {
        /// Return default value
        return left;
    }
}

@end
