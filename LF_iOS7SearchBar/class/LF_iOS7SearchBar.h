//
//  LF_iOS7SearchBar.h
//  LF_iOS7SearchBar
//
//  Created by LamTsanFeng on 2017/9/29.
//  Copyright © 2017年 LamTsanFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LF_iOS7SearchBarDelegate;

@interface LF_iOS7SearchBar : UIView <UITextInputTraits>

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;

@property(nullable,nonatomic,weak) id<LF_iOS7SearchBarDelegate> delegate;              // weak reference. default is nil
@property(nullable,nonatomic,copy)   NSString               *text;                  // current/starting search text
@property(nullable,nonatomic,copy)   NSAttributedString     *attributedText;
@property(nullable,nonatomic,strong) UIColor                *textColor;
@property(nullable,nonatomic,copy)   NSString               *placeholder;           // default is nil
@property(nonatomic)        BOOL                    showsCancelButton;     // default is NO
@property(nullable,nonatomic,copy)   NSString               *cancelTitle;
@property(nonatomic)        BOOL                    contentLeft; // The placeholder content displayed on the left. default is NO

- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated;

@property(null_resettable, nonatomic,strong) UIColor *tintColor;
@property(nullable, nonatomic,strong) UIColor *barTintColor;

/* Allow placement of an input accessory view to the keyboard for the search bar
 */
@property (nullable, nonatomic, readwrite, strong) UIView *inputAccessoryView;

@property(nullable, nonatomic,strong) UIImage *iconImage;

@end

@protocol LF_iOS7SearchBarDelegate <NSObject>

@optional

- (BOOL)lf_iOS7SearchBarShouldBeginEditing:(LF_iOS7SearchBar *)searchBar;                      // return NO to not become first responder
- (void)lf_iOS7SearchBarTextDidBeginEditing:(LF_iOS7SearchBar *)searchBar;                     // called when text starts editing
- (BOOL)lf_iOS7SearchBarShouldEndEditing:(LF_iOS7SearchBar *)searchBar;                        // return NO to not resign first responder
- (void)lf_iOS7SearchBarTextDidEndEditing:(LF_iOS7SearchBar *)searchBar;                       // called when text ends editing
- (void)lf_iOS7SearchBar:(LF_iOS7SearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)lf_iOS7SearchBar:(LF_iOS7SearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; // called before text changes

- (void)lf_iOS7SearchBarSearchButtonClicked:(LF_iOS7SearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)lf_iOS7SearchBarCancelButtonClicked:(LF_iOS7SearchBar *)searchBar;   // called when cancel button pressed

@end

NS_ASSUME_NONNULL_END
