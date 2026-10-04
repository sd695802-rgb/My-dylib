#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomWelcomeViewController : UIViewController
@end

@implementation CustomWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // خلفية الشاشة داكنة بأسلوب Fox Theme
    self.view.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.0];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // 1. أيقونة الثعلب البارزة
    UILabel *foxLabel = [[UILabel alloc] init];
    foxLabel.text = @"🦊";
    foxLabel.font = [UIFont systemFontOfSize:80];
    foxLabel.textAlignment = NSTextAlignmentCenter;
    foxLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:foxLabel];
    
    // 2. العنوان الرئيسي FOX PLUS
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"FOX PLUS";
    titleLabel.font = [UIFont boldSystemFontOfSize:32];
    titleLabel.textColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]; // لون برتقالي الثعلب
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    // 3. النص الفرعي
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = @"أهلاً وسهلاً👋\nنتمنى ان ينال اعجابك التطبيق😍 ولاتنسى FOX الافضل";
    subtitleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subtitleLabel];
    
    // StackView لتنظيم الأزرار الـ 4 رأسياً
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 12;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackView];
    
    // الزر 1: دخول التطبيق
    UIButton *enterButton = [self createButtonWithTitle:@"دخول التطبيق 🚀" 
                                        backgroundColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0] 
                                              textColor:[UIColor blackColor] 
                                            borderColor:nil];
    [enterButton addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:enterButton];
    
    // الزر 2: قناة التيلجرام
    UIButton *telegramButton = [self createButtonWithTitle:@"قناة التيلجرام 🦊" 
                                           backgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.0] 
                                                 textColor:[UIColor whiteColor] 
                                               borderColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
    [telegramButton addTarget:self action:@selector(openTelegram) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:telegramButton];
    
    // الزر 3: صاحب القناة
    UIButton *ownerButton = [self createButtonWithTitle:@"صاحب القناة 🦊" 
                                        backgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.0] 
                                              textColor:[UIColor whiteColor] 
                                            borderColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
    [ownerButton addTarget:self action:@selector(openOwner) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:ownerButton];

    // الزر 4: سيرفر الديسكورد
    UIButton *discordButton = [self createButtonWithTitle:@"سيرفر الديسكورد🦊" 
                                         backgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.0] 
                                               textColor:[UIColor whiteColor] 
                                             borderColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
    [discordButton addTarget:self action:@selector(openDiscord) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:discordButton];
    
    // القيود والترتيب الشكلي (Constraints)
    [NSLayoutConstraint activateConstraints:@[
        [foxLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:50],
        [foxLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
        [titleLabel.topAnchor constraintEqualToAnchor:foxLabel.bottomAnchor constant:10],
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:15],
        [subtitleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-30],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:25],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-25],
        [enterButton.heightAnchor constraintEqualToConstant:50]
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

- (void)closeVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openTelegram {
    NSURL *url = [NSURL URLWithString:@"https://t.me/ipa_fox"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)openOwner {
    NSURL *url = [NSURL URLWithString:@"https://t.me/ipa1fox"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)openDiscord {
    NSURL *url = [NSURL URLWithString:@"https://discord.gg/xBdnVWk8r"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = nil;
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window.isKeyWindow) {
                keyWindow = window;
                break;
            }
        }
        if (!keyWindow && [UIApplication sharedApplication].windows.count > 0) {
            keyWindow = [UIApplication sharedApplication].windows[0];
        }

        UIViewController *rootViewController = keyWindow.rootViewController;
        while (rootViewController.presentedViewController) {
            rootViewController = rootViewController.presentedViewController;
        }

        CustomWelcomeViewController *welcomeVC = [[CustomWelcomeViewController alloc] init];
        if (rootViewController) {
            [rootViewController presentViewController:welcomeVC animated:YES completion:nil];
        }
    });
}
