//
//  LifePopLabel.m
//
//  Created by guangbool on 2016/12/7.
//  Copyright © 2016年. All rights reserved.
//

#import "LifePopLabel.h"

@interface LifePopBackgroundView : UIView

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

@end

@implementation LifePopBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureDefaults];
        [self setNeedsDisplay];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureDefaults];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)configureDefaults {
    _arrowHeight = 4;
    _arrowAngleDegree = 90;
    _cornerRadius = 4;
    _arrowLeading = 0;
    _arrowTrailing = 0;
    _arrowAttachSide = LifePopLabelArrowAttachOnBottom;
    _fillColor = [UIColor blackColor];
    _borderColor = [UIColor blackColor];
    _borderWidth = 0.5f;
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self setNeedsDisplay];
}

- (void)setArrowAngleDegree:(CGFloat)arrowAngleDegree {
    _arrowAngleDegree = arrowAngleDegree;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)setArrowLeading:(CGFloat)arrowLeading {
    _arrowLeading = arrowLeading;
    [self setNeedsDisplay];
}

- (void)setArrowTrailing:(CGFloat)arrowTrailing {
    _arrowTrailing = arrowTrailing;
    [self setNeedsDisplay];
}

- (void)setArrowAttachSide:(LifePopLabelArrowAttachSide)arrowAttachSide {
    _arrowAttachSide = arrowAttachSide;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self setNeedsDisplay];
}

- (UIBezierPath *)getDrawBezierPathWithRect:(CGRect)rect {
    
    UIBezierPath *path = nil;
    if (self.arrowHeight <= 0) {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
        return path;
    }
    
    path = [UIBezierPath bezierPath];
    
    // 箭头角的对边边长
    double arrowTriangleSideLength = ({
        double degreeAngle = ((90-self.arrowAngleDegree/2)/180.f)*M_PI;
        double length = (2*self.arrowHeight*(sqrt(1 - pow(sin(degreeAngle), 2))))/sin(degreeAngle);
        length;
    });
    
    CGFloat height = CGRectGetHeight(rect);
    CGFloat width = CGRectGetWidth(rect);
    CGFloat cornerRd = self.cornerRadius;
    CGFloat arrowHt = self.arrowHeight;
    
    if (height < (2*cornerRd + arrowHt) || width < (2*cornerRd + arrowTriangleSideLength)) {
        cornerRd = 0;
    }
    
    // 矩形区域高度，宽度
    CGFloat rectangleHeight = height - arrowHt;
    CGFloat rectangleWidth = width;
    CGFloat rectangleOriginY = (self.arrowAttachSide == LifePopLabelArrowAttachOnTop)?arrowHt:0;
    
    
    CGPoint p_l_t = CGPointMake(0, cornerRd),                                           // point:left top
            p_l_b = CGPointMake(0, rectangleHeight - cornerRd),                         // point:left bottom
            p_b_l = CGPointMake(cornerRd, rectangleHeight),                             // point:bottom left
            p_b_r = CGPointMake(rectangleWidth - cornerRd, rectangleHeight),            // point:bottom left
            p_r_b = CGPointMake(rectangleWidth, rectangleHeight - cornerRd),            // point:right bottom
            p_r_t = CGPointMake(rectangleWidth, cornerRd),                              // point:right top
            p_t_r = CGPointMake(rectangleWidth - cornerRd, 0),                          // point:top left
            p_t_l = CGPointMake(cornerRd, 0);                                           // point:top left
    
    p_l_t.y += rectangleOriginY;
    p_l_b.y += rectangleOriginY;
    p_b_l.y += rectangleOriginY;
    p_b_r.y += rectangleOriginY;
    p_r_b.y += rectangleOriginY;
    p_r_t.y += rectangleOriginY;
    p_t_r.y += rectangleOriginY;
    p_t_l.y += rectangleOriginY;
    
    // Curve control point
    CGPoint control_p_b_r = CGPointMake(p_r_b.x, p_b_r.y),          // bottom right
            control_p_r_t = CGPointMake(p_r_t.x, p_t_r.y),          // right top
            control_p_t_l = CGPointMake(p_l_t.x, p_t_l.y),          // right top
            control_p_l_b = CGPointMake(p_l_b.x, p_b_l.y);          // right top
    
    // 箭头的中心点 x 值
    CGFloat arrowCenterX;
    if (self.arrowLeading > 0) {
        arrowCenterX = self.arrowLeading;
    } else if (self.arrowTrailing > 0) {
        arrowCenterX = rectangleWidth - self.arrowTrailing;
    } else if (self.arrowLeading < 0) {
        arrowCenterX = rectangleWidth + self.arrowLeading;
    } else if (self.arrowTrailing < 0) {
        arrowCenterX = - self.arrowTrailing;
    } else {
        arrowCenterX = rectangleWidth/2;
    }
    
    if (self.arrowAttachSide == LifePopLabelArrowAttachOnBottom) {
        CGFloat arrowMinY = CGRectGetHeight(rect) - arrowHt;
        CGPoint arw_p_topleft = CGPointMake(arrowCenterX - arrowTriangleSideLength/2, arrowMinY);
        CGPoint arw_p_topright = CGPointMake(arrowCenterX + arrowTriangleSideLength/2, arrowMinY);
        CGPoint arw_p_bottom = CGPointMake(arrowCenterX, arrowMinY + arrowHt);
        
        [path moveToPoint:arw_p_bottom];
        [path addLineToPoint:arw_p_topright];
        [path addLineToPoint:p_b_r];
        [path addQuadCurveToPoint:p_r_b controlPoint:control_p_b_r];
        [path addLineToPoint:p_r_t];
        [path addQuadCurveToPoint:p_t_r controlPoint:control_p_r_t];
        [path addLineToPoint:p_t_l];
        [path addQuadCurveToPoint:p_l_t controlPoint:control_p_t_l];
        [path addLineToPoint:p_l_b];
        [path addQuadCurveToPoint:p_b_l controlPoint:control_p_l_b];
        [path addLineToPoint:arw_p_topleft];
        [path addLineToPoint:arw_p_bottom];
        
    } else {
        CGPoint arw_p_top = CGPointMake(arrowCenterX, 0);
        CGPoint arw_p_bottomleft = CGPointMake(arrowCenterX - arrowTriangleSideLength/2, arrowHt);
        CGPoint arw_p_bottomright = CGPointMake(arrowCenterX + arrowTriangleSideLength/2, arrowHt);
        
        [path moveToPoint:arw_p_top];
        [path addLineToPoint:arw_p_bottomleft];
        [path addLineToPoint:p_t_l];
        [path addQuadCurveToPoint:p_l_t controlPoint:control_p_t_l];
        [path addLineToPoint:p_l_b];
        [path addQuadCurveToPoint:p_b_l controlPoint:control_p_l_b];
        [path addLineToPoint:p_b_r];
        [path addQuadCurveToPoint:p_r_b controlPoint:control_p_b_r];
        [path addLineToPoint:p_r_t];
        [path addQuadCurveToPoint:p_t_r controlPoint:control_p_r_t];
        [path addLineToPoint:arw_p_bottomright];
        [path addLineToPoint:arw_p_top];
    }
    
    return path;
}

