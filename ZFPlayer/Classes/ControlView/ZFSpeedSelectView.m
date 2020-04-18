//
//  ZFSpeedSelectView.m
//  FDFullscreenPopGesture
//
//  Created by 刘思源 on 2020/4/5.
//

#import "ZFSpeedSelectView.h"
#import "UIView+ZFFrame.h"


@interface ZFSpeedSelectView ()

/** <#注释#> */
@property (nonatomic, strong) UILabel *topLabel;
/** <#注释#> */
@property (nonatomic, strong) NSArray <UIButton *>*speedBtns;

/** <#注释#> */
@property (nonatomic, strong) UIView *labelBottomLine;

/** <#注释#> */
@property (nonatomic, strong) UIVisualEffectView *effectView;



@end

@implementation ZFSpeedSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        self.speed  = 1;
    }
    return self;
}

- (void)addSubviews{    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    _effectView = [UIVisualEffectView new];
    [_effectView setEffect:blurEffect];
    _effectView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self addSubview:_effectView];
    
    _topLabel = [UILabel new];
    [self addSubview:_topLabel];
    _topLabel.font = [UIFont boldSystemFontOfSize:17];
    _topLabel.text = @"请选择播放速度";
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    
    _labelBottomLine = [UILabel new];
    [self addSubview:_labelBottomLine];
    _labelBottomLine.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    
    NSMutableArray *temps = @[].mutableCopy;
    for (int i = 0; i<6; i++) {
        CGFloat speed = speedsAtIndex(i);
        NSString *speedStr = [NSString stringWithFormat:@"%gX",speed];
        UIButton *speedBtn = [UIButton new];
        [speedBtn setTitle:speedStr forState:UIControlStateNormal];
        [speedBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
        [speedBtn setTitleColor:[UIColor colorWithRed:252/255.0 green:107/255.0 blue:90/255.0 alpha:1] forState:UIControlStateSelected];
        speedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:speedBtn];
        [speedBtn addTarget:self action:@selector(selectSpeed:) forControlEvents:UIControlEventTouchUpInside];
        [temps addObject:speedBtn];
        speedBtn.tag = i;
        if (speed == 1) {
            speedBtn.selected = YES;
        }
    }
    _speedBtns = temps.copy;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _topLabel.frame = CGRectMake(0, 0, self.zf_width, 64);
    _labelBottomLine.frame = CGRectMake(0, _topLabel.zf_bottom, self.zf_width, 1);
    _effectView.frame = self.bounds;
    
    CGFloat btnW = (self.zf_width - 10 *2)/3;
    CGFloat btnH = (self.zf_height - _topLabel.zf_bottom - 10 *3)/2;
    CGFloat startX = 0;
    CGFloat startY = _topLabel.zf_bottom;
    
    [_speedBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(startX + (10 + btnW) * (idx%3), startY + 10 + (10 +btnH) * (idx/3), btnW, btnH);
    }];
}

- (void)selectSpeed:(UIButton *)btn{
    self.speed = speedsAtIndex((int)btn.tag);
    [_speedBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = obj == btn;
    }];
    
}

- (void)setSpeed:(CGFloat)speed{
    _speed = speed;
    _changeSpeed?_changeSpeed(speed):0;
}


float speedsAtIndex(int i){
    float speeds[] = {0.5,0.75,1,1.25,1.5,2.0};
    return speeds[i];
}

@end

