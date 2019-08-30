//
//  MDProgressButton.m
//  ProgressButton
//
//  Created by 李永杰 on 2019/8/28.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "MDProgressButton.h"

@interface MDProgressButton ()

@property (nonatomic, strong) CAShapeLayer *fillLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) float currentTime;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation MDProgressButton

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self configProperties];
        [self drawCircle];
        [self addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpOutside];
    }
    return self;
}

- (void)startTimer {
    if (self.timer) {
        return;
    }
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        [self handleTime];
    });
    dispatch_resume(_timer);
}

- (void)handleTime {

    self.currentTime += 0.1;
    float progress = self.currentTime / self.duration;
    self.progress  = progress;

    if (self.currentTime > self.duration) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(complete:)]) {
            [self.delegate complete:self];
        }
        self.timer = nil;
    }
}

- (void)stopTimer {

    self.currentTime = 0;
    float progress   = self.currentTime / self.duration;
    self.progress    = progress;
    self.timer       = nil;
}

- (void)setProgress:(float)progress {

    _progress = progress;

    if (progress == 0) {
        self.progressLayer.hidden    = YES;
        self.progressLayer.strokeEnd = 0;
    } else {
        self.progressLayer.hidden    = NO;
        self.progressLayer.strokeEnd = progress;
    }
}

- (void)drawCircle {

    [self.layer addSublayer:self.fillLayer];
    [self.layer addSublayer:self.progressLayer];
}

- (void)configProperties {

    _duration    = 3;
    _progress    = 0;
    _lineWidth   = 5;
    _strokeColor = [UIColor redColor];
    _fillColor   = [UIColor yellowColor];
    _currentTime = 0;
}

- (CAShapeLayer *)fillLayer {
    if (!_fillLayer) {
        _fillLayer       = [CAShapeLayer layer];
        _fillLayer.frame = self.bounds;
        CGFloat width    = CGRectGetWidth(self.bounds);
        CGFloat height   = CGRectGetHeight(self.bounds);
        CGFloat radius   = width > height ? height : width;
        radius /= 2;
        UIBezierPath *path =
            [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, height / 2) radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
        self.fillLayer.path      = path.CGPath;
        self.fillLayer.fillColor = self.fillColor.CGColor;
    }
    return _fillLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        CGFloat width  = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        CGFloat radius = width > height ? height : width;
        radius /= 2;
        _progressLayer.frame       = self.bounds;
        _progressLayer.fillColor   = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = self.strokeColor.CGColor;
        _progressLayer.strokeEnd   = self.progress;
        _progressLayer.lineWidth   = self.lineWidth;
        _progressLayer.lineCap     = kCALineJoinBevel;
        _progressLayer.lineJoin    = kCALineJoinBevel;
        _progressLayer.hidden      = YES;
        UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, height / 2)
                                                                    radius:radius + self.lineWidth / 2.0
                                                                startAngle:-M_PI_2
                                                                  endAngle:2 * M_PI - M_PI_2
                                                                 clockwise:YES];
        _progressLayer.path = progressPath.CGPath;
    }
    return _progressLayer;
}
@end
