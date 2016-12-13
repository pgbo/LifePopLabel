//
//  LifePopLabel.h
//
//  Created by guangbool on 2016/12/7.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LifePopLabelArrowAttachSide) {
    LifePopLabelArrowAttachOnBottom = 0,    // 箭头在底部
    LifePopLabelArrowAttachOnTop            // 箭头在顶部
};

@interface LifePopLabel : UIView

@property (nonatomic, copy) NSString *text;
// default 13
@property (nonatomic) UIFont *textFont;
// default black color
@property (nonatomic) UIColor *textColor;

@property (nonatomic) NSTextAlignment textAlignment;
// Whether set intrinsic height to zero when text is empty. Default YES
@property (nonatomic) BOOL zeroIntrinsicHeightWhenTextEmpty;
// default 300
@property (nonatomic) CGFloat maxWidth;
// default 80
@property (nonatomic) CGFloat minWidth;
// default 1000
@property (nonatomic) CGFloat maxHeight;
// default 30
@property (nonatomic) CGFloat minHeight;
// default 1, 为 0 表示多行显示
@property (nonatomic) NSUInteger numbersOfLine;
// default (8, 10, 8, 10)
@property (nonatomic) UIEdgeInsets contentEdgeInsets;
// default 4
@property (nonatomic) CGFloat arrowHeight;
// 箭头角度，default 90 度
@property (nonatomic) CGFloat arrowAngleDegree;
// default 4
@property (nonatomic) CGFloat cornerRadius;
// 箭头相对于视图的头部的距离，和 arrowTrailing 两者取其一。默认 0
@property (nonatomic) CGFloat arrowLeading;
// 箭头相对于视图的尾部的距离，和 arrowLeading 两者取其一。默认 0
@property (nonatomic) CGFloat arrowTrailing;
// 箭头吸附的边，默认 bottom
@property (nonatomic) LifePopLabelArrowAttachSide arrowAttachSide;

// 填充颜色，默认黑色
@property (nonatomic) UIColor *fillColor;
// 气泡边框颜色，默认黑色
@property (nonatomic) UIColor *borderColor;
// 气泡边框的宽，默认 0.5
@property (nonatomic) CGFloat borderWidth;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithText:(NSString *)text;

- (CGSize)intrinsicContentSize;

@end
