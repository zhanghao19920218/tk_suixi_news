//
//  NELivePlayerViewController.m
//  Runner
//
//  Created by Barry Allen on 2019/6/28.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "NELivePlayerViewController.h"
#import "NELivePlayerControlView.h"
#import <NELivePlayerFramework/NELivePlayerFramework.h>
#import <Flutter/Flutter.h>

@interface NELivePlayerViewController ()<NELivePlayerControlViewProtocol>
{
    NSURL *_url;
    NSURL *_syncUrl;
//    NSString *_decodeType;
    NSString *_mediaType;
    BOOL _isHardware;
    dispatch_source_t _timer;
}
@property (nonatomic, strong) NELivePlayerController *player; //播放器sdk
@property (nonatomic, strong) NELivePlayerController *syncPlayer; //从播放器sdk

@property (nonatomic, strong) UIView *playerContainerView; //播放器包裹视图

@property (nonatomic, strong) NELivePlayerControlView *controlView; //播放器控制视图

//外挂字幕处理缓存
@property (nonatomic, strong) NSMutableArray *subtitleIdArray;
@property (nonatomic, strong) NSMutableDictionary *subtitleDic;
@property (nonatomic, strong) NSMutableArray *exSubtitleIdArray;
@property (nonatomic, strong) NSMutableDictionary *exSubtitleDic;

@property (nonatomic, strong) UIButton *backButton; //设置返回按钮

@end

@implementation NELivePlayerViewController

- (void)dealloc {
    NSLog(@"[NELivePlayer Demo] NELivePlayerVC 已经释放！");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        _url = url;
        _isHardware = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    
    [self doInitPlayer];
    
    if (_syncUrl) {
        [self doInitSyncPlayer];
    }
    
    [self doInitPlayerNotication];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _playerContainerView.frame = self.view.bounds;
    _controlView.frame = self.view.bounds;
    _syncPlayer.view.frame = CGRectMake(_playerContainerView.bounds.size.width/2, 0, _playerContainerView.bounds.size.width/2, _playerContainerView.bounds.size.height);
    if (_syncPlayer) {
        _player.view.frame = CGRectMake(0, 0, _playerContainerView.bounds.size.width/2, _playerContainerView.bounds.size.height);
    } else {
        _player.view.frame = _playerContainerView.bounds;
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)setupSubviews {
    _playerContainerView = [[UIView alloc] init];
    _playerContainerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_playerContainerView];
    
    _controlView = [[NELivePlayerControlView alloc] init];
    _controlView.fileTitle = [_url.absoluteString lastPathComponent];
    _controlView.delegate = self;
    [self.view addSubview:_controlView];
}

- (void)syncUIStatus
{
    _controlView.isPlaying = NO;
    
    __block NSTimeInterval mDuration = 0;
    __block bool getDurFlag = false;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t syncUIQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = CreateDispatchSyncUITimerN(1.0, syncUIQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!getDurFlag) {
                mDuration = [weakSelf.player duration];
                if (mDuration > 0) {
                    getDurFlag = true;
                }
            }
            
            weakSelf.controlView.isAllowSeek = (mDuration > 0);
            weakSelf.controlView.duration = mDuration;
            weakSelf.controlView.currentPos = [weakSelf.player currentPlaybackTime];
            weakSelf.controlView.isPlaying = ([weakSelf.player playbackState] == NELPMoviePlaybackStatePlaying);
        });
    });
}

#pragma mark - 播放器SDK功能

