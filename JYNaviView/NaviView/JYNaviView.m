//
//  JYNaviView.m
//  JYDC2
//
//  Created by DaveYou on 2019/9/24.
//  Copyright © 2019 Ce Feng. All rights reserved.
//

#import "JYNaviView.h"


@interface JYNaviView ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *bottomGrayLine;
@property (nonatomic, strong) JYDisableHightlightBtn *backBtn; //禁止高亮的返回按钮

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;

//@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) JYDisableHightlightBtn *rightStringBtn;
@property (nonatomic, strong) JYDisableHightlightBtn *rightImageBtn;
@end

@implementation JYNaviView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor redColor];///kMainColor;
    //根据公开传递的参数按需增加
    
    //默认加载灰色的线
    [self bottomGrayLine];
    [self backBtn];
}

#pragma mark - 懒加载控件
/// 背景图
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
        [self addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(ScreenWidth);
            make.height.equalTo(k_Height_NavBar);
            make.right.bottom.equalTo(0);
        }];
    }
    return _backgroundImageView;
}

/// 背景图片
- (void)setJy_naviImageName:(NSString *)jy_naviImageName {
    //导航条 九切片
    UIImage *imageNav = [UIImage imageNamed:jy_naviImageName];
    imageNav = [imageNav stretchableImageWithLeftCapWidth:imageNav.size.width*0.5 topCapHeight:imageNav.size.height * 0.5];
    [self.backgroundImageView setImage:imageNav];
}

/// 底部灰色的线 默认有
- (UIView *)bottomGrayLine {
    if (!_bottomGrayLine) {
        _bottomGrayLine = [[UIView alloc]init];
        _bottomGrayLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomGrayLine];
        [_bottomGrayLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
    }
    
    return _bottomGrayLine;
}

/// 默认不隐藏，传递YES隐藏底部灰色的线
- (void)setJy_hideBottomGrayLine:(BOOL)jy_hideBottomGrayLine {
    self.bottomGrayLine.hidden = jy_hideBottomGrayLine;
}


/// 返回按钮 默认添加 leftBarButtonItem
- (JYDisableHightlightBtn *)backBtn {
    if (!_backBtn) {
        _backBtn = [JYDisableHightlightBtn buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.width.equalTo(80);
            make.height.equalTo(44);
            make.bottom.equalTo(0);
            
        }];
        _backBtn.backgroundColor = [UIColor blueColor];
        [_backBtn setImage:[UIImage imageNamed:@"common_back"] forState:(UIControlStateNormal)];
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [[_backBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.leftBtnClickedBlock) { //使用block自定义返回或返回根视图
                self.leftBtnClickedBlock();
            }else {
                [self.viewController.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    return _backBtn;
}

/// 默认显示返回按钮 需要隐藏再隐藏
- (void)setJy_hiddenBackBtn:(BOOL)jy_hiddenBackBtn {
    self.backBtn.hidden = jy_hiddenBackBtn;
}

/// 需要左侧是两个以上的按钮 需要自定义 leftBarButtonItems
- (void)setLeftBtns:(NSArray<NSString *> *)leftBtns {
    self.backBtn.hidden = YES;
    NSInteger count = leftBtns.count;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *item = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10+i*21+5*i);
            make.width.equalTo(21);
            make.height.equalTo(21);
            make.bottom.equalTo(-10);
            
        }];
        [item setImage:[UIImage imageNamed:leftBtns[i]] forState:(UIControlStateNormal)];
        [[item rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.leftBtnsClickedBlock) {
                self.leftBtnsClickedBlock(x);
            }
        }];
    }
}


//中间的标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(-10);
        }];
        _titleLabel.backgroundColor = [UIColor blueColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    self.titleLabel.text = titleString;
}

//中间的图片
- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        [self addSubview:_titleImageView];
        [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(-2);
            make.height.equalTo(42);
        }];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _titleImageView;
}

- (void)setTitleImageString:(NSString *)titleImageString {
    self.titleImageView.image = [UIImage imageNamed:titleImageString];
    [self.titleImageView sizeToFit];
}


//右边的按钮
- (JYDisableHightlightBtn *)rightStringBtn {
    if (!_rightStringBtn) {
        _rightStringBtn = [JYDisableHightlightBtn buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:_rightStringBtn];
        [_rightStringBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.width.equalTo(80);
            make.bottom.equalTo(-10);
        }];
        _rightStringBtn.backgroundColor = [UIColor clearColor];
        _rightStringBtn.enabled = YES; //默认是可以用的
        _rightStringBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [[_rightStringBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"导航右边的按钮被点击了");
            if (self.rightBtnClickedBlock) {
                self.rightBtnClickedBlock();
            }
            if (self.rightBtnClickedBlockWithPosition) {
                self.rightBtnClickedBlockWithPosition(x);
            }
        }];
    }
    return _rightStringBtn;
}

- (void)setRightString:(NSString *)rightString {
    _rightString = rightString;
    if (rightString.length > 0) {
        [self.rightStringBtn setTitle:rightString forState:(UIControlStateNormal)];
    }
}
//右边的按钮 两个按钮就可以根据传递rightImage、rightString来分开赋值
- (JYDisableHightlightBtn *)rightImageBtn {
    if (!_rightImageBtn) {
        _rightImageBtn = [JYDisableHightlightBtn buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:_rightImageBtn];
        [_rightImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.width.equalTo(80);
            make.bottom.equalTo(-10);
        }];
        _rightImageBtn.backgroundColor = [UIColor clearColor];
        _rightImageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [[_rightImageBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"导航右边的按钮被点击了");
            if (self.rightBtnClickedBlock) {
                self.rightBtnClickedBlock();
            }
            if (self.rightBtnClickedBlockWithPosition) {
                self.rightBtnClickedBlockWithPosition(x);
            }
        }];
    }
    return _rightImageBtn;
}

- (void)setRightImage:(NSString *)rightImage {
    _rightImage = rightImage;
    if (rightImage) {
        [self.rightImageBtn setImage:[UIImage imageNamed:rightImage] forState:(UIControlStateNormal)];
    }
}

- (void)setRightBtnEnabled:(BOOL)rightBtnEnabled {
    _rightBtnEnabled = rightBtnEnabled;
    self.rightStringBtn.enabled = rightBtnEnabled;
}

/// 需要左侧是两个以上的按钮 需要自定义 leftBarButtonItems
- (void)setRightBtns:(NSArray<NSString *> *)rightBtns {
    NSInteger count = rightBtns.count;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *item = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10-i*21-5*i);
            make.width.equalTo(21);
            make.height.equalTo(21);
            make.bottom.equalTo(-10);
            
        }];
        [item setImage:[UIImage imageNamed:rightBtns[i]] forState:(UIControlStateNormal)];
        [[item rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.rightBtnsClickedBlock) {
                self.rightBtnsClickedBlock(x);
            }
        }];
    }
}
@end
