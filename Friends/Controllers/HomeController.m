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

@end

@implementation HomeController

- (instancetype)initWithRecordsViewModel:(RecordsViewModel *)recordsViewModel andImageProvider:(ImageProvider *)imageProvider {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _recordsViewModel = recordsViewModel;
        _imageProvider = imageProvider;
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
#warning TODO: Show alert message with error
    NSLog(@"DEBUG: Got error! %@", error.debugDescription);
}

- (void)handleUpdatedRecordsForProvider:(RecordsProviderType)recordsProviderType search:(NSString *)searchText {
    /// Make sure that the searching parameters is not outdated
    RecordsProviderType currentProvider = _segmentedControl.selectedSegmentIndex;
    if (currentProvider == recordsProviderType
        && [_searchBar.text isEqualToString:searchText]) {
        [_tableView reloadData];
    } else {
        /// Searching parameters is outdated! There is nothing to do!
        NSLog(@"DEBUG: Searching parameters is outdated! Current:(%ld)[%@], Outdated:(%ld)[%@]", currentProvider, _searchBar.text, recordsProviderType, searchText);
    }
}

@end