-(void)doInitSyncPlayer {
    NSError *error = nil;
    self.syncPlayer = [[NELivePlayerController alloc] initWithContentURL:_syncUrl error:&error];
    if (self.syncPlayer == nil) {
        NSLog(@"sync player initilize failed, please tay again.error = [%@]!", error);
    }
    [_playerContainerView addSubview:self.syncPlayer.view];
    
    self.view.autoresizesSubviews = YES;
    
    if ([_mediaType isEqualToString:@"livestream"] ) {
        [self.syncPlayer setBufferStrategy:NELPLowDelay]; // 直播低延时模式
    }
    else {
        [self.syncPlayer setBufferStrategy:NELPAntiJitter]; // 点播抗抖动
    }
    [self.syncPlayer setScalingMode:NELPMovieScalingModeNone]; // 设置画面显示模式，默认原始大小
    [self.syncPlayer setShouldAutoplay:YES]; // 设置prepareToPlay完成后是否自动播放
    [self.syncPlayer setHardwareDecoder:_isHardware]; // 设置解码模式，是否开启硬件解码
    [self.syncPlayer setPauseInBackground:NO]; // 设置切入后台时的状态，暂停还是继续播放
    [self.syncPlayer setPlaybackTimeout:15 *1000]; // 设置拉流超时时间
    
    
    /* 这里一定要打开主播放器的sei */
    [self.player setOpenReceiveSyncData:YES];
}

- (void)doInitPlayer {
    
    //[NELivePlayerController setLogLevel:NELP_LOG_VERBOSE];
    
    NELPUrlConfig *urlConfig = nil;
    /**视频云加密的视频，自己已知密钥，增加以下一段**/
    /*
     urlConfig = [[NELPUrlConfig alloc] init];
     urlConfig.decryptionConfig = [[NELPUrlDecryptionConfig alloc] init];
     NSString *key = @"HelloWorld";
     NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
     urlConfig.decryptionConfig = [NELPUrlDecryptionConfig configWithOriginalKey:keyData];
     */
    
    /**用视频云整套加解密系统，增加以下一段**/
    /*
     urlConfig = [[NELPUrlConfig alloc] init];
     urlConfig.decryptionConfig = [NELPUrlDecryptionConfig configWithTransferToken:@"exampleTransferToken"
     accid:@"exampleAccid"
     appKey:@"exampleAppKey"
     token:@"exampleToken"];
     */
    
    NSError *error = nil;
    self.player = [[NELivePlayerController alloc] initWithContentURL:_url
                                                              config:urlConfig
                                                               error:&error];
    if (self.player == nil) {
        NSLog(@"player initilize failed, please tay again.error = [%@]!", error);
    }
    [_playerContainerView addSubview:self.player.view];
    
    self.view.autoresizesSubviews = YES;
    
    if ([_mediaType isEqualToString:@"livestream"] ) {
        [self.player setBufferStrategy:NELPLowDelay]; // 直播低延时模式
    }
    else {
        [self.player setBufferStrategy:NELPAntiJitter]; // 点播抗抖动
    }
    [self.player setScalingMode:NELPMovieScalingModeNone]; // 设置画面显示模式，默认原始大小
    [self.player setShouldAutoplay:YES]; // 设置prepareToPlay完成后是否自动播放
    [self.player setHardwareDecoder:_isHardware]; // 设置解码模式，是否开启硬件解码
    [self.player setPauseInBackground:NO]; // 设置切入后台时的状态，暂停还是继续播放
    [self.player setPlaybackTimeout:15 *1000]; // 设置拉流超时时间
    
    
    //字幕功能
    //[self subtitleFunction];
    
    //透传自定义信息功能
    //[self syncContentFunction];
    
    /** 视频云加密的视频，自己已知密钥 **/
    [self.player prepareToPlay];
}

- (void)doInitPlayerNotication {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlaybackStateChanged:)
                                                 name:NELivePlayerPlaybackStateChangedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerSeekComplete:)
                                                 name:NELivePlayerMoviePlayerSeekCompletedNotification
                                               object:_player];
}

- (void)doDestorySyncPlayer {
    [self.syncPlayer shutdown];
    [self.syncPlayer.view removeFromSuperview];
    self.syncPlayer = nil;
}

- (void)doDestroyPlayer {
    [self.player shutdown]; // 退出播放并释放相关资源
    [self.player.view removeFromSuperview];
    self.player = nil;
}

