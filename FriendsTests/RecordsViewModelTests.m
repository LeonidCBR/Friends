//
//  RecordsViewModelTests.m
//  FriendsTests
//
//  Created by Яна Латышева on 16.07.2023.
//

#import <XCTest/XCTest.h>
#import "RecordsViewModel.h"
#import "MockDataProvider.h"

@interface RecordsViewModelTests : XCTestCase <RecordsViewModelDelegate>

@property (strong, nonatomic) RecordsViewModel *sut;
@property (strong, nonatomic) XCTestExpectation *expectation;

@end

@implementation RecordsViewModelTests

- (void)setUp {
    MockDataProvider *mockDataProvider = [MockDataProvider new];
    NSBundle *bundle = [NSBundle bundleForClass:[RecordsViewModelTests class]];
    NSURL *jsonUrl = [bundle URLForResource:@"github" withExtension:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
    mockDataProvider.shouldReturnData = jsonData;
    mockDataProvider.shouldReturnResponse = nil;
    mockDataProvider.shouldReturnError = nil;
    _sut = [[RecordsViewModel alloc] initWithDataProvider:mockDataProvider];
    _sut.delegate = self;
}

- (void)tearDown {
    _sut = nil;
}

- (void)testRecordsViewModel_WhenLoadRecords_ShouldCallDelegateHandle {
    RecordsProviderType provider = gitHub;
    NSString *search = @"LeonidC";
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
    [_expectation fulfill];
    _expectation = nil;
}

@end
