//
//  MDProgressButton.h
//  ProgressButton
//
//  Created by 李永杰 on 2019/8/28.
//  Copyright © 2019 muheda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class MDProgressButton;
@protocol MDProgressButtonDelegate <NSObject>
@optional;
-(void)complete:(MDProgressButton *)btn;
@end


@interface MDProgressButton : UIButton

@property (nonatomic, assign) CGFloat   duration;

@property (nonatomic, assign) float   progress;

@property (nonatomic, assign) CGFloat   lineWidth;

@property (nonatomic, strong) UIColor   *fillColor;

@property (nonatomic, strong) UIColor   *strokeColor;

@property (nonatomic, weak) id<MDProgressButtonDelegate> delegate;

-(void)stopTimer;

@end
 
