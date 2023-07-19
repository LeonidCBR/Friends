//
//  BaseDecoderTests.m
//  FriendsTests
//
//  Created by Яна Латышева on 19.07.2023.
//

#import <XCTest/XCTest.h>
#import "BaseDecoder.h"

@interface BaseDecoderTests : XCTestCase

@property (strong, nonatomic) BaseDecoder *sut;

@end

@implementation BaseDecoderTests

- (void)setUp {
    _sut = [BaseDecoder new];
}

- (void)tearDown {
    _sut = nil;
}

- (void)testBaseDecoder_WhenInvalidDataProvided_ShouldReturnWrongDataFormatError {
    NSString *invalidJSON = @"InvalidJSON";
    NSData *invalidData = [invalidJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dict = [_sut getJSONDictionaryFromData:invalidData error:&error];
    XCTAssertNil(dict);
    XCTAssertNotNil(error);
}

- (void)testBaseDecoder_WhenInvalidDictionaryProviden_ShouldReturnError {
    NSError *error = nil;
    NSDictionary *invalidDict = [NSDictionary dictionary];
    NSArray *array = [_sut getJSONArrayFromDictionary:invalidDict arrayForKey:@"DummyKey" error:&error];
    XCTAssertNil(array);
    XCTAssertNotNil(error);
}

@end
