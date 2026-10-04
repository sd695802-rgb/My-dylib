#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static UIWindow *welcomeOverlayWindow = nil;

@interface StrongWelcomeViewController : UIViewController
@end

@implementation StrongWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // خلفية مطابقة لطابع الصورة (داكنة وعميقة)
    self.view.backgroundColor = [UIColor colorWithRed:0.05 green:0.07 blue:0.12 alpha:1.0];
    
    // إعداد الشعار أو العنوان العلوي
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"IPA STRONG ⚡️";
    titleLabel.font = [UIFont boldSystemFontOfSize:28];
    titleLabel.textColor = [UIColor colorWithRed:0.20 green:0.60 blue:1.00 alpha:1.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = @"أهلاً بك يا boss man\nاستمتع بأفضل التعديلات الحصرية";
    subtitleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subtitleLabel];
    
    // أزرار الواجهة
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 14;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackView];
    
    // 1. زر قناة التليجرام
    UIButton *telegramButton = [self createButtonWithTitle:@"قناة التيليجرام ⚡️" 
                                           backgroundColor:[UIColor colorWithRed:0.10 green:0.15 blue:0.25 alpha:1.0] 
                                                 textColor:[UIColor whiteColor] 
                                               borderColor:[UIColor colorWithRed:0.20 green:0.60 blue:1.00 alpha:1.0]];
    [telegramButton addTarget:self action:@selector(openTelegramChannel) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:telegramButton];
    
    // 2. زر صاحب القناة
    UIButton *ownerButton = [self createButtonWithTitle:@"صاحب القناة 👤" 
                                        backgroundColor:[UIColor colorWithRed:0.10 green:0.15 blue:0.25 alpha:1.0] 
                                              textColor:[UIColor whiteColor] 
                                            borderColor:[UIColor colorWithRed:0.20 green:0.60 blue:1.00 alpha:1.0]];
    [ownerButton addTarget:self action:@selector(openOwnerProfile) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:ownerButton];
    
    // 3. زر Ok لإخفاء الواجهة
    UIButton *okButton = [self createButtonWithTitle:@"OK 🚀" 
                                     backgroundColor:[UIColor colorWithRed:0.20 green:0.60 blue:1.00 alpha:1.0] 
                                           textColor:[UIColor blackColor] 
                                         borderColor:nil];
    [okButton addTarget:self action:@selector(dismissWelcomeScreen) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:okButton];
    
    // تثبيت القيود (Constraints) لتغطية كامل الشاشة وثبات تام
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:80],
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:15],
        [subtitleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30],
        
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-50],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:35],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-35],
        [okButton.heightAnchor constraintEqualToConstant:52]
    ]];
}

- (UIButton *)createButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)bgColor textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    button.backgroundColor = bgColor;
    button.layer.cornerRadius = 14;
    if (borderColor) {
        button.layer.borderColor = borderColor.CGColor;
        button.layer.borderWidth = 1.5;
    }
    return button;
}

- - (void)openTelegramChannel {
    NSURL *url = [NSURL URLWithString:@"https://t.me/ipastrong"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)openOwnerProfile {
    NSURL *url = [NSURL URLWithString:@"https://t.me/yk5y5"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)dismissWelcomeScreen {
    [UIView animateWithDuration:0.3 animations:^{
        welcomeOverlayWindow.alpha = 0.0;
    } completion:^(BOOL finished) {
        welcomeOverlayWindow.hidden = YES;
        welcomeOverlayWindow = nil;
    }];
}

@end

static void showWelcomeOverlayWindow() {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (welcomeOverlayWindow) return;
        
        UIWindowScene *activeScene = nil;
        if (@available(iOS 13.0, *)) {
            for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                    activeScene = (UIWindowScene *)scene;
                    break;
                }
            }
        }
        
        if (@available(iOS 13.0, *)) {
            if (activeScene) {
                welcomeOverlayWindow = [[UIWindow alloc] initWithWindowScene:activeScene];
            } else {
                welcomeOverlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            }
        } else {
            welcomeOverlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        
        welcomeOverlayWindow.windowLevel = UIWindowLevelAlert + 1;
        welcomeOverlayWindow.rootViewController = [[StrongWelcomeViewController alloc] init];
        welcomeOverlayWindow.backgroundColor = [UIColor clearColor];
        [welcomeOverlayWindow makeKeyAndVisible];
    });
}

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        showWelcomeOverlayWindow();
    });
}
