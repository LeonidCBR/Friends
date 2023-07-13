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
        _artist = artist;
        _track = track;
        _artwork = artwork;
    }
    return self;
}

- (nonnull NSString *)user {
    return _artist;
}

- (nonnull NSString *)label {
    return _track;
}

- (NSURL *)icon {
    return [NSURL URLWithString:_artwork];
}

@end
