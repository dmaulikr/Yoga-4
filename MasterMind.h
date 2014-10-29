//
//  MasterMind.h
//  YogaMusic
//
//  Created by Alec Tyre on 10/8/14.
//  Copyright (c) 2014 Mystery. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MasterMindDelegate
- (void) updateSongTitle:(NSString *) songTitle;
@end

@interface MasterMind : NSObject

@property (weak, nonatomic) id <MasterMindDelegate> delegate;

-(void)startPlayingWithDuration:(double)duration;
-(void)stopPlaying;

@end
