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

- (instancetype)initWithArtist:(NSString * _Nullable)artist track:(NSString * _Nullable)track artwork:(NSString * _Nullable)artwork {
    self = [super init];
    if (self) {
        if (artist) {
            _artist = artist;
        } else {
            _artist = @"";
        }
        if (track) {
            _track = track;
        } else {
            _track = @"";
        }
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
