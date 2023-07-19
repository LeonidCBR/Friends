//
//  GithubRecord.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "GithubRecord.h"

@interface GithubRecord ()

@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *avatar;

@end

@implementation GithubRecord

- (instancetype)initWithLogin:(NSString * _Nullable)login account:(NSString * _Nullable)account avatar:(NSString * _Nullable)avatar {
    self = [super init];
    if (self) {
        if (login) {
            _login = login;
        } else {
            _login = @"";
        }
        if (account) {
            _account = account;
        } else {
            _account = @"";
        }
        _avatar = avatar;
    }
    return self;
}

- (NSString * _Nonnull)user {
    return _login;
}

- (NSString * _Nonnull)label {
    return _account;
}

- (NSString * _Nullable)iconPath {
    return _avatar;
}

@end
