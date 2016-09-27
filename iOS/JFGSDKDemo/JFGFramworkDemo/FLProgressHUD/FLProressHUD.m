//
//  FLProressHUD.m
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/20.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import "FLProressHUD.h"
#import "FLProgressHUDIndicatorView.h"

#define iOS7 (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)

@interface FLProressHUD()
{
    UIView *parentView;
    FLProgressHUDIndicatorView *indicatorViewManager;
}
@end

@implementation FLProressHUD

@synthesize HUDView = _HUDView;
@synthesize textLabel = _textLabel;
@synthesize progressIndicatorView = _progressIndicatorView;


-(instancetype)initWithStyle:(FLProgressHUDStyle)style
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.hidden = YES;
        self.opaque = NO;
        
        _showProgressIndicatorView = YES;
        _marginInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        _contentInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        _position = FLProgressHUDPositionCenter;
        
        _style = style;
    }
    return self;
}

-(void)showInView:(UIView *)supView animated:(BOOL)animated
{
    self.frame = supView.bounds;
    parentView = supView;
    [supView addSubview:self];
    [self updataView:NO];
    
    if (animated) {
        [self showForAnimation];
    }else{
        self.alpha = 1.0f;
        self.hidden = NO;
    }
    if (_flProressHUDDidAppear) {
        _flProressHUDDidAppear(self);
    }
}

-(void)showForAnimation
{
    self.hidden = NO;
    _HUDView.alpha = 0.0f;
    _HUDView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    _HUDView.hidden = NO;
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _HUDView.alpha = 1.0f;
        _HUDView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        
    }];
}


-(void)hide:(BOOL)animation delay:(NSTimeInterval)timeInterval
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hide:animation];
        
    });
}

-(void)hide:(BOOL)animation
{
    if (animation) {
        [self hideForAnimation];
    }else{
        self.hidden = YES;
        [self removeFromSuperview];
    }
    
    if (_flProressHUDDisappear) {
        _flProressHUDDisappear(self);
    }
    
}


-(void)hideForAnimation
{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _HUDView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        _HUDView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];

}

#pragma mark 布局视图
//根据文字，显示方式，显示位置确定视图的大小
-(void)updataView:(BOOL)animated
{
    if (!parentView) {
        return;
    }
    void (^updata)(void) = ^{
        //Indicator size
        CGRect indicatorFrame = self.progressIndicatorView.frame;
        indicatorFrame.origin.y = self.contentInsets.top;
        
        CGFloat maxContentWidth = self.frame.size.width-self.marginInsets.left-self.marginInsets.right-self.contentInsets.left-self.contentInsets.right;
        CGFloat maxContentHeight = self.frame.size.height-self.marginInsets.top-self.marginInsets.bottom-self.contentInsets.top-self.contentInsets.bottom;
        
        CGSize maxContentSize = (CGSize){maxContentWidth, maxContentHeight};
        
        //Label size
        CGRect labelFrame = CGRectZero;
        if (iOS7) {
            NSDictionary *attributes = @{NSFontAttributeName : self.textLabel.font};
            labelFrame.size = [self.textLabel.text boundingRectWithSize:maxContentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        }else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            labelFrame.size = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:maxContentSize lineBreakMode:self.textLabel.lineBreakMode];
#pragma clang diagnostic pop
        }
        
        labelFrame.origin.y = CGRectGetMaxY(indicatorFrame);
        
        if (!CGRectIsEmpty(labelFrame) && !CGRectIsEmpty(indicatorFrame)) {
            labelFrame.origin.y += 10.0f;
        }
        
        //HUD size
        CGSize size = CGSizeZero;
        
        CGFloat width = MIN(self.contentInsets.left+MAX(indicatorFrame.size.width, labelFrame.size.width)+self.contentInsets.right, self.frame.size.width-self.marginInsets.left-self.marginInsets.right);
        
        CGFloat height = CGRectGetMaxY(labelFrame)+self.contentInsets.bottom;
        
        if (_showProgressIndicatorView && width<height) {
            
            CGFloat uniSize = MAX(width, height);
            
            size.width = uniSize;
            size.height = uniSize;
            
            CGFloat heightDelta = uniSize-height;
            
            labelFrame.origin.y += heightDelta/2.0f;
            indicatorFrame.origin.y += heightDelta/2.0f;
            
        }else if (_showProgressIndicatorView){
            
            size.width = width;
            size.height = height;
            
            
        }else{
           
            //只显示文字的时候，缩小文字与上下边距
            size.width = width;
            size.height = height - 10;
            labelFrame.origin.y -= 5;
            
            
        }
        
        CGPoint center = CGPointMake(size.width/2.0f, size.height/2.0f);
        indicatorFrame.origin.x = center.x-indicatorFrame.size.width/2.0f;
        labelFrame.origin.x = center.x-labelFrame.size.width/2.0f;
        
        
        [self setHUDViewFrameCenterWithSize:size];
        
        self.progressIndicatorView.frame = indicatorFrame;
        self.textLabel.frame = labelFrame;
    };
    
    
    if (animated) {
        
        [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:updata completion:nil];
        
    }else{
        updata();
    }
    
}


