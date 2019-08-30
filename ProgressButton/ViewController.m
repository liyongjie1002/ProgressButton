//
//  ViewController.m
//  ProgressButton
//
//  Created by 李永杰 on 2019/8/28.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "ViewController.h"
#import "MDProgressButton.h"

@interface ViewController () <MDProgressButtonDelegate>

@property (nonatomic, strong) MDProgressButton  *circleButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view addSubview:self.circleButton];
 
}

-(void)complete:(MDProgressButton *)btn {
    NSLog(@"完成回调，弹窗啊什么的");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"结束" message:@"本次运动结束" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}

-(MDProgressButton *)circleButton {
    if (!_circleButton) {
        _circleButton = [[MDProgressButton alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
        [_circleButton setTitle:@"三秒内结束" forState:UIControlStateNormal];
        [_circleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _circleButton.delegate = self;
    }
    return _circleButton;
}

@end
