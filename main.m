#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// هذه الأداة تجعل الدالة تعمل تلقائياً فور تحميل ملف الـ dylib
__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // الحصول على النافذة الرئيسية للتطبيق
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

        // الوصول إلى أعلى Controller معروض حالياً
        while (rootViewController.presentedViewController) {
            rootViewController = rootViewController.presentedViewController;
        }

        // إنشاء نافذة التنبيه الترحيبية
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"أهلاً بك! 👋"
                                                                       message:@"تم تفعيل الملف بنجاح داخل التطبيق."
                                                                preferredStyle:UIAlertControllerStyleAlert];

        // إضافة زر إغلاق النافذة
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"موافق"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

        [alert addAction:okAction];

        // إظهار النافذة للمستخدم
        if (rootViewController) {
            [rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
