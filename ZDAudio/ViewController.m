//
//  ViewController.m
//  ZDAudio
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ZDAudio.h"

@interface ViewController ()
@property (nonatomic, strong) ZDAudio* audio;
@property (nonatomic, strong) NSURL *URL;
@property(nonatomic, strong)  NSArray *list;



@end

@implementation ViewController
- (IBAction)record_click:(UIButton *)sender {
  self.URL =  [self.audio startRecording];
    

}
- (IBAction)pause_click:(UIButton *)sender {
    
  [self.audio pauseRecording];
    [self.audio pausePlaying];
    
}
- (IBAction)stop_click:(UIButton *)sender {
    [self.audio stopPlaying];
    [self.audio stopRecording];
    
}
- (IBAction)play_click:(UIButton *)sender {
    [self.audio stopRecording];
    [self.audio playNewestRecording];
    NSArray *list = [self.audio getRecordingList];
    self.list = list;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ZDAudio *audio = [[ZDAudio alloc] init];
    self.audio = audio;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
