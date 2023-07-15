//
//  RecordsViewModelDelegate.h
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RecordsViewModelDelegate <NSObject>

- (void)handleUpdatedRecords;

- (void)handleError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
