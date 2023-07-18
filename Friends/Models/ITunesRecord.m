//
//  ITunesRecord.m
//  Friends
//
//  Created by Яна Латышева on 13.07.2023.
//

#import "ITunesRecord.h"

@interface ITunesRecord ()

@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *track;
@property (strong, nonatomic) NSString *artwork;

@end

@implementation ITunesRecord

- (instancetype)initWithArtist:(NSString *)artist track:(NSString *)track artwork:(NSString *)artwork {
    self = [super init];
    if (self) {
#warning TODO: set propetries to empty string if get null
        _artist = artist;
        _track = track;
        _artwork = artwork;
    }
    return self;
}

- (NSString * _Nonnull)user {
    return _artist;
}

- (NSString * _Nonnull)label {
    return _track;
}

- (NSString * _Nullable)iconPath {
    return _artwork;
}

@end
