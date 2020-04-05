//
//  ZFSpeedSelectView.h
//  FDFullscreenPopGesture
//
//  Created by 刘思源 on 2020/4/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFSpeedSelectView : UIView

/** <#注释#> */
@property (nonatomic, assign) CGFloat speed;

/** <#注释#> */
@property (nonatomic, strong) void (^changeSpeed)(CGFloat speed);

@end

NS_ASSUME_NONNULL_END