#pragma mark - 播放器通知事件
- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification {
    //add some methods
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerDidPreparedToPlayNotification 通知");
    
    //获取视频信息，主要是为了告诉界面的可视范围，方便字幕显示
    NELPVideoInfo info;
    memset(&info, 0, sizeof(NELPVideoInfo));
    [_player getVideoInfo:&info];
    _controlView.videoResolution = CGSizeMake(info.width, info.height);
    
    [self syncUIStatus];
    [_player play]; //开始播放
    
    //开
    [_player setRealTimeListenerWithIntervalMS:500 callback:^(NSTimeInterval realTime) {
        NSLog(@"当前时间戳：[%f]", realTime);
    }];
    
    //关
    [_player setRealTimeListenerWithIntervalMS:500 callback:nil];
    
    //设置同步播放器
    if (_syncPlayer) {
        [_syncPlayer syncClockToPlayer:self.player];
        
        //3s后开启从播放器
        [_syncPlayer performSelector:@selector(prepareToPlay) withObject:nil afterDelay:3];
    }
}

- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerPlaybackStateChangedNotification 通知");
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerLoadStateChangedNotification 通知");
    
    NELPMovieLoadState nelpLoadState = _player.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
        _controlView.isBuffing = NO;
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
        _controlView.isBuffing = YES;
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerPlaybackFinishedNotification 通知");
    
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    __weak typeof(self) weakSelf = self;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
            if ([_mediaType isEqualToString:@"livestream"]) {
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
                action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [weakSelf doDestorySyncPlayer];
                    [weakSelf doDestroyPlayer];
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            break;
            
        case NELPMovieFinishReasonPlaybackError:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [weakSelf doDestorySyncPlayer];
                [weakSelf doDestroyPlayer];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            break;
        }
            
        case NELPMovieFinishReasonUserExited:
            break;
            
        default:
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerFirstVideoDisplayedNotification 通知");
}

- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerFirstAudioDisplayedNotification 通知");
}

- (void)NELivePlayerSeekComplete:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerMoviePlayerSeekCompletedNotification 通知");
    [self cleanSubtitls];
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerReleaseSueecssNotification 通知");
}

#pragma mark - 控制页面的事件
- (void)controlViewOnClickQuit:(NELivePlayerControlView *)controlView {
    NSLog(@"[NELivePlayer Demo] 点击退出");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self doDestorySyncPlayer];
    [self doDestroyPlayer];
    
    // 释放timer
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)controlViewOnClickPlay:(NELivePlayerControlView *)controlView isPlay:(BOOL)isPlay {
    NSLog(@"[NELivePlayer Demo] 点击播放，当前状态: [%@]", (isPlay ? @"播放" : @"暂停"));
    if (isPlay) {
        [self.player play];
        [self.syncPlayer play];
    } else {
        [self.player pause];
        [self.syncPlayer pause];
    }
}

- (void)controlViewOnClickSeek:(NELivePlayerControlView *)controlView dstTime:(NSTimeInterval)dstTime {
    NSLog(@"[NELivePlayer Demo] 执行seek，目标时间: [%f]", dstTime);
    self.player.currentPlaybackTime = dstTime;
    self.syncPlayer.currentPlaybackTime = dstTime;
}

- (void)controlViewOnClickMute:(NELivePlayerControlView *)controlView isMute:(BOOL)isMute{
    NSLog(@"[NELivePlayer Demo] 点击静音，当前状态: [%@]", (isMute ? @"静音开" : @"静音关"));
    [self.player setMute:isMute];
}

