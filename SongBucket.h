//
//  SongBucket.h
//  YogaMusic
//
//  Created by Alec Tyre on 10/6/14.
//  Copyright (c) 2014 Mystery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongBucket : NSObject

-(id)initWithSongTitles:(NSArray*)songTitles;

-(NSString *)playNewSong;
-(void)stop;


@end
