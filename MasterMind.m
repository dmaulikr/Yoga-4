//
//  MasterMind.m
//  YogaMusic
//
//  Created by Alec Tyre on 10/8/14.
//  Copyright (c) 2014 Mystery. All rights reserved.
//

#import "MasterMind.h"
#import "SongBucket.h"
#import "SoundManager.h"


@interface MasterMind() <SoundManagerDelegate>

@property SongBucket* currentBucket;
@property NSString *currSongTitle;

@property SongBucket* level1;

@property CADisplayLink* displayLink;

@property (nonatomic) BOOL playing;
@property (nonatomic) double timeRemaining;
@property (nonatomic) double previousUpdate;

@end

@implementation MasterMind

-(id)init {
    
    self = (MasterMind*)[super init];
    
    if (self) {
        
        [SoundManager sharedSingleton].delegate = self;
        
        _level1 = [[SongBucket alloc] initWithSongTitles: @[@"Level 1 - Track 1 - Oceanic Zen - 2.0", @"Level 1 - Track 2 - Flute in F# - 2.0", @"Level 1 - Track 3 - Flute in A", @"Level 2 - Track 1 - Eastern Sunrise - 2.0"]];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        _previousUpdate = [_displayLink timestamp];
    }
    
    return self;
}

-(void)update {
    double currentTime = [_displayLink timestamp];
    
    double elapsedTime = currentTime - _previousUpdate;
    
    if (_playing) {
        _timeRemaining -= elapsedTime;
        
        if (_timeRemaining <= 0) {
            _playing = NO;
            
            NSLog(@"End");
            
            [SoundManager stopSound];
        }
    }
    
    _previousUpdate = currentTime;
}

-(void)startPlayingWithDuration:(double)duration {
    _playing = YES;
    
    _timeRemaining = duration;
    
    _currentBucket = _level1;

    _currSongTitle = [_currentBucket playNewSong];
    [self.delegate updateSongTitle:_currSongTitle];
}

-(void)stopPlaying
{
    [_currentBucket stop];
}

//SoundManagerDelegate call back
-(void)soundDidFinishPlaying {
    _currSongTitle = [_currentBucket playNewSong];
    [self.delegate updateSongTitle:_currSongTitle];
}

@end