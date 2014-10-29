#import "SoundManager.h"

@interface SoundManager()

//Arrays to store AVAudioPlayers
+(NSMutableArray *)soundArray;


//Arrays to store volumes to facilitate mute/unmute
//Index of player and matching volume should be the same for easy look up
+(NSMutableArray *)soundVolumes;


+(SoundManager *)sharedSingleton;

@end

@implementation SoundManager

////////////////////////////////////////////////////////////////////////////////
//        Static Object access functions
////////////////////////////////////////////////////////////////////////////////

+(SoundManager *)sharedSingleton
{
    static SoundManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[SoundManager alloc] init];
            
        return sharedSingleton;
    }
}

+(NSMutableArray *)soundArray
{
    static NSMutableArray* soundArray = nil;
    
    if (soundArray == nil)
    {
        soundArray = [[NSMutableArray alloc] init];
    }
    
    return soundArray;
}

+(NSMutableArray *)soundVolumes
{
    static NSMutableArray* soundVolumes = nil;
    
    if (soundVolumes == nil)
    {
        soundVolumes = [[NSMutableArray alloc] init];
    }
    
    return soundVolumes;
}



////////////////////////////////////////////////////////////////////////////////
//        Sound functions
////////////////////////////////////////////////////////////////////////////////

+ (void) playSoundFromFile:(NSString*)theFileName withExt:(NSString*)theFileExt atVolume:(float)volume {
    
    if ([[SoundManager soundArray] count] > 0) {
        [SoundManager stopSound];
    }
    
	//Get the path of the file
    NSString *path = [[NSBundle mainBundle] pathForResource:theFileName ofType:theFileExt];
    
    NSError *error;
    
    //Make newPlayer with file at path
	AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    
    //Prepare to play it? I guess?
    [newPlayer prepareToPlay];
    
    //Add to array or dictionary or whatever
    [[SoundManager soundArray] addObject:newPlayer];
    
    //Make SoundManager the delegate of the newPlayer
    newPlayer.delegate = [SoundManager sharedSingleton];
    
    //Assign volume argument to newPlayer volume
    [newPlayer setVolume:volume];
        
    //Create an NSNumber to store the volume and then DO it
    NSNumber *newVolume = [[NSNumber alloc] initWithFloat:volume];
    [[SoundManager soundVolumes] addObject:newVolume];
    
    [newPlayer play];
}

+ (void) muteSound {
	
	for (AVAudioPlayer *player in [SoundManager soundArray]) {
        [player setVolume: 0];
    }
}

+ (void) unmuteSound {
	
	for (AVAudioPlayer *player in [SoundManager soundArray]) {
        [player setVolume: [[[SoundManager soundVolumes] objectAtIndex:[[SoundManager soundArray] indexOfObject:player]] floatValue]];
    }
}

+ (void) stopSound {
	
	for (AVAudioPlayer *player in [SoundManager soundArray]) {
        [player stop];
    }
    
    [[SoundManager soundVolumes] removeAllObjects];
    [[SoundManager soundArray] removeAllObjects];
}

+ (void) pauseSound {
    
    for (AVAudioPlayer *player in [SoundManager soundArray]) {
        [player pause];
    }
}

+ (void) resumeSound {
    
    for (AVAudioPlayer *player in [SoundManager soundArray]) {
        [player play];
    }
}


////////////////////////////////////////////////////////////////////////////////
//        Utility Functions
////////////////////////////////////////////////////////////////////////////////

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSUInteger soundIndex = [[SoundManager soundArray] indexOfObject:player];
    
    if(soundIndex != NSNotFound) {
        [[SoundManager soundVolumes] removeObjectAtIndex:soundIndex];
        [[SoundManager soundArray] removeObjectAtIndex:soundIndex];
    }
    
    [self.delegate soundDidFinishPlaying];
}

@end