//设置HUD的Frame
- (void)setHUDViewFrameCenterWithSize:(CGSize)size {
    CGRect frame = CGRectZero;
    
    frame.size = size;
    
    CGRect viewBounds = self.bounds;
    
    CGPoint center = CGPointMake(viewBounds.origin.x+viewBounds.size.width/2.0f, viewBounds.origin.y+viewBounds.size.height/2.0f);
    
    switch (self.position) {
        
        case FLProgressHUDPositionTop:
            frame.origin.x = center.x-frame.size.width/2.0f;
            frame.origin.y = self.marginInsets.top;
            break;
        case FLProgressHUDPositionCenter:
            frame.origin.x = center.x-frame.size.width/2.0f;
            frame.origin.y = center.y-frame.size.height/2.0f;
            break;
        case FLProgressHUDPositionBottom:
            frame.origin.x = center.x-frame.size.width/2.0f;
            frame.origin.y = viewBounds.size.height-self.marginInsets.bottom-frame.size.height;
            break;
    }
    
    _HUDView.frame = frame;
}


#pragma mark setters and getters

-(UIView *)HUDView
{
    if (!_HUDView) {
        
        if ([UIVisualEffectView class]) {
            
            //ios8的毛玻璃效果
            UIBlurEffectStyle effect;
            if (self.style == FLProgressHUDStyleDark) {
                effect = UIBlurEffectStyleDark;
            }
            else if(self.style == FLProgressHUDStyleLight) {
                effect = UIBlurEffectStyleExtraLight;
            }

            _HUDView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:effect]];
            
        }else{
            _HUDView = [[UIView alloc] init];
            
            if (_style == FLProgressHUDStyleDark) {
                _HUDView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
            }
            else if (_style == FLProgressHUDStyleLight) {
                
                _HUDView.backgroundColor = [UIColor colorWithWhite:0.97f alpha:0.8f];
            }
        }
        

        _HUDView.layer.cornerRadius = 10.0f;
        _HUDView.layer.masksToBounds = YES;
        [self addSubview:_HUDView];
        
    }
    return _HUDView;
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.opaque = NO;
        _textLabel.textColor = (_style == FLProgressHUDStyleDark ? [UIColor whiteColor] : [UIColor blackColor]);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _textLabel.numberOfLines = 0;

        [self.HUDView addSubview:_textLabel];
    }
    return _textLabel;
}

-(UIView *)progressIndicatorView
{
    if (!_showProgressIndicatorView) {
        
        if (_progressIndicatorView) {
            _progressIndicatorView.hidden = YES;
        }
        
        return nil;
    }
    
    if (!_progressIndicatorView) {
        
        
        if (_indicatorViewStyle == FLProgressHUDIndicatorViewPan) {
            
            indicatorViewManager = [[FLProgressHUDIndicatorView alloc]initWithStyle:_style IndicatorViewStyle:FLProgressHUDIndicatorViewPan];
            
            _progressIndicatorView = indicatorViewManager.indicatorView;
            
            
        }else if (_indicatorViewStyle == FLProgressHUDIndicatorViewRing){
            
            indicatorViewManager = [[FLProgressHUDIndicatorView alloc]initWithStyle:_style IndicatorViewStyle:FLProgressHUDIndicatorViewRing];
            
             _progressIndicatorView = indicatorViewManager.indicatorView;
            
        }else{
            
            indicatorViewManager = [[FLProgressHUDIndicatorView alloc]initWithStyle:_style IndicatorViewStyle:FLProgressHUDIndicatorViewSystem];
            
            _progressIndicatorView = indicatorViewManager.indicatorView;
            
        }
        
        [self.HUDView addSubview:_progressIndicatorView];
    }
    _progressIndicatorView.hidden = NO;
    return _progressIndicatorView;
}

-(void)setProgressIndicatorView:(UIView *)progressIndicatorView
{
    if (_progressIndicatorView) {
        indicatorViewManager = nil;
        [_progressIndicatorView removeFromSuperview];
    }
    
    _progressIndicatorView = progressIndicatorView;
    [self updataView:NO];
}

