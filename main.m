#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // الحصول على النافذة النشطة في التطبيق
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

        // إنشاء نافذة التنبيه الترحيبية المعدلة
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🦊\nأهلاً وسهلاً👋"
                                                                       message:@"نتمنى ان ينال اعجابك التطبيق😍 ولاتنسى FOX الافضل"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        // الزر الأول: قناة التيلجرام
        UIAlertAction *telegramChannelAction = [UIAlertAction actionWithTitle:@"قناة التيلجرام🦊"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:@"https://t.me/ipa_fox"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }];

        // الزر الثاني: صاحب القناة
        UIAlertAction *ownerAction = [UIAlertAction actionWithTitle:@"صاحب القناة🦊"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:@"https://t.me/ipa1fox"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }];

        // الزر الثالث: ok🦊 لإغلاق النافذة
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok🦊"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

        // إضافة الأزرار إلى النافذة
        [alert addAction:telegramChannelAction];
        [alert addAction:ownerAction];
        [alert addAction:okAction];

        // عرض النافذة للمستخدم
        if (rootViewController) {
            [rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