- (void)drawRect:(CGRect)rect {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *drawPath = [self getDrawBezierPathWithRect:rect];
    drawPath.lineWidth = self.borderWidth;
    [self.fillColor setFill];
    [self.borderColor setStroke];
    [drawPath fill];
    [drawPath stroke];
    
    // Restore
    CGContextRestoreGState(context);
}

@end


@interface LifePopLabel ()

@property (nonatomic) LifePopBackgroundView *popBackgroundView;
@property (nonatomic) UILabel *label;

@end

@implementation LifePopLabel

- (instancetype)init {
    return [self initWithText:nil];
}

- (instancetype)initWithText:(NSString *)text {
    if (self = [super init]) {
        _text = [text copy];
        [self configureDefaults];
        [self configureViews];
        [self updateViewsFrame];
        [self invalidateIntrinsicContentSize];
    }
    return self;
}

- (LifePopBackgroundView *)popBackgroundView {
    if (!_popBackgroundView) {
        _popBackgroundView = [[LifePopBackgroundView alloc]init];
        _popBackgroundView.clipsToBounds = YES;
        _popBackgroundView.backgroundColor = [UIColor clearColor];
        _popBackgroundView.arrowHeight = self.arrowHeight;
        _popBackgroundView.arrowAngleDegree = self.arrowAngleDegree;
        _popBackgroundView.cornerRadius = self.cornerRadius;
        _popBackgroundView.arrowLeading = self.arrowLeading;
        _popBackgroundView.arrowTrailing = self.arrowTrailing;
        _popBackgroundView.arrowAttachSide = self.arrowAttachSide;
        _popBackgroundView.fillColor = self.fillColor;
        _popBackgroundView.borderColor = self.borderColor;
        _popBackgroundView.borderWidth = self.borderWidth;
    }
    return _popBackgroundView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.text = self.text;
        _label.textColor = self.textColor?:[UIColor blackColor];
        _label.font = self.textFont?:[UIFont systemFontOfSize:13];
        _label.numberOfLines = self.numbersOfLine;
        [self updateLabelPreferredMaxLayoutWidth];
    }
    return _label;
}

- (void)configureDefaults {
    _textFont = [UIFont systemFontOfSize:13];
    _textColor = [UIColor blackColor];
    _zeroIntrinsicHeightWhenTextEmpty = YES;
    _maxWidth = 300;
    _minWidth = 80;
    _maxHeight = 1000;
    _minHeight = 30;
    _numbersOfLine = 1;
    _contentEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    _arrowHeight = 4;
    _arrowAngleDegree = 90;
    _cornerRadius = 4;
    _arrowLeading = 0;
    _arrowTrailing = 0;
    _arrowAttachSide = LifePopLabelArrowAttachOnBottom;
    _fillColor = [UIColor blackColor];
    _borderColor = [UIColor blackColor];
    _borderWidth = 0.5f;
}

