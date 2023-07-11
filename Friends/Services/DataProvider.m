//
//  DataProvider.m
//  Friends
//
//  Created by Яна Латышева on 11.07.2023.
//

#define API_GITHUB @"https://api.github.com/search/users?q="
#define API_ITUNES @"https://itunes.apple.com/search?term="

#import "DataProvider.h"

@interface DataProvider ()

@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation DataProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _urlSession = NSURLSession.sharedSession;
    }
    return self;
}

- (instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession {
    self = [super init];
    if (self) {
        _urlSession = urlSession;
    }
    return self;
}

- (void)downloadDataForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText completionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    NSLog(@"Downloading data for %ld", (long)recordsProviderType);
    NSString *urlString = [self getUrlStringForRecordsProviderType:recordsProviderType andSearchText:searchText];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [[_urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, error);
    }] resume];
}

- (NSString *)getUrlStringForRecordsProviderType:(RecordsProviderType)recordsProviderType andSearchText:(NSString *)searchText {
    NSString *urlString;
    switch (recordsProviderType) {
        case iTunes:
            urlString = [NSString stringWithFormat:@"%@%@", API_ITUNES, searchText];
            break;
        case gitHub:
            urlString = [NSString stringWithFormat:@"%@%@", API_GITHUB, searchText];
            break;
        default:
            NSLog(@"Unexpected records provider type!");
            urlString = @"";
            break;
    }
    return [urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

@end
