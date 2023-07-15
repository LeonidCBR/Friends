//
//  HomeController.h
//  Friends
//
//  Created by Яна Латышева on 10.07.2023.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "RecordsViewModel.h"
#import "RecordCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, RecordsViewModelDelegate>

- (instancetype)initWithRecordsViewModel:(RecordsViewModel *)recordsViewModel;

@end

NS_ASSUME_NONNULL_END
