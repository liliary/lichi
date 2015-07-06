//
//  QRScanViewController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-23.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "QRScanViewController.h"
@interface QRScanViewController(){
    /// scan frame
    UIView *_topMask;
    UIView *_bottomMask;
    UIView *_leftMask;
    UIView *_rightMask;
    UIImageView *_leftTopCorner;
    UIImageView *_leftBottomCorner;
    UIImageView *_rightTopCorner;
    UIImageView *_rightBottomCorner;
    UIImageView *_scanRow;
    UILabel *_resultView;
    
    //// Timer
    NSTimer *_timer;
    
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_preview;
    AVCaptureConnection *_scanConn;
}
@end

@implementation QRScanViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self setupScaner];
    [self startScan];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scanAnimateBegin) userInfo:nil repeats:YES];
//    [_timer fire];
//    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        [_scanRow setRectOnTopOfView:_bottomMask];
    } completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self stopScan];
    [self scanAnimateStop];
    [super viewWillDisappear:animated];
}

#pragma mark - build views

-(void)initView{
    CGFloat topMaskHeight = 115.0;
    CGFloat leftMaskWidth = 30.0;
    CGFloat rightMaskWidth = 30.0;
    CGFloat bottomMaskHeight = 85.0;
    
    _topMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, topMaskHeight)];
    _bottomMask = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-bottomMaskHeight,320, bottomMaskHeight)];
    _leftMask = [[UIView alloc] initWithFrame:CGRectMake(0, _topMask.bounds.size.height, leftMaskWidth, self.view.bounds.size.height-_topMask.bounds.size.height-_bottomMask.bounds.size.height)];
    _rightMask = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-rightMaskWidth, _topMask.bounds.size.height, rightMaskWidth, self.view.bounds.size.height-_topMask.bounds.size.height-_bottomMask.bounds.size.height)];
    [self setMaskAttribute:@[_topMask,_bottomMask,_leftMask,_rightMask]];

    _leftTopCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_corner_lt"]];
    _rightTopCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_corner_rt"]];
    _leftBottomCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_corner_lb"]];
    _rightBottomCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_corner_rb"]];
    _scanRow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_row"]];
    
    //// size
//    sizeFitAll(@[_leftBottomCorner,_rightBottomCorner,_leftTopCorner,_rightTopCorner,_scanRow]);
    
    //// position
    [[[_leftTopCorner fitSize] setRectOnRightSideOfView:_leftMask] setRectBelowOfView:_topMask];
    [[[_rightTopCorner fitSize] setRectOnLeftSideOfView:_rightMask] setRectBelowOfView:_topMask];
    [[[_leftBottomCorner fitSize] setRectOnRightSideOfView:_leftMask] setRectOnTopOfView:_bottomMask];
    [[[_rightBottomCorner fitSize] setRectOnLeftSideOfView:_rightMask] setRectOnTopOfView:_bottomMask];
    [[[_scanRow fitSize] setRectBelowOfView:_topMask] setCenterOfViewHorizentail:_topMask];
    
    [self.view addSubViews:@[_topMask,_bottomMask,_leftMask,_rightMask,_leftTopCorner,_rightTopCorner,_leftBottomCorner,_rightBottomCorner,_scanRow]];    
}

-(void)setMaskAttribute:(NSArray*)views{
    for (UIView *v in views) {
        [v setBackgroundColor:[UIColor colorWithHexTransparent:0xcc000000]];
    }
}

#pragma mark - camera & preview

-(void)setupScaner{
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    _session = [[AVCaptureSession alloc] init];
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_session addInput:_input];
    [_session addOutput:_output];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    
    
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = [[UIScreen mainScreen] bounds];
    
    _scanConn = _preview.connection;
    _scanConn.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    [self.view.layer insertSublayer:_preview atIndex:0];
}
-(BOOL)isCamerAvailable{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return [videoDevices count] >0;
}

#pragma mark - scan & decode

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]){
            NSString *result = [(AVMetadataMachineReadableCodeObject*)current stringValue];
            alertShow(result);
            [self scanAnimateStop];
            [self stopScan];
        }
    }
}

-(void)startScan{
    [_session startRunning];
}

-(void)stopScan{
    [_session stopRunning];
}

#pragma mark - Animate

-(void)scanAnimateBegin{
    [UIView animateWithDuration:2.1 animations:^{
        [_scanRow setRectOnTopOfView:_bottomMask];
    } completion:^(BOOL finished) {
        [_scanRow setRectBelowOfView:_topMask];
    }];
}

-(void)scanAnimateStop{
    if (_timer != nil && _timer.isValid) {
        [_timer invalidate];
    }
    _timer = nil;
}

@end
