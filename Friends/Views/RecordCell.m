//
//  RecordCell.m
//  Friends
//
//  Created by Яна Латышева on 15.07.2023.
//

#import "RecordCell.h"

@interface RecordCell ()

@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *DescriptionLabel;
@property (strong, nonatomic) UIImageView *iconImageView;

@end

@implementation RecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userLabel = [UILabel new];
        _DescriptionLabel = [UILabel new];
        _iconImageView = [UIImageView new];
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureIcon];
    [self configureUser];
    [self configureLabel];
}

- (void)configureIcon {
//    _iconImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_iconImageView];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
         [[NSArray alloc] initWithObjects:
          [_iconImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
          [_iconImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
          [_iconImageView.widthAnchor constraintEqualToConstant:60.0],
          [_iconImageView.heightAnchor constraintEqualToConstant:60.0],
          [_iconImageView.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:8.0],
          [_iconImageView.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:-8.0],
          nil]
    ];
}

- (void)configureUser {
    _userLabel.numberOfLines = 0;
    [self.contentView addSubview:_userLabel];
    _userLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
         [[NSArray alloc] initWithObjects:
          [_userLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
          [_userLabel.leadingAnchor constraintEqualToAnchor:_iconImageView.trailingAnchor constant:16.0],
          [_userLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
          nil]
    ];
}

- (void)configureLabel {
    _DescriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:_DescriptionLabel];
    _DescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
         [[NSArray alloc] initWithObjects:
          [_DescriptionLabel.topAnchor constraintEqualToAnchor:_userLabel.bottomAnchor constant:12.0],
          [_DescriptionLabel.leadingAnchor constraintEqualToAnchor:_iconImageView.trailingAnchor constant:16.0],
          [_DescriptionLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:-12.0],
          [_DescriptionLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
          nil]
    ];
}

- (void)setUserName:(NSString *)userName {
    _userLabel.text = userName;
}

- (void)setDescription:(NSString *)description {
    _DescriptionLabel.text = description;
}

@end
