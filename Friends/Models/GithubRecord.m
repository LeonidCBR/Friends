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

- (instancetype)initWithLogin:(NSString *)login account:(NSString *)account avatar:(NSString *)avatar {
    self = [super init];
    if (self) {
        _login = login;
        _account = account;
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

//- (NSURL * _Nullable)icon {
//    return [NSURL URLWithString:_avatar];
//}
- (NSString * _Nullable)iconPath {
    return _avatar;
}

@end
