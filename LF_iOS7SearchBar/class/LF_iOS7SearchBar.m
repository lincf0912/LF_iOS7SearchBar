//
//  LF_iOS7SearchBar.m
//  LF_iOS7SearchBar
//
//  Created by LamTsanFeng on 2017/9/29.
//  Copyright © 2017年 LamTsanFeng. All rights reserved.
//


#import "LF_iOS7SearchBar.h"


@interface LF_iOS7SearchBarTextField : UITextField

@end

@implementation LF_iOS7SearchBarTextField

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super placeholderRectForBounds:bounds];
    
    if (!(self.editing || self.text.length || self.attributedText.length)) {
        CGFloat width = [self.attributedPlaceholder boundingRectWithSize:bounds.size options:NSStringDrawingUsesFontLeading context:nil].size.width;
        textRect.origin.x = (bounds.size.width - width) / 2;
    }
    
    return textRect;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect viewRect = [super leftViewRectForBounds:bounds];
    
    if (!(self.editing || self.text.length || self.attributedText.length)) {
        CGFloat width = [self.attributedPlaceholder boundingRectWithSize:bounds.size options:NSStringDrawingUsesFontLeading context:nil].size.width;
        viewRect.origin.x = (bounds.size.width - width) / 2 - viewRect.size.width;
    }
    
    return viewRect;
}

@end

static const float iOS7SearchBarDefaultHeight_V = 44.f;
static const float iOS7SearchBarDefaultHeight_H = 32.f;

#define iOS7SearchBarViewMargin 7.f
#define iOS7SearchBarBundleImageNamed(name) [UIImage imageNamed:[NSString stringWithFormat:@"LF_iOS7SearchBar.bundle/%@", name]]


@interface LF_iOS7SearchBar () <UITextFieldDelegate>

@property(nonatomic,strong) LF_iOS7SearchBarTextField *textField;
@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UIButton *cancelButton;

@end

@implementation LF_iOS7SearchBar

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buidView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buidView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (frame.size.height > iOS7SearchBarDefaultHeight_V || frame.size.height < iOS7SearchBarDefaultHeight_H) {
        [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, iOS7SearchBarDefaultHeight_V)];
    } else {
        [super setFrame:frame];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 适配上下间距计算 */
    CGFloat margin = iOS7SearchBarViewMargin - (iOS7SearchBarDefaultHeight_V - iOS7SearchBarDefaultHeight_H)/2 + (self.frame.size.height - iOS7SearchBarDefaultHeight_H)/2;
    
    if (_cancelButton) {
        CGFloat width = [_cancelButton.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_cancelButton.titleLabel.font} context:nil].size.width + iOS7SearchBarViewMargin * 2;
        _cancelButton.frame = CGRectMake(self.frame.size.width-width, margin, width, self.frame.size.height - margin * 2);
    }
    if (_textField) {
        _textField.frame = CGRectMake(iOS7SearchBarViewMargin, margin, self.frame.size.width-iOS7SearchBarViewMargin*2 - (self.showsCancelButton ? CGRectGetWidth(_cancelButton.frame) : 0), self.frame.size.height - margin * 2);
    }
}

-(void)buidView{
    
    _cancelButton = ({
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = @"取消";
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        CGFloat width = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width + iOS7SearchBarViewMargin * 2;
        cancelButton.frame = CGRectMake(self.frame.size.width-width, iOS7SearchBarViewMargin, width, self.frame.size.height - iOS7SearchBarViewMargin * 2);
        cancelButton.titleLabel.font = font;
        [cancelButton addTarget:self
                         action:@selector(cancelButtonTouched)
               forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:title forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithWhite:.35f alpha:1.f] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        cancelButton.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin;
        
        cancelButton;
    });
    [self addSubview:_cancelButton];
    
    
    _textField = ({
        LF_iOS7SearchBarTextField *textField = [[LF_iOS7SearchBarTextField alloc] initWithFrame:CGRectMake(iOS7SearchBarViewMargin, iOS7SearchBarViewMargin, self.frame.size.width-iOS7SearchBarViewMargin*2, self.frame.size.height - iOS7SearchBarViewMargin * 2)];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.returnKeyType = UIReturnKeySearch;
        textField.enablesReturnKeyAutomatically = YES;
        textField.font = [UIFont systemFontOfSize:14.0f];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //for dspa
        textField.borderStyle=UITextBorderStyleNone;
        textField.layer.cornerRadius= (MIN(CGRectGetWidth(textField.frame), CGRectGetHeight(textField.frame)))/4.f;
        textField.layer.masksToBounds=YES;
        textField.layer.borderColor = [[UIColor colorWithWhite:0.783 alpha:1.000] CGColor];
        textField.layer.borderWidth= 0.5f;
        textField.backgroundColor = [UIColor whiteColor];
        
        textField;
    });
    [self addSubview:_textField];
    
    _iconView = ({
        UIImage *image = iOS7SearchBarBundleImageNamed(@"LF_iOS7SearchBar_ICON");
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView;
    });
    _textField.leftView = _iconView;
    _textField.leftViewMode =  UITextFieldViewModeAlways;
    
    _cancelButton.hidden = YES;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0.733 green:0.732 blue:0.756 alpha:1.000];
}

