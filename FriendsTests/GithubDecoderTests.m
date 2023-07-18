//
//  GithubDecoderTests.m
//  FriendsTests
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <XCTest/XCTest.h>
#import "GithubDecoder.h"

@interface GithubDecoderTests : XCTestCase

@property (strong, nonatomic) GithubDecoder *sut;

@end

@implementation GithubDecoderTests

- (void)setUp {
    _sut = [GithubDecoder new];
}

- (void)tearDown {
    _sut = nil;
}

- (void)testGithubDecoder_WhenGivenValidData_ShouldReturnArrayOfGithubRecords {
    NSBundle *bundle = [NSBundle bundleForClass:[GithubDecoderTests class]];
    NSURL *jsonUrl = [bundle URLForResource:@"github" withExtension:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
    NSArray *githubRecords = [_sut decode:jsonData];
    XCTAssertNotNil(githubRecords, "There is no github records!");
//    XCTAssertEqual(githubRecords.count, 100);
    int recordsCount = 30;
    if (githubRecords.count != recordsCount) {
        XCTFail("It has been got %ld github records instead of %d", githubRecords.count, recordsCount);
        return;
    }
    GithubRecord *githubRecord = [githubRecords objectAtIndex:9];
    XCTAssertEqualObjects(githubRecord.user, @"LeonidCBR");
    XCTAssertEqualObjects(githubRecord.label, @"https://api.github.com/users/LeonidCBR");
    XCTAssertEqualObjects(githubRecord.iconPath, @"https://avatars.githubusercontent.com/u/44451063?v=4");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        NSBundle *bundle = [NSBundle bundleForClass:[GithubDecoderTests class]];
        NSURL *jsonUrl = [bundle URLForResource:@"github" withExtension:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
        [_sut decode:jsonData];
    }];
}

@end