-(void)setProgress:(CGFloat)progress
{
    if (!indicatorViewManager) {
        return;
    }
    
    [indicatorViewManager setProgress:progress];
    
}


-(void)setPosition:(FLProgressHUDPosition)position
{
    if (_position == position) {
        return;
    }
    _position = position;
    [self updataView:NO];
}

-(void)setShowProgressIndicatorView:(BOOL)showProgressIndicatorView
{
    if (_showProgressIndicatorView == showProgressIndicatorView) {
        return;
    }
    _showProgressIndicatorView = showProgressIndicatorView;
    [self updataView:NO];
}

-(void)setContentInsets:(UIEdgeInsets)contentInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_contentInsets, contentInsets)) {
        return;
    }
    _contentInsets = contentInsets;
    [self updataView:NO];
}

-(void)setMarginInsets:(UIEdgeInsets)marginInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_marginInsets, marginInsets)) {
        return;
    }
    _marginInsets = marginInsets;
    [self updataView:NO];
}


#pragma mark Helper
+(NSArray *)allFLProgressHUDForView:(UIView *)superView
{
    NSMutableArray *huds = [[NSMutableArray alloc]init];
    
    NSArray *subViews = superView.subviews;
    [subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[self class]]) {
            [huds addObject:obj];
        }
    }];
    
    return huds;
}

+(FLProressHUD *)showIndicatorViewFLProgressHUDWithIndicatorViewStyle:(FLProgressHUDIndicatorViewStyle)indicatorViewStyle hudStyle:(FLProgressHUDStyle)style position:(FLProgressHUDPosition)position text:(NSString *)text superView:(UIView *)superView
{
    FLProressHUD *hud = [[FLProressHUD alloc]initWithStyle:style];
    hud.textLabel.text = text;
    hud.position = position;
    hud.indicatorViewStyle = indicatorViewStyle;
    [hud showInView:superView animated:YES];
    return hud;
}

+(FLProressHUD *)showTextFLProgressHUDWithStyle:(FLProgressHUDStyle)style position:(FLProgressHUDPosition)position text:(NSString *)text superView:(UIView *)superView
{
    FLProressHUD *hud = [[FLProressHUD alloc]initWithStyle:style];
    hud.textLabel.text = text;
    hud.position = position;
    hud.showProgressIndicatorView = NO;
    [hud showInView:superView animated:YES];
    return hud;
}

+(void)showTextFLHUDForStyleLightWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position
{
    [FLProressHUD hideAllHUDForView:superView animation:NO delay:0];
    FLProressHUD *hud = [[FLProressHUD alloc]initWithStyle:FLProgressHUDStyleLight];
    hud.textLabel.text = text;
    hud.position = position;
    hud.showProgressIndicatorView = NO;
    [hud showInView:superView animated:YES];

}

+(void)showTextFLHUDForStyleDarkWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position
{
    [FLProressHUD hideAllHUDForView:superView animation:NO delay:0];
    FLProressHUD *hud = [[FLProressHUD alloc]initWithStyle:FLProgressHUDStyleDark];
    hud.textLabel.text = text;
    hud.position = position;
    hud.showProgressIndicatorView = NO;
    [hud showInView:superView animated:YES];
}

+(void)showIndicatorViewFLHUDForStyleLightWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position
{
    [FLProressHUD hideAllHUDForView:superView animation:NO delay:0];
    FLProressHUD *hud = [[FLProressHUD alloc]initWithStyle:FLProgressHUDStyleLight];
    hud.textLabel.text = text;
    hud.position = position;
    hud.showProgressIndicatorView = YES;
    [hud showInView:superView animated:YES];
}

+(void)showIndicatorViewFLHUDForStyleDarkWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position
{
    [FLProressHUD hideAllHUDForView:superView animation:NO delay:0];
    
    FLProressHUD *hud = [[FLProressHUD alloc]initWithStyle:FLProgressHUDStyleDark];
    hud.textLabel.text = text;
    hud.position = position;
    hud.showProgressIndicatorView = YES;
    [hud showInView:superView animated:YES];
}

+(void)hideAllHUDForView:(UIView *)superView animation:(BOOL)animation delay:(NSTimeInterval)timeInterval
{
    NSArray *huds = [FLProressHUD allFLProgressHUDForView:superView];
    [huds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FLProressHUD *hud = obj;
        [hud hide:animation delay:timeInterval];
    }];
}


@end
