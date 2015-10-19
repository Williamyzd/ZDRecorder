//
//  ZDAudio.m
//  ZDAudio
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ZDAudio.h"
@interface ZDAudio (){
   // NSTimeInterval timeToken = 0;
}
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSDictionary *setings;
@property(nonatomic, assign) NSTimeInterval timeToken;
//@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, strong) NSMutableDictionary *dic;
//@property (nonatomic, strong) NSDictionary *recorderSettings;
//@property (nonatomic, copy) RecorderBlock recorderBlock;
//@property (nonatomic, copy) PlayerBlock playerBlock;
@end
@implementation ZDAudio
-(instancetype)init{
   self = [super init];
    [self setAudioSession];
    self.timeToken =0;
    
    
    return self;
}
-(NSMutableDictionary *)dic{
    if (!_dic) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _dic =dic;
    }
    return _dic;
}
//0.建立录音与播放会话
-(void)setAudioSession{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //录音并播放模式
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

//1.拿到当前为系统时间
-(NSString *)getRecordName{
    NSDate *date = [NSDate date];
    NSTimeInterval interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    //格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    NSString *dateStr = [formatter stringFromDate:localDate];
    
    NSString *recordName = [NSString stringWithFormat:@"%@.wav",dateStr];
    //NSMutableArray *recordList = [NSMutableArray array];
     // [recordList addObject:recordName];
    // self.recordList= recordList;

  //[self.recordList addObject:recordName];
    return recordName;
}
//2.设置保存路径
-(NSURL *)getURL{
   // NSMutableArray *URLList = [NSMutableArray array];
    
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
   // NSString *time = [self getDate];
    //NSString *recordName = [NSString stringWithFormat:@"%@.wav",time];
//    NSMutableArray *recordList = [NSMutableArray array];
//    [recordList addObject:recordName];
//    self.recordList= recordList;
    NSString *recordName = [self getRecordName];
    NSString *path = [[paths lastObject] stringByAppendingPathComponent:recordName];
    NSURL *url = [NSURL fileURLWithPath:path];
    if (!self.recorder) {
        [self.dic setValue:url forKey:recordName];
    }
    
    return url;
}
//-(NSURL *)URL{
//   
//    if (!_URL) {
//        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//        NSString *time = [self getDate];
//        NSString *lasturl = [NSString stringWithFormat:@"%@.wav",time];
//        [self.recordList addObject:lasturl];
//        NSString *path = [[paths lastObject] stringByAppendingPathComponent:lasturl];
//        NSURL *url = [NSURL fileURLWithPath:path];
//        _URL=url;
//        
//    }
//    return _URL;
//}
//3.拿到字典

-(NSDictionary *)setings{
    NSMutableDictionary *dic= [NSMutableDictionary dictionary];
    [dic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [dic setObject:@(8000) forKey:AVSampleRateKey];
    [dic setObject:@(1) forKey:AVNumberOfChannelsKey];
    [dic setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    [dic setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    return dic.copy;
}
//4录音开始
-(void)RecordAudioWithURL:(NSURL*)URL{
    
    if (!self.recorder){
        self.timeToken =0;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:URL settings:self.setings error:nil];
        [self.recorder record];
        
    }
    if (self.recorder.recording) {
        [self stopRecording];
        self.timeToken =0;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:URL settings:self.setings error:nil];
        [self.recorder record];
    }
    [self.recorder record];
    
}
-(NSURL *)startRecording{
        NSURL *url =[self getURL];
        [self RecordAudioWithURL:url];
    self.URL = self.recorder.url;
    NSLog(@"%@",self.recorder.url);
    return self.recorder.url;
}
//暂停录制
-(NSTimeInterval)pauseRecording{
    if (self.recorder) {
        self.timeToken =self.recorder.currentTime;
        [self.recorder pause];
    #pragma 暂停状态是不是算是录音 不是
         return self.timeToken;
    }
    return 0;

}
//停止录音
-(NSTimeInterval)stopRecording{
        //正在录音
        if (self.recorder.recording) {
            NSTimeInterval interval =self.recorder.currentTime;
            [self.recorder stop];
#pragma stop 之后self.recorder是否存在
            self.recorder = nil;
           
            return interval;
        }
    
            [self.recorder stop];
            self.recorder = nil;
            return self.timeToken;
   
}
//播放最后录的音
-(void)playNewestRecording{
    [self playAudioWithURL:self.URL];

}
//播音
-(NSTimeInterval)playAudioWithURL:(NSURL*)URL{
        if (!self.player) {
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
            self.player= player;
        }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.URL error:nil];
        [self.player play];
        return self.player.duration;

    }
//暂停播放
-(void)pausePlaying{
    if (self.player.playing) {
        [self.player pause];
    }
    
}
//停止播放
-(void)stopPlaying{
    if (self.player) {
        [self.player stop];
        //self.player = nil;
    }
}
-(NSArray *)getRecordingList{
    //return self.recordList.copy;
    
  NSArray *list =  [self.dic allKeys];
    
    NSLog(@"%@ %zd",self.dic,list.count);
    return list;
}



@end
