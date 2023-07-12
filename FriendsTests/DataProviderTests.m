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
    MockURLProtocol.stubError = nil;
    MockURLProtocol.stubData = nil;
    MockURLProtocol.stubResponse = nil;
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
    /// Set up stub error
    MockURLProtocol.stubError = nil;
    /// Set up stub data
    NSString *stubString = @"{\"status\":\"ok\"}";
    NSData *stubData = [stubString dataUsingEncoding:NSUTF8StringEncoding];
    MockURLProtocol.stubData = stubData;
    /// Set up stub response
    NSArray *objects = [[NSArray alloc] initWithObjects:@"Content-Type", nil];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"application/json", nil];
    NSDictionary *stubHeaders = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSURL *stubUrl = [[NSURL alloc] initWithString:@"https://localhost"];
    NSHTTPURLResponse *stubResponse = [[NSHTTPURLResponse alloc]
                                       initWithURL:stubUrl
                                       statusCode:200
                                       HTTPVersion:@"1.1"
                                       headerFields:stubHeaders];
    MockURLProtocol.stubResponse = stubResponse;
    
    RecordsProviderType recordsProviderType = gitHub;
    XCTestExpectation *expectation = [self expectationWithDescription:@"NetworkProvider Response Expectation"];
    [_sut downloadDataForRecordsProviderType:recordsProviderType andSearchText:@"test" completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        XCTAssertNil(error, @"downloadData error %@", error);
        XCTAssertNotNil(data);
        XCTAssertEqualObjects(data, stubData);
        XCTAssertNotNil(response);
        XCTAssertTrue([response isKindOfClass:[NSHTTPURLResponse class]]);
        XCTAssertEqualObjects([response.URL absoluteString], @"https://localhost");
        XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
        NSString *contentType = [(NSHTTPURLResponse *)response valueForHTTPHeaderField:@"application/json"];
        XCTAssertEqualObjects(contentType, @"Content-Type");
        [expectation fulfill];
    }];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5];
}

@end