#pragma mark - button action
-(void)cancelButtonTouched
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBarCancelButtonClicked:)])
    {
        [self.delegate lf_iOS7SearchBarCancelButtonClicked:self];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBarShouldBeginEditing:)])
    {
        return [self.delegate lf_iOS7SearchBarShouldBeginEditing:self];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBarTextDidBeginEditing:)])
    {
        [self.delegate lf_iOS7SearchBarTextDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBarShouldEndEditing:)])
    {
        return [self.delegate lf_iOS7SearchBarShouldEndEditing:self];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBarTextDidEndEditing:)])
    {
        [self.delegate lf_iOS7SearchBarTextDidEndEditing:self];
    }
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBar:textDidChange:)])
    {
        [self.delegate lf_iOS7SearchBar:self textDidChange:textField.text];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBar:shouldChangeTextInRange:replacementText:)])
    {
        return [self.delegate lf_iOS7SearchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBar:textDidChange:)])
    {
        [self.delegate lf_iOS7SearchBar:self textDidChange:@""];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(lf_iOS7SearchBarSearchButtonClicked:)])
    {
        [self.delegate lf_iOS7SearchBarSearchButtonClicked:self];
    }
    return YES;
}

#pragma mark - getter/setter

- (void)setShowsCancelButton:(BOOL)showsCancelButton
{
    [self setShowsCancelButton:showsCancelButton animated:NO];
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated
{
    if (_showsCancelButton != showsCancelButton) {
        _showsCancelButton = showsCancelButton;
        if (showsCancelButton) {
            [UIView animateWithDuration:(animated ? 0.25f : 0) animations:^{
                _cancelButton.hidden = NO;
                CGRect tempRect = _textField.frame;
                tempRect.size.width -= CGRectGetWidth(_cancelButton.frame);
                _textField.frame = tempRect;
            }];
        } else {
            [UIView animateWithDuration:(animated ? 0.25f : 0) animations:^{
                _cancelButton.hidden = YES;
                CGRect tempRect = _textField.frame;
                tempRect.size.width = self.frame.size.width-iOS7SearchBarViewMargin*2;
                _textField.frame = tempRect;
            }];
        }
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    self.textField.backgroundColor = tintColor;
}
- (UIColor *)tintColor
{
    return self.textField.backgroundColor;
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    if (iconImage) {
        [self.iconView setImage:iconImage];
    } else {
        [self.iconView setImage:iOS7SearchBarBundleImageNamed(@"LF_iOS7SearchBar_ICON")];
    }
}

-(void)setText:(NSString *)text{
    _textField.text= text?:@"";
}
- (NSString *)text
{
    return _textField.text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _textField.attributedText = attributedText;
}
- (NSAttributedString *)attributedText
{
    return _textField.attributedText;
}

-(void)setTextColor:(UIColor *)textColor{
    [_textField setTextColor:textColor];
}
- (UIColor *)textColor
{
    return _textField.textColor;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    
    NSAttributedString *attributedPlaceholder = nil;
    if (placeholder) {
        attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.5f alpha:.8f]}];
    }
    _textField.attributedPlaceholder = attributedPlaceholder;
}

-(void)setInputAccessoryView:(UIView *)inputAccessoryView{
    _inputAccessoryView = inputAccessoryView;
    _textField.inputAccessoryView = inputAccessoryView;
}

#pragma mark - overwrite
- (BOOL)canBecomeFirstResponder
{
    return [self.textField canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder
{
    return [self.textField canResignFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.textField resignFirstResponder];
}

- (BOOL)isFirstResponder
{
    return [self.textField isFirstResponder];
}

@end
