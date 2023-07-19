//
//  RecordCell.h
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import <UIKit/UIKit.h>
#import "Alignment.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RecordCellDelegate;

@interface RecordCell : UITableViewCell

@property (strong, nonatomic) NSString *iconImagePath;

@property(nullable, nonatomic, weak) id<RecordCellDelegate> delegate;

- (void)setUserName:(NSString *)userName;

- (void)setDescription:(NSString *)description;

- (void)setIconImage:(UIImage * _Nullable)iconImage;

-(void)updateUIWithAlignment:(Alignment)alignment;

@end

@protocol RecordCellDelegate <NSObject>

- (void)handleTapForImageView:(UIImageView * _Nonnull)imageView;

@end

NS_ASSUME_NONNULL_END
