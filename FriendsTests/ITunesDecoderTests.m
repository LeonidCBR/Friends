//
//  ITunesDecoderTests.m
//  FriendsTests
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <XCTest/XCTest.h>
#import "ITunesDecoder.h"
#import "ITunesRecord.h"

@interface ITunesDecoderTests : XCTestCase

@property (strong, nonatomic) ITunesDecoder *sut;

@end

@implementation ITunesDecoderTests

- (void)setUp {
    _sut = [ITunesDecoder new];
}

- (void)tearDown {
    _sut = nil;
}

- (void)testITunesDecoder_WhenGivenValidData_ShouldReturnArrayOfITunesRecords {
    NSBundle *bundle = [NSBundle bundleForClass:[ITunesDecoderTests class]];
    NSURL *jsonUrl = [bundle URLForResource:@"itunes" withExtension:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
    NSArray *itunesRecords = [_sut decode:jsonData];
    XCTAssertNotNil(itunesRecords, "There is no itunes records!");
    int recordsCount = 50;
    if (itunesRecords.count != recordsCount) {
        XCTFail("It has been got %ld iTunes records instead of %d", itunesRecords.count, recordsCount);
        return;
    }
    ITunesRecord *itunesRecord = [itunesRecords objectAtIndex:3];
    XCTAssertEqualObjects(itunesRecord.user, @"Jake Kasdan");
    XCTAssertEqualObjects(itunesRecord.label, @"Jumanji: The Next Level");
    XCTAssertEqualObjects([itunesRecord.icon absoluteString], @"https://is3-ssl.mzstatic.com/image/thumb/Video114/v4/1d/50/26/1d502647-3349-738d-af07-f8714b9ffa8a/pr_source.lsr/100x100bb.jpg");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        NSBundle *bundle = [NSBundle bundleForClass:[ITunesDecoderTests class]];
        NSURL *jsonUrl = [bundle URLForResource:@"itunes" withExtension:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonUrl];
        [_sut decode:jsonData];
    }];
}

@end
