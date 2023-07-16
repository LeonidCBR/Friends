//
//  RecordsViewModelTests.m
//  FriendsTests
//
//  Created by Яна Латышева on 16.07.2023.
//

#import <XCTest/XCTest.h>
#import "RecordsViewModel.h"

@interface RecordsViewModelTests : XCTestCase <RecordsViewModelDelegate>

@property (strong, nonatomic) RecordsViewModel *sut;
//@property (strong, nonatomic) NSString *search;
//@property (nonatomic) RecordsProviderType provider;
@property (strong, nonatomic) XCTestExpectation *expectation;

@end

@implementation RecordsViewModelTests

- (void)setUp {
    _sut = [RecordsViewModel new];
    _sut.delegate = self;
}

- (void)tearDown {
    _sut = nil;
}

- (void)testRecordsViewModel_WhenLoadRecords_ShouldCallDelegateHandle {
    RecordsProviderType provider = gitHub;
    NSString *search = @"LeonidC";
//    _provider = gitHub;
//    _search = @"LeonidC";
    _expectation = [self expectationWithDescription:@"RecordsViewModel Delegate Handle Expectation"];
    [_sut loadRecordsForRecordsProviderType:provider andSearhText:search];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:_expectation, nil] timeout:5];
    int recordsCount = 30;
    if ([_sut getRecordsCount] != recordsCount) {
        XCTFail("It has been got %ld records instead of %d", [_sut getRecordsCount], recordsCount);
        return;
    }
    id<ApiRecord> record = [_sut getRecordAtRow:9];
    XCTAssertEqualObjects(record.user, @"LeonidCBR");
    XCTAssertEqualObjects(record.label, @"https://api.github.com/users/LeonidCBR");
    XCTAssertEqualObjects([record.icon absoluteString], @"https://avatars.githubusercontent.com/u/44451063?v=4");
}

- (void)handleError:(nonnull NSError *)error {
    NSLog(@"DEBUG: RecordsViewModelTests delegate handleError: %@", error);
}

- (void)handleUpdatedRecordsForProvider:(RecordsProviderType)recordsProviderType search:(NSString *)searchText {
//    NSLog(@"DEBUG: RecordsViewModelTests[%@, %ld] delegate calls handle records with search %@ for %ld", _search, _provider, searchText, recordsProviderType);
//    XCTAssertEqualObjects(_search, searchText);
//    XCTAssertEqual(_provider, recordsProviderType);
    [_expectation fulfill];
    _expectation = nil;
}

@end
