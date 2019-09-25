### iOS 自定义导航--参照系统导航

#####不以图片开头的文章都不是好文章
![与世无争.JPG](https://upload-images.jianshu.io/upload_images/3115781-618d71eef175fa76.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 任何时候，都不要迷失自己。有一双清澈的眼睛，可以沉默，但不要迷离方向；有一颗干净的心灵，可以容纳，但不能承载太多；有一个优雅的姿态，可以美丽，但不要沉溺世事。其实，一切源于自然，源于清净，源于灵魂的修行。

##### 现状描述：
一般项目中大概都是一个tabbar管理几个带导航的控制器，可其中有几个控制器没有导航。这时候就需要进入该控制器的时候隐藏导航，离开的时候显示导航。

大概流程就是设置代理 ```self.navigationController.delegate = self;``` 
遵守协议 ```UINavigationControllerDelegate```
```
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
```
并在```viewWillAppear```中隐藏
```
[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
```
在```viewWillDisappear```中显示导航，设置回导航，例如：
```
UIImage *image= [self createImageWithColor:kMainColor];
[self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//其中：createImageWithColor:是根据传递主题颜色生成图片
/*
- (UIImage *)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}*/
```

##### 发现Bug：
以上这种写法，一般也不会有啥问题。除非遇到跳转的界面也是隐藏导航的，这时候有概率出现该显示导航的却消失了（复现过程：滑动来回调用```viewWillAppear```和```viewWillDisappear```）

![脑袋瓜子嗡嗡的.jpg](https://upload-images.jianshu.io/upload_images/3115781-b41934a43d02b916.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 构思解决方案：
所以干脆让导航一直都是隐藏状态，显示的时候添加自定义的导航View，当然功能都参照着系统的功能
##### 实施大致过程关键Code：
* 初始化 懒加载控件

```
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
```

* 返回按钮

```
/// 返回按钮 默认添加 参照leftBarButtonItem
- (JYDisableHightlightBtn *)backBtn {
    if (!_backBtn) {
        _backBtn = [JYDisableHightlightBtn buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:_backBtn];
        //Masonry约束
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.width.equalTo(80);
            make.height.equalTo(44);
            make.bottom.equalTo(0);
            
        }];
        _backBtn.backgroundColor = [UIColor blueColor];
        [_backBtn setImage:[UIImage imageNamed:@"common_back"] forState:(UIControlStateNormal)];
        //按钮图片居左
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //点击响应RAC传递信号
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
```
* 中间的标题

```
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
```
* 在头文件中公开属性，方便设置导航按钮等，如：

```
//背景
@property (nonatomic, copy) NSString *jy_naviImageName; //titleView
@property (nonatomic, assign) BOOL jy_hideBottomGrayLine;
//左边
@property (nonatomic, copy) void (^leftBtnClickedBlock)(void); //left
@property (nonatomic, assign) BOOL jy_hiddenBackBtn;

@property (nonatomic, copy) void (^leftBtnsClickedBlock)(UIButton *leftBtns); //lefts需要

//中间
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *titleImageString;
```

* 当然还要仿照系统```UINavigationItem```还有```titleView```、```rightBarButtonItem```、```rightBarButtonItems```以及是否隐藏返回按钮，右侧是否可点击等等
***
**最后在基类中隐藏导航并添加自定义导航视图，后续创建的控制器需要继承自该基类**

```
/*
 设置父类的导航代理，隐藏导航，并添加自定义导航
 */
#import "JYBaseViewController.h"

@interface JYBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation JYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.baseNaviView = [[JYNaviView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, k_Height_NavBar)];
    [self.view addSubview:self.baseNaviView];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - dealloc
- (void)dealloc{
    NSLog(@"%@--dealloc", [self className]);
}
```
##### 整合到项目中实际遇到的问题：
 1. ```UISearchController```的```searchBar```点击的时候会跑到顶部
解决办法：个人建议直接使用```UISearchBar```设置样式后调用原来的逻辑。
2. 同一个界面直接显示和配合WMPageController使用。
解决办法：在其中任意一个推出界面时增加type属性（或成员变量），根据属性来判断是否隐藏导航视图。如：

```
//初始化赋值type，枚举最好，此处简写
- (instancetype)initWithWMPage:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.baseNaviView.hidden = YES;
    }else {
        self.baseNaviView.titleString = @"微视频";
        self.baseNaviView.hidden = NO;
    }
    //...

    CGFloat startY = self.baseNaviView.hidden ? 0 : CGRectGetMaxY(self.baseNaviView.frame);
    CGFloat videoH = self.baseNaviView.hidden ? ScreenHeight - self.tabBarController.tabBar.height- k_Height_NavBar - 41 : ScreenHeight- k_Height_NavBar- k_Height_Bottom;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, startY, ScreenWidth, videoH) style:(UITableViewStylePlain)]; //只有导航没有tabbar，刘海屏系列减34，非减0
}
```

3. 有的界面不显示自定义的导航视图
解决办法：查看视图层级，如果被遮挡那就带到最前方```[self.view bringSubviewToFront:self.baseNaviView];```

4. 子视图被遮挡
解决办法：如果是代码创建的视图，那么创建的时候CGRectMake的Y参数使用```CGRectGetMaxY(self.baseNaviView.frame)```，高度看情况是否需要再减掉。如果是Xib拖的控件，那么建议top约束到superView而不是Safe Area，然后在控制器中```self.safeToTop.constant = k_Height_NavBar;```
5. 执行Block会警告：Capturing 'self' strongly in this block is likely to lead to a retain cycle
解决办法：建议导入RAC框架或YYCategories，创建弱引用self

```
    @weakify(self)
    self.baseNaviView.leftBtnClickedBlock = ^{
        @strongify(self)
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
```

...
* BTW：[Demo](https://github.com/daveyqyou/JYNaviView)

![烦恼都忘掉.JPG](https://upload-images.jianshu.io/upload_images/3115781-1e1dc2943928b782.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



