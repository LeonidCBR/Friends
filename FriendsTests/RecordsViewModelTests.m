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
@property (strong, nonatomic) NSError *error;

@end

@implementation RecordsViewModelTests

- (void)setUp {
    _error = nil;
}

- (void)tearDown {
    _sut = nil;
    _error = nil;
}

- (void)testRecordsViewModel_WhenLoadRecords_ShouldCallDelegateHandle {
    /// Arrange
    MockDataProvider *mockDataProvider = [MockDataProvider new];
    NSBundle *bundle = [NSBundle bundleForClass:[RecordsViewModelTests class]];
    NSURL *jsonUrl = [bundle URLForResource:@"github" withExtension:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
    mockDataProvider.shouldReturnData = jsonData;
    mockDataProvider.shouldReturnResponse = nil;
    mockDataProvider.shouldReturnError = nil;
    _sut = [[RecordsViewModel alloc] initWithDataProvider:mockDataProvider];
    _sut.delegate = self;
    RecordsProviderType provider = gitHub;
    NSString *search = @"LeonidC";
    _expectation = [self expectationWithDescription:@"RecordsViewModel Delegate Handle Expectation"];
    /// Act
    [_sut loadRecordsForRecordsProviderType:provider andSearhText:search];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:_expectation, nil] timeout:5];
    /// Assert
    int recordsCount = 30;
    if ([_sut getRecordsCount] != recordsCount) {
        XCTFail("It has been got %ld records instead of %d", [_sut getRecordsCount], recordsCount);
        return;
    }
    id<ApiRecord> record = [_sut getRecordAtRow:9];
    XCTAssertEqualObjects(record.user, @"LeonidCBR");
    XCTAssertEqualObjects(record.label, @"https://api.github.com/users/LeonidCBR");
    XCTAssertEqualObjects(record.iconPath, @"https://avatars.githubusercontent.com/u/44451063?v=4");
}

- (void)testRecordsViewModel_WhenAskGithubAlignment_ShouldReturnValidValue {
    /// Arrange
    MockDataProvider *mockDataProvider = [MockDataProvider new];
    NSBundle *bundle = [NSBundle bundleForClass:[RecordsViewModelTests class]];
    NSURL *jsonUrl = [bundle URLForResource:@"github" withExtension:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
    mockDataProvider.shouldReturnData = jsonData;
    mockDataProvider.shouldReturnResponse = nil;
    mockDataProvider.shouldReturnError = nil;
    _sut = [[RecordsViewModel alloc] initWithDataProvider:mockDataProvider];
    _sut.delegate = self;
    RecordsProviderType provider = gitHub;
    NSString *search = @"LeonidC";
    _expectation = [self expectationWithDescription:@"RecordsViewModel Get Alignment Expectation"];
    /// Act
    [_sut loadRecordsForRecordsProviderType:provider andSearhText:search];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:_expectation, nil] timeout:5];
    /// Assert
    XCTAssertEqual([_sut getAlignmentAtRow:0], left);
    XCTAssertEqual([_sut getAlignmentAtRow:1], right);
    XCTAssertEqual([_sut getAlignmentAtRow:2], left);
}

- (void)testRecordsViewModel_WhenErrorProvided_ShouldCallErrorHandler {
    /// Arrange
    MockDataProvider *mockDataProvider = [MockDataProvider new];
    mockDataProvider.shouldReturnData = nil;
    mockDataProvider.shouldReturnResponse = nil;
    NSMutableDictionary *errorDetails = [NSMutableDictionary dictionary];
    [errorDetails setValue:@"Invalid data format" forKey:NSLocalizedDescriptionKey];
    NSError *stubError = [NSError errorWithDomain:@"Friends" code:901 userInfo:errorDetails];
    mockDataProvider.shouldReturnError = stubError;
    _sut = [[RecordsViewModel alloc] initWithDataProvider:mockDataProvider];
    _sut.delegate = self;
    RecordsProviderType provider = gitHub;
    NSString *search = @"LeonidC";
    _expectation = [self expectationWithDescription:@"RecordsViewModel Delegate Error Expectation"];
    /// Act
    [_sut loadRecordsForRecordsProviderType:provider andSearhText:search];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:_expectation, nil] timeout:5];
    /// Assert
    XCTAssertNotNil(_error);
    XCTAssertEqual(_error.code, 901);
}

#pragma mark - RecordsViewModelDelegate

- (void)handleError:(NSError * _Nullable)error {
    _error = error;
    [_expectation fulfill];
    _expectation = nil;
}

- (void)handleUpdatedRecordsForProvider:(RecordsProviderType)recordsProviderType search:(NSString *)searchText {
    [_expectation fulfill];
    _expectation = nil;
}

@end
