//
//  ApiRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ApiRecord <NSObject>

- (NSString * _Nonnull)user;

- (NSString * _Nonnull)label;

- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
