//
//  JYNaviView.h
//  JYDC2
//
//  Created by DaveYou on 2019/9/24.
//  Copyright © 2019 Ce Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYNaviView : UIView
//背景
@property (nonatomic, copy) NSString *jy_naviImageName; //titleView
@property (nonatomic, assign) BOOL jy_hideBottomGrayLine;
//左边
@property (nonatomic, copy) void (^leftBtnClickedBlock)(void); //left
@property (nonatomic, assign) BOOL jy_hiddenBackBtn;

@property (nonatomic, strong) NSArray<NSString *> *leftBtns; //图片名字数组
@property (nonatomic, copy) void (^leftBtnsClickedBlock)(UIButton *leftBtns); //lefts需要

//中间
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *titleImageString;
//右边
@property (nonatomic, copy) NSString *rightString; //右边按钮的文字
@property (nonatomic, copy) NSString *rightImage; //右边的图片按钮

@property (nonatomic, copy) void (^rightBtnClickedBlock)(void); //right
@property (nonatomic, copy) void (^rightBtnClickedBlockWithPosition)(UIButton *rightBtn); //right
@property (nonatomic, copy) void (^rightBtnsClickedBlock)(UIButton *rightbtns); //rights需要

@property (nonatomic, strong) NSArray<NSString *> *rightBtns; //图片名字数组

@property (nonatomic, assign) BOOL rightBtnEnabled; //只控制字符串按钮能否点击

@end

NS_ASSUME_NONNULL_END
