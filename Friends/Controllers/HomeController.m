//
//  HomeController.m
//  Friends
//
//  Created by Яна Латышева on 10.07.2023.
//

#define RECORD_CELL_IDENTIFIER @"RecordCellIdentifier"

#import "HomeController.h"

@interface HomeController ()

@property (strong, nonatomic) RecordsViewModel *recordsViewModel;
@property (strong, nonatomic) ImageProvider *imageProvider;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic) bool isIconExpanded;
@property (strong, nonatomic) NSArray *iconOriginConstraints;
@property (strong, nonatomic) NSArray *iconFullScreenConstraints;

@end

@implementation HomeController

- (instancetype)initWithRecordsViewModel:(RecordsViewModel *)recordsViewModel andImageProvider:(ImageProvider *)imageProvider {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _recordsViewModel = recordsViewModel;
        _imageProvider = imageProvider;
        _isIconExpanded = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friends";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureSegmentedControl];
    [self configureSearchBar];
    [self configureTableView];
    _recordsViewModel.delegate = self;
}

#pragma mark - Methods

- (void)configureSegmentedControl {
    NSArray *servers = [[NSArray alloc] initWithObjects:@"iTunes", @"GitHub", nil];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:servers];
    _segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _segmentedControl;
    [_segmentedControl addTarget:self action:@selector(handleChangedRecordsProvider) forControlEvents:UIControlEventValueChanged];
}

- (void)configureSearchBar {
    _searchBar = [UISearchBar new];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
         [[NSArray alloc] initWithObjects:
          [_searchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
          [_searchBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
          [_searchBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
          nil]
    ];
}

- (void)configureTableView {
    _tableView = [UITableView new];

#warning ClipsToBounds
    [_tableView setClipsToBounds:NO];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[RecordCell class] forCellReuseIdentifier:RECORD_CELL_IDENTIFIER];
    [self.view addSubview:_tableView];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
         [[NSArray alloc] initWithObjects:
          [_tableView.topAnchor constraintEqualToAnchor:_searchBar.bottomAnchor],
          [_tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
          [_tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
          [_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
          nil]
    ];
}

- (void)loadData {
    if ([_searchBar.text length] == 0) {
        return;
    }
    RecordsProviderType recordsProviderType = _segmentedControl.selectedSegmentIndex;
    [_recordsViewModel loadRecordsForRecordsProviderType:recordsProviderType andSearhText:_searchBar.text];
}

- (void)handleChangedRecordsProvider {
    [self loadData];
}

- (void)showMessageWithTitle:(NSString *)title andText:(NSString *)text {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    [self loadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_recordsViewModel getRecordsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:RECORD_CELL_IDENTIFIER forIndexPath:indexPath];
    id<ApiRecord> record = [_recordsViewModel getRecordAtRow:indexPath.row];
    [cell setUserName:record.user];
    [cell setDescription:record.label];
    [cell setIconImagePath:record.iconPath];
    [cell setDelegate:self];
    /// Clear image view in cell
    [cell setIconImage:nil];
    if (record.iconPath && [record.iconPath length] > 0) {
        __weak RecordCell *weakCell = cell;
        [_imageProvider getImageWithPath:record.iconPath completionHandler:^(UIImage * _Nullable image, NSString * _Nonnull imagePath, NSError * _Nullable error) {
            if (!image) {
                return;
            }
            if ([[weakCell iconImagePath] isEqualToString:imagePath]) {
                [weakCell setIconImage:image];
            }
        }];
    }
    Alignment alignment = [_recordsViewModel getAlignmentAtRow:indexPath.row];
    [cell updateUIWithAlignment:alignment];
    return cell;
}

#pragma mark - RecordsViewModelDelegate

- (void)handleError:(NSError *)error {
    [self showMessageWithTitle:@"Error" andText:error.debugDescription];
}

- (void)handleUpdatedRecordsForProvider:(RecordsProviderType)recordsProviderType search:(NSString *)searchText {
    /// Make sure that the searching parameters is not outdated
    RecordsProviderType currentProvider = _segmentedControl.selectedSegmentIndex;
    if (currentProvider == recordsProviderType
        && [_searchBar.text isEqualToString:searchText]) {
        [_tableView reloadData];
        /// Show message if there is no records
        if ([_recordsViewModel getRecordsCount] == 0) {
            [self showMessageWithTitle:@"Warning" andText:@"There in no records to show."];
        }
    } else {
        /// Searching parameters is outdated! There is nothing to do!
        NSLog(@"DEBUG: Searching parameters is outdated! Current:(%ld)[%@], Outdated:(%ld)[%@]", currentProvider, _searchBar.text, recordsProviderType, searchText);
    }
}

#pragma mark - RecordCellDelegate

- (void)handleTapForImageView:(UIImageView * _Nonnull)imageView {
    if (!_isIconExpanded) {
        [self expandIconImage:imageView];
    } else {
        [self revertIconImagePosition:imageView];
    }
}

/// Expand the icon image
- (void)expandIconImage:(UIImageView *)imageView {
    _isIconExpanded = YES;
    [self.view bringSubviewToFront:imageView];
    /// Collect icon constraints
    NSMutableArray *iconOriginConstraints = [NSMutableArray new];
    __auto_type imageViewConstraints = imageView.constraints;
    for (NSLayoutConstraint *constraint in imageViewConstraints) {
        if (constraint.firstItem == imageView || constraint.secondItem == imageView) {
            [iconOriginConstraints addObject:constraint];
        }
    }
    UIView *contentView = imageView.superview; // UITableViewCellContentView
    __auto_type contentViewConstraints = contentView.constraints;
    for (NSLayoutConstraint *constraint in contentViewConstraints) {
        if (constraint.firstItem == imageView || constraint.secondItem == imageView) {
            [iconOriginConstraints addObject:constraint];
        }
    }
    NSLog(@"DEBUG: Count of constraints: %lu", iconOriginConstraints.count);
    _iconOriginConstraints = [iconOriginConstraints copy];
    /// Deactivate old constraints
    [NSLayoutConstraint deactivateConstraints: iconOriginConstraints];
    /// Activate new constraints in order to expand the image
    NSArray *iconFullScreenConstraints = @[
        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ];
    _iconFullScreenConstraints = iconFullScreenConstraints;
    [NSLayoutConstraint activateConstraints:iconFullScreenConstraints];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/// Revert the position of the tapped icon image
- (void)revertIconImagePosition:(UIImageView *)imageView {
    /// Revert the icon image
    NSLog(@"Revert the icon image");

    [NSLayoutConstraint deactivateConstraints:_iconFullScreenConstraints];
    [NSLayoutConstraint activateConstraints:_iconOriginConstraints];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    _iconOriginConstraints = nil;
    _iconFullScreenConstraints = nil;
    _isIconExpanded = NO;
}

/*
- (void)handleIconTapForImage:(UIImage * _Nullable)image {
    NSLog(@"DEBUG: TODO expand the image %@", image);
    UIImageView *expandingImage = [[UIImageView alloc] initWithImage:image];
    [expandingImage setClipsToBounds:YES];
    expandingImage.backgroundColor = [UIColor blackColor];
    [expandingImage setContentMode:UIViewContentModeScaleAspectFit];
    [expandingImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    [expandingImage addGestureRecognizer:tap];

    [self.view addSubview:expandingImage];
    expandingImage.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [expandingImage.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [expandingImage.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [expandingImage.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [expandingImage.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
    ]];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)handleImageTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSLog(@"DEBUG: Hide the image");
}
*/
@end