- (void)controlViewOnClickSnap:(NELivePlayerControlView *)controlView{
    
    NSLog(@"[NELivePlayer Demo] 点击屏幕截图");
    
    UIImage *snapImage = [self.player getSnapshot];
    
    UIImageWriteToSavedPhotosAlbum(snapImage, nil, nil, nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"截图已保存到相册" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)controlViewOnClickScale:(NELivePlayerControlView *)controlView isFill:(BOOL)isFill {
    NSLog(@"[NELivePlayer Demo] 点击屏幕缩放，当前状态: [%@]", (isFill ? @"全屏" : @"适应"));
    if (isFill) {
        [self.player setScalingMode:NELPMovieScalingModeAspectFill];
    } else {
        [self.player setScalingMode:NELPMovieScalingModeAspectFit];
    }
}

#pragma mark - Tools
dispatch_source_t CreateDispatchSyncUITimerN(double interval, dispatch_queue_t queue, dispatch_block_t block)
{
    //创建Timer
    dispatch_source_t timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);//queue是一个专门执行timer回调的GCD队列
    if (timer) {
        //使用dispatch_source_set_timer函数设置timer参数
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval*NSEC_PER_SEC), interval*NSEC_PER_SEC, (1ull * NSEC_PER_SEC)/10);
        //设置回调
        dispatch_source_set_event_handler(timer, block);
        //dispatch_source默认是Suspended状态，通过dispatch_resume函数开始它
        dispatch_resume(timer);
    }
    
    return timer;
}

- (void)decryptWarning:(NSString *)msg {
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    
    alertController = [UIAlertController alertControllerWithTitle:@"注意" message:msg preferredStyle:UIAlertControllerStyleAlert];
    action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 外挂字幕功能示例

- (void)subtitleFunction {
    
    NSString *srtPath1 = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"srt"];
    
    //设置外挂字幕
    NSURL *url = [NSURL fileURLWithPath:srtPath1];
    [self.player setLocalSubtitleFile:url];
    
    //关闭外挂字幕
    //    [self.player setSubtitleFile:NULL];
    
    //切换外挂字幕
    //    NSString *srtPath2 = @"test2";
    //    NSURL *url2 = [NSURL fileURLWithPath:srtPath2];
    //    [self.player setSubtitleFile:url];
    //    [self.player setSubtitleFile:url2];
    
    //设置监听
    __weak typeof(self) weakSelf = self;
    [self.player registSubtitleStatBlock:^(BOOL isShown, NSInteger subtitleId, NSString *subtitleText) {
        [weakSelf processSubtitle:isShown subId:subtitleId subtitle:subtitleText];
    }];
}

//处理字幕
- (void)processSubtitle:(BOOL)isShown  subId:(NSInteger)subId subtitle:(NSString *)subtitle {
    //NSString *str = (isShown ? @"显示" : @"隐藏");
    //NSLog(@"[%@] id:[%zi] tx:[%@]", str, subId, subtitle);
    if (!_subtitleIdArray) {
        _subtitleIdArray = [NSMutableArray array];
    }
    if (!_subtitleDic) {
        _subtitleDic = [NSMutableDictionary dictionary];
    }
    
    if (!_exSubtitleIdArray) {
        _exSubtitleIdArray = [NSMutableArray array];
    }
    if (!_exSubtitleDic) {
        _exSubtitleDic = [NSMutableDictionary dictionary];
    }
    
    //数据存放
    NSRange range;
    BOOL isExSubtitle = [self isExSubtitle:subtitle range:&range];
    __block NSMutableArray *idArray = (isExSubtitle ? _exSubtitleIdArray : _subtitleIdArray);
    __block NSMutableDictionary *subDic  = (isExSubtitle ? _exSubtitleDic : _subtitleDic);
    NSString *insertSubStr = (isExSubtitle ? [subtitle stringByReplacingCharactersInRange:range withString:@""] : subtitle);
    if (isShown)
    {
        [idArray addObject:@(subId)];
        [subDic setObject:insertSubStr forKey:@(subId)];
    }
    else
    {
        __block NSUInteger index;
        [idArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == subId) {
                [subDic removeObjectForKey:obj];
                index = idx;
                *stop = YES;
            }
        }];
        if (index < idArray.count) {
            [idArray removeObjectAtIndex:index];
        }
    }
    
    //获取显示字符串
    NSMutableString *showStr = [NSMutableString stringWithFormat:@""];
    for (int i = 0; i < idArray.count; i++) {
        if (subDic[idArray[i]]) {
            [showStr appendString:subDic[idArray[i]]];
            if (i != idArray.count - 1) {
                [showStr appendString:@"\n"];
            }
        }
        else
        {
            break;
        }
    }
    
    //更新UI
    if (isExSubtitle) {
        //-----------
        _controlView.subtitle_ex = showStr;
    }
    else
    {
        //----------- 根据显示的字符串做格式处理 ---------------
        _controlView.subtitle = showStr;
    }
}

