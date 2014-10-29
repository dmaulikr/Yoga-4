//
//  SongBucket.m
//  YogaMusic
//
//  Created by Alec Tyre on 10/6/14.
//  Copyright (c) 2014 Mystery. All rights reserved.
//

#import "SongBucket.h"
#import "SoundManager.h"


@interface SongBucket()

@property (nonatomic) NSMutableArray* unplayedSongs;
@property (nonatomic) NSMutableArray* playedSongs;

@end

@implementation SongBucket

-(id)initWithSongTitles:(NSArray*)songTitles {
    
    self = (SongBucket*)[super init];
    
    //Init arrays
    _unplayedSongs = [NSMutableArray array];
    
    [_unplayedSongs addObjectsFromArray: songTitles];
    
    _playedSongs = [NSMutableArray array];
    
    return self;
}

-(NSString *)playNewSong {
    
    //Start repeating if we run out of songs
    if (_unplayedSongs.count == 0) {
        [self reset];
    }
    
    int newSongIndex = rand() % _unplayedSongs.count;
    
    //Get song name from unplayedSongs
    NSString* newSongName = (NSString*)[_unplayedSongs objectAtIndex:newSongIndex];
    
    //Remove song from unplayedSongs
    [_unplayedSongs removeObjectAtIndex:newSongIndex];
    
    //Add song to playedSongs
    [_playedSongs addObject: newSongName];
    
    //Play song
    [SoundManager playSoundFromFile: newSongName withExt:@"wav" atVolume: 1];
    
    return newSongName;
}

-(void)reset {
    [_unplayedSongs addObjectsFromArray: _playedSongs];
}

-(void)stop
{
    [SoundManager stopSound];
    [self reset];
}

@end
