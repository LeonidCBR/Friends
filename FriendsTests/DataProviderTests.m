//
//  DataProviderTests.m
//  FriendsTests
//
//  Created by Яна Латышева on 11.07.2023.
//

#import <XCTest/XCTest.h>
#import "DataProvider.h"
#import "MockURLProtocol.h"

@interface DataProvider (Testing)

- (NSString *)getUrlStringForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText;

@end

@interface DataProviderTests : XCTestCase

@property (strong, nonatomic) DataProvider *sut;

@end

@implementation DataProviderTests

- (void)setUp {
    NSURLSessionConfiguration *ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration;
    NSArray<Class> *classes = [[NSArray alloc] initWithObjects:[MockURLProtocol class], nil];
    ephemeralConfig.protocolClasses = classes;
    NSURLSession *ephemeralSession = [NSURLSession sessionWithConfiguration:ephemeralConfig];
    _sut = [[DataProvider alloc] initWithUrlSession:ephemeralSession];
}

- (void)tearDown {
    _sut = nil;
//    stubResponse = nil;
//    stubData = nil;
    error = nil;
}

- (void)testDataProvider_WhenGivenGithubParameters_ShouldReturnValidURLString {
    RecordsProviderType recordsProviderType = gitHub;
    NSString *searchText = @"LeonidC";
    NSString *urlString = [_sut getUrlStringForRecordsProviderType:recordsProviderType andSearchText:searchText];
    XCTAssertEqualObjects(urlString, @"https://api.github.com/search/users?q=LeonidC");
}

- (void)testDataProvider_WhenGivenITunesParameters_ShouldReturnValidURLString {
    RecordsProviderType recordsProviderType = iTunes;
    NSString *searchText = @"jack johnson";
    NSString *urlString = [_sut getUrlStringForRecordsProviderType:recordsProviderType andSearchText:searchText];
    XCTAssertEqualObjects(urlString, @"https://itunes.apple.com/search?term=jack+johnson");
}

- (void)testDataProvider_WhenGivenSuccessfullResponse_ReturnsSuccess {
//    NSURL *testUrl = [[NSURL alloc] initWithString:@"https://localhost"];
//    NSArray *objects = [[NSArray alloc] initWithObjects:@"Content-Type", nil];
//    NSArray *keys = [[NSArray alloc] initWithObjects:@"application/json", nil];
//    NSDictionary *testHeaders = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
//    NSHTTPURLResponse *testResponse = [[NSHTTPURLResponse alloc]
//                                       initWithURL:testUrl
//                                       statusCode:200
//                                       HTTPVersion:@"1.1"
//                                       headerFields:testHeaders];
//    stubResponse = testResponse;
//    stubData = testData;
    error = nil;
    RecordsProviderType recordsProviderType = gitHub;
    XCTestExpectation *expectation = [self expectationWithDescription:@"NetworkProvider Response Expectation"];
    [_sut downloadDataForRecordsProviderType:recordsProviderType andSearchText:@"test" completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        XCTAssertNil(error, @"downloadData error %@", error);
        XCTAssertNotNil(data);
        NSString *testString = @"{\"status\":\"ok\"}";
        NSData *testData = [testString dataUsingEncoding:NSUTF8StringEncoding];
        XCTAssertEqualObjects(data, testData);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5];
}

@end
