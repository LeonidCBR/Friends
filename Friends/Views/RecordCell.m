//
//  RecordCell.m
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import "RecordCell.h"

@interface RecordCell ()

@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (nonatomic) Alignment alignment;
#warning Refactor - group to array
@property (strong, nonatomic) NSLayoutConstraint *iconWithContentViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint *userLabelWithIconConstraint;
@property (strong, nonatomic) NSLayoutConstraint *iconWithDescriptionLabelConstraint;
@property (strong, nonatomic) NSLayoutConstraint *userLabelWithContentViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint *descriptionLabelWithContentViewConstraint;

@end

@implementation RecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userLabel = [UILabel new];
        _descriptionLabel = [UILabel new];
        _iconImageView = [UIImageView new];
        _iconWithContentViewConstraint = nil;
        _userLabelWithIconConstraint = nil;
        _iconWithDescriptionLabelConstraint = nil;
        _userLabelWithContentViewConstraint = nil;
        _descriptionLabelWithContentViewConstraint = nil;
        _alignment = none;
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureIcon];
    [self configureUserLabel];
    [self configureDescriptionLabel];
    [self configureImmutableConstraints];
}

- (void)configureIcon {
    _iconImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_iconImageView];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_iconImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleIconTap:)];
    [_iconImageView addGestureRecognizer:tap];
}

- (void)configureUserLabel {
    _userLabel.numberOfLines = 0;
    [self.contentView addSubview:_userLabel];
    _userLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)configureDescriptionLabel {
    _descriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)configureImmutableConstraints {
    [NSLayoutConstraint activateConstraints:
         [[NSArray alloc] initWithObjects:
          [_iconImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
          [_iconImageView.widthAnchor constraintEqualToConstant:60.0],
          [_iconImageView.heightAnchor constraintEqualToConstant:60.0],
          [_iconImageView.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:8.0],
          [_iconImageView.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:-8.0],
          [_userLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
          [_descriptionLabel.topAnchor constraintGreaterThanOrEqualToAnchor:_userLabel.bottomAnchor constant:12.0],
          [_descriptionLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-12.0],
          nil]
    ];
}

- (void)setUserName:(NSString *)userName {
    _userLabel.text = userName;
}

- (void)setDescription:(NSString *)description {
    _descriptionLabel.text = description;
}

- (void)setIconImage:(UIImage * _Nullable)iconImage {
    [_iconImageView setImage:iconImage];
}

- (void)updateUIWithAlignment:(Alignment)alignment {
    if (_alignment == alignment) {
        return;
    } else {
        _alignment = alignment;
        switch (_alignment) {
            case left:
                [self setLeftAlign];
                break;
            case right:
                [self setRightAlign];
            default:
                break;
        }
    }
}

- (void)handleIconTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (tapGestureRecognizer
        && (tapGestureRecognizer.view)
        && [tapGestureRecognizer.view isMemberOfClass:[UIImageView class]]) {
        UIImageView *tappedImage = (UIImageView *)tapGestureRecognizer.view;
        [_delegate handleTapForImageView:tappedImage];
    }
}

#pragma mark - Left Alignment

- (void)setLeftAlign {
#warning Refactor the method
    if ([_iconWithContentViewConstraint isActive]) {
        [_iconWithContentViewConstraint setActive:NO];
    }
    if ([_userLabelWithIconConstraint isActive]) {
        [_userLabelWithIconConstraint setActive:NO];
    }
    if ([_userLabelWithContentViewConstraint isActive]) {
        [_userLabelWithContentViewConstraint setActive:NO];
    }
    if ([_iconWithDescriptionLabelConstraint isActive]) {
        [_iconWithDescriptionLabelConstraint setActive:NO];
    }
    if ([_descriptionLabelWithContentViewConstraint isActive]) {
        [_descriptionLabelWithContentViewConstraint setActive:NO];
    }

    _iconWithContentViewConstraint = [NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:8.0];
    [_iconWithContentViewConstraint setActive:YES];

    /// User label
    [_userLabel setTextAlignment:NSTextAlignmentLeft];
    _userLabelWithIconConstraint = [NSLayoutConstraint constraintWithItem:_userLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_iconImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:16.0];
    [_userLabelWithIconConstraint setActive:YES];

    _userLabelWithContentViewConstraint = [NSLayoutConstraint constraintWithItem:_userLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16.0];
    [_userLabelWithContentViewConstraint setActive:YES];

    /// Description label
    [_descriptionLabel setTextAlignment:NSTextAlignmentLeft];

    _iconWithDescriptionLabelConstraint = [NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_descriptionLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-16.0];
    [_iconWithDescriptionLabelConstraint setActive:YES];

    _descriptionLabelWithContentViewConstraint = [NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16.0];
    [_descriptionLabelWithContentViewConstraint setActive:YES];
}

#pragma mark - Right Alignment

- (void)setRightAlign {
#warning Refactor the method
    if ([_iconWithContentViewConstraint isActive]) {
        [_iconWithContentViewConstraint setActive:NO];
    }
    if ([_userLabelWithIconConstraint isActive]) {
        [_userLabelWithIconConstraint setActive:NO];
    }
    if ([_userLabelWithContentViewConstraint isActive]) {
        [_userLabelWithContentViewConstraint setActive:NO];
    }
    if ([_descriptionLabelWithContentViewConstraint isActive]) {
        [_descriptionLabelWithContentViewConstraint setActive:NO];
    }
    if ([_iconWithDescriptionLabelConstraint isActive]) {
        [_iconWithDescriptionLabelConstraint setActive:NO];
    }

    _iconWithContentViewConstraint = [NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16.0];
    [_iconWithContentViewConstraint setActive:YES];

    /// User label
    [_userLabel setTextAlignment:NSTextAlignmentRight];

    _userLabelWithIconConstraint = [NSLayoutConstraint constraintWithItem:_userLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_iconImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-16.0];
    [_userLabelWithIconConstraint setActive:YES];

    _userLabelWithContentViewConstraint = [NSLayoutConstraint constraintWithItem:_userLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16.0];
    [_userLabelWithContentViewConstraint setActive:YES];

    /// Description label
    [_descriptionLabel setTextAlignment:NSTextAlignmentRight];

    _descriptionLabelWithContentViewConstraint = [NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16.0];
    [_descriptionLabelWithContentViewConstraint setActive:YES];

    _iconWithDescriptionLabelConstraint = [NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_descriptionLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:16.0];
    [_iconWithDescriptionLabelConstraint setActive:YES];
}

@end
