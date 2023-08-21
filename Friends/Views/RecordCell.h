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

/// A cell that displays content of record
@interface RecordCell : UITableViewCell

/// URL string to an image of an icon
@property (strong, nonatomic) NSString *iconImagePath;

/// A delegate
@property(nullable, nonatomic, weak) id<RecordCellDelegate> delegate;

/// Sets a user name
- (void)setUserName:(NSString *)userName;

/// Sets an additional information
- (void)setDescription:(NSString *)description;

/// Sets an image of an icon
- (void)setIconImage:(UIImage * _Nullable)iconImage;

/// Sets an alignment of content in the cell
-(void)updateUIWithAlignment:(Alignment)alignment;

@end

@protocol RecordCellDelegate <NSObject>

/// Asks a delegate to handle tapping of a user to an icon
- (void)handleTapForImageView:(UIImageView * _Nonnull)imageView;

@end

NS_ASSUME_NONNULL_END
