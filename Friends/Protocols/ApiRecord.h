//
//  ApiRecord.h
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A type that holds basic data and can be used in order to display the information
@protocol ApiRecord <NSObject>

/// A user
- (NSString * _Nonnull)user;

/// Additional information
- (NSString * _Nonnull)label;

/// A string with URL to an icon or an image
- (NSString * _Nullable)iconPath;

@end

NS_ASSUME_NONNULL_END
