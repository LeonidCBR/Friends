//
//  RecordCell.h
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import <UIKit/UIKit.h>
#import "Alignment.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordCell : UITableViewCell

@property (strong, nonatomic) NSString *iconImagePath;

- (void)setUserName:(NSString *)userName;

- (void)setDescription:(NSString *)description;

- (void)setIconImage:(UIImage *)iconImage;

-(void)updateUIWithAlignment:(Alignment)alignment;

@end

NS_ASSUME_NONNULL_END