- (void)configureViews {
    self.frame = CGRectMake(0, 0, _minWidth, _minHeight);
    
    [self addSubview:self.popBackgroundView];
    [self addSubview:self.label];
}

- (void)updateLabelPreferredMaxLayoutWidth {
    CGFloat preferredMaxLayoutWidth = (self.maxWidth - (self.contentEdgeInsets.left+self.contentEdgeInsets.right))?:0;
    _label.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    _label.text = text;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    _label.font = textFont;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    _label.textAlignment = textAlignment;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setZeroIntrinsicHeightWhenTextEmpty:(BOOL)zeroIntrinsicHeightWhenTextEmpty {
    _zeroIntrinsicHeightWhenTextEmpty = zeroIntrinsicHeightWhenTextEmpty;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setMaxWidth:(CGFloat)maxWidth {
    _maxWidth = maxWidth;
    [self updateLabelPreferredMaxLayoutWidth];
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setMinWidth:(CGFloat)minWidth {
    _minWidth = minWidth;
    [self updateLabelPreferredMaxLayoutWidth];
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setMaxHeight:(CGFloat)maxHeight {
    _maxHeight = maxHeight;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setMinHeight:(CGFloat)minHeight {
    _minHeight = minHeight;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setNumbersOfLine:(NSUInteger)numbersOfLine {
    _numbersOfLine = numbersOfLine;
    _label.numberOfLines = numbersOfLine;
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    [self updateLabelPreferredMaxLayoutWidth];
    [self updateViewsFrame];
    [self invalidateIntrinsicContentSize];
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self updateViewsFrame];
    _popBackgroundView.arrowHeight = arrowHeight;
    [self invalidateIntrinsicContentSize];
}

- (void)setArrowAngleDegree:(CGFloat)arrowAngleDegree {
    _arrowAngleDegree = arrowAngleDegree;
    [self updateViewsFrame];
    _popBackgroundView.arrowAngleDegree = arrowAngleDegree;
    [self invalidateIntrinsicContentSize];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    _popBackgroundView.cornerRadius = cornerRadius;
}

- (void)setArrowLeading:(CGFloat)arrowLeading {
    _arrowLeading = arrowLeading;
    _popBackgroundView.arrowLeading = arrowLeading;
    [self invalidateIntrinsicContentSize];
}

- (void)setArrowTrailing:(CGFloat)arrowTrailing {
    _arrowTrailing = arrowTrailing;
    _popBackgroundView.arrowTrailing = arrowTrailing;
    [self invalidateIntrinsicContentSize];
}

- (void)setArrowAttachSide:(LifePopLabelArrowAttachSide)arrowAttachSide {
    _arrowAttachSide = arrowAttachSide;
    [self updateViewsFrame];
    _popBackgroundView.arrowAttachSide = arrowAttachSide;
    [self invalidateIntrinsicContentSize];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    _popBackgroundView.fillColor = fillColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    _popBackgroundView.borderColor = borderColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    _popBackgroundView.borderWidth = borderWidth;
}

- (void)updateViewsFrame {
    
    // update self frame
    
    CGFloat viewWidth, viewHeight;
    
    // text size
    CGSize labelIntrinsicSize = [self.label intrinsicContentSize];
    
    viewWidth = self.contentEdgeInsets.left + labelIntrinsicSize.width + self.contentEdgeInsets.right;
    viewWidth = MIN(viewWidth, self.maxWidth);
    viewWidth = MAX(viewWidth, self.minWidth);
    
    if (self.text.length == 0 && self.zeroIntrinsicHeightWhenTextEmpty) {
        viewHeight = 0;
    } else {
        if (self.arrowAttachSide == LifePopLabelArrowAttachOnBottom) {
            viewHeight = self.contentEdgeInsets.top + labelIntrinsicSize.height + self.contentEdgeInsets.bottom + self.arrowHeight;
        } else {
            viewHeight = self.arrowHeight + self.contentEdgeInsets.top + labelIntrinsicSize.height + self.contentEdgeInsets.bottom;
        }
        viewHeight = MIN(viewHeight, self.maxHeight);
        viewHeight = MAX(viewHeight, self.minHeight);
    }
    
    self.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    
    // update pop background view frame
    _popBackgroundView.frame = self.bounds;
    
    // update label frame
    if (viewHeight <= 0) {
        _label.frame = self.bounds;
    } else {
        CGPoint labelOrigin;
        labelOrigin.x = self.contentEdgeInsets.left;
        labelOrigin.y = self.contentEdgeInsets.top;
        if (self.arrowAttachSide == LifePopLabelArrowAttachOnTop) {
            labelOrigin.y += self.arrowHeight;
        }
        _label.frame = CGRectMake(labelOrigin.x, labelOrigin.y, labelIntrinsicSize.width, labelIntrinsicSize.height);
    }
}

- (CGSize)intrinsicContentSize {
    return self.bounds.size;
}

@end
