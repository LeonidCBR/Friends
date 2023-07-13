//
//  ApiRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ApiRecord <NSObject>

- (nonnull NSString *)user;

- (nonnull NSString *)label;

- (NSURL *)icon;

@end

NS_ASSUME_NONNULL_END