//扩展的字幕信息{扩展字幕信息，主要包括{}，主要记录附加信息}
- (BOOL)isExSubtitle:(NSString *)subtitle range:(NSRange *)range {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\{[\\S\\s]+\\}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:subtitle
                                                     options:0
                                                       range:NSMakeRange(0, [subtitle length])];
    BOOL ret = NO;
    if (result) {
        *range = result.range;
        ret = YES;
    }
    return ret;
}

- (void)cleanSubtitls { //seek完成后，或者切换完字幕，需要清空
    [_exSubtitleDic removeAllObjects];
    [_exSubtitleIdArray removeAllObjects];
    [_subtitleDic removeAllObjects];
    [_subtitleIdArray removeAllObjects];
    
    //更新UI
    _controlView.subtitle_ex = @"";
    _controlView.subtitle = @"";
}

#pragma mark - 透传自定义信息示例
- (void)syncContentFunction {
    [self.player registerSyncContentCB:^(NELivePlayerSyncContent *content) {
        NSArray *strings = content.contents;
        [strings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"透传的自定义信息是 ：----- %@ ------", obj);
        }];
    }];
}

@end
//
//
//@interface NELivePlayerViewController ()
//
//@property (nonatomic, strong) UIButton *popBackButton; //返回按钮
//
//@property (nonatomic, strong) NELivePlayerController *playerController;
//
//@property (nonatomic, strong) UIView *playerContainerView; //播放器包裹视图
//
//@end
//
//@implementation NELivePlayerViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
//
//    [self setupUI];
//
//    [self setupSubviews];
//
//    [self.view setBackgroundColor:[UIColor blackColor]];
//
//    [_playerContainerView addSubview:self.playerController.view];
//
//    self.view.autoresizesSubviews = YES;
//
//    self.playerController.shouldAutoplay = YES; //静态参数，需在开始播放之前设置。]
//}
//
//- (UIButton *)popBackButton {
//    if (!_popBackButton) {
//        _popBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _popBackButton.frame = CGRectMake(0, 30, 200, 50);
//        _popBackButton.backgroundColor = [UIColor blackColor];
//        [_popBackButton setTitle:@"返回Flutter" forState:UIControlStateNormal];
//        [_popBackButton addTarget:self action:@selector(popBackFlutter:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _popBackButton;
//}
//
//- (NELivePlayerController *)playerController
//{
//    NSLog(@"获取数据%@", self.playUrl);
//    if (!_playerController) {
//        _playerController = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.playUrl] error:nil];
//        //设置画面显示模式
//        [self.playerController setScalingMode:NELPMovieScalingModeAspectFit];
//        [_playerController prepareToPlay]; //初始化视频文件为播放做准备。设置数据源之后，播放前调用。
//    }
//    return _playerController;
//}
//
//- (void)setupSubviews {
//    _playerContainerView = [[UIView alloc] init];
//    _playerContainerView.frame = self.view.bounds;
//    _playerContainerView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_playerContainerView];
//}
//
////确定是否有地址
//- (NSString *)playUrl
//{
//    if (!_playUrl) {
//        _playUrl = @""; //初始化一个为空的String
//    }
//    return _playUrl;
//}
//
//- (void)setupUI {
//    [self.view addSubview:self.popBackButton];
//}
//
////返回按钮
///**
// *    @brief    停止播放，并释放播放器相关资源
// *
// *  @discussion
// *  在播放器退出时，需要调用该方法用于释放资源。
// *
// *    @return    无
// */
//- (void)popBackFlutter:(UIButton *)sender
//{
//    [self.playerController shutdown];
//    self.playerController = nil;
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
////强制转屏
//- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
//{
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector  = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = orientation;
//        // 从2开始是因为0 1 两个参数已经被selector和target占用
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//}
//
//@end
