//
//  ImageProvider.m
//  Friends
//
//  Created by Яна Латышева on 18.07.2023.
//

#import "ImageProvider.h"

@interface ImageProvider ()

@property (strong, nonatomic) NSURLSession *urlSession;
@property (strong, atomic) NSCache *cacheImages;
@property (strong, atomic) NSMutableDictionary *loadingStateItems;

@end

@implementation ImageProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:defaultConfiguration];
        _cacheImages = [NSCache new];
        _loadingStateItems = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession {
    self = [super init];
    if (self) {
        _urlSession = urlSession;
        _cacheImages = [NSCache new];
        _loadingStateItems = [NSMutableDictionary new];
    }
    return self;
}

- (void)getImageWithPath:(NSString * _Nonnull)imagePath completionHandler:(void (^)(UIImage * _Nullable, NSString * _Nonnull, NSError * _Nullable))completion {
    /// Check if image exists in cache
    UIImage *cachedImage = [_cacheImages objectForKey:imagePath];
    if (cachedImage) {
        completion(cachedImage, imagePath, nil);
        return;
    }
    /// Check loading status to prevent multiple downloads
    if ([[_loadingStateItems objectForKey:imagePath] boolValue] == YES) {
        return;
    }
    /// There is no image in cache. Downloading...
    NSURL *imageURL = [NSURL URLWithString:imagePath];
    /// Start loading
    [_loadingStateItems setObject:@YES forKey:imagePath];
    __weak ImageProvider *weakSelf = self;
    [[_urlSession downloadTaskWithURL:imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.loadingStateItems setObject:@NO forKey:imagePath];
            if (!location) {
                if (error)
                {
                    completion(nil, imagePath, error);
                    return;
                } else {
                    NSMutableDictionary *details = [NSMutableDictionary dictionary];
                    [details setValue:@"Missing data" forKey:NSLocalizedDescriptionKey];
                    NSError *nodataError = [NSError errorWithDomain:@"Friends" code:903 userInfo:details];
                    completion(nil, imagePath, nodataError);
                    return;
                }
            }
            NSData *imageData = [NSData dataWithContentsOfURL:location];
            if (!imageData) {
                NSMutableDictionary *details = [NSMutableDictionary dictionary];
                [details setValue:@"Missing data" forKey:NSLocalizedDescriptionKey];
                NSError *nodataError = [NSError errorWithDomain:@"Friends" code:903 userInfo:details];
                completion(nil, imagePath, nodataError);
                return;
            }
            UIImage *downloadedImage = [UIImage imageWithData:imageData];
            if (!downloadedImage) {
                NSMutableDictionary *details = [NSMutableDictionary dictionary];
                [details setValue:@"Invalid data format" forKey:NSLocalizedDescriptionKey];
                NSError *invalidDataError = [NSError errorWithDomain:@"Friends" code:901 userInfo:details];
                completion(nil, imagePath, invalidDataError);
                return;
            }
            [weakSelf.cacheImages setObject:downloadedImage forKey:imagePath];
            completion(downloadedImage, imagePath, nil);
        }); // dispatch main async
    }] resume];

}

@end
