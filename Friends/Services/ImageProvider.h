//
//  ImageProvider.h
//  Friends
//
//  Created by Яна Латышева on 18.07.2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageProvider : NSObject

- (instancetype)init;

- (instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession;

- (void)getImageWithPath:(NSString * _Nonnull)imagePath completionHandler:(void (^)(UIImage * _Nullable image, NSString * imagePath, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
