//
//  ZDAudio.h
//  ZDAudio
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

//typedef void (^RecorderBlock) (NSURL *URL, NSDictionary *settings,NSTimeInterval duration,NSError *outError);
//typedef void (^PlayerBlock) (NSURL *URL,NSError *outError,float speed);
@interface ZDAudio : NSObject

-(NSURL *)startRecording;
-(NSTimeInterval)pauseRecording;
-(NSTimeInterval)stopRecording;
-(void)playNewestRecording;
-(void)RecordAudioWithURL:(NSURL*)URL;
-(NSTimeInterval)playAudioWithURL:(NSURL*)URL;
-(void)pausePlaying;
-(void)stopPlaying;
-(NSArray *)getRecordingList;
//-(void)recordAudioWithURL:(NSURL *)URL Settings:(NSDictionary *)settings andDuration:(NSTimeInterval) duration;
//-(void)playAudioWithURL:(NSURL *)URL andSpeed:(CGFloat)speed;

@end
