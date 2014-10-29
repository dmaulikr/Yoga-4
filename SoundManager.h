#import <Foundation/Foundation.h>

#import <AVFoundation/AVAudioPlayer.h>

@protocol SoundManagerDelegate

-(void)soundDidFinishPlaying;

@end

@interface SoundManager : NSObject <AVAudioPlayerDelegate>

@property (weak, nonatomic) id <SoundManagerDelegate> delegate;

+(SoundManager *)sharedSingleton;

+ (void) playSoundFromFile:(NSString*)theFileName withExt:(NSString*)theFileExt atVolume:(float) volume;
+ (void) muteSound;
+ (void) unmuteSound;
+ (void) stopSound;
+ (void) pauseSound;
+ (void) resumeSound;

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;

@end
