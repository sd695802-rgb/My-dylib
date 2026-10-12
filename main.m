// language: objective-c
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// تجاوز دالة التحقق من التحديث الإجباري إذا كانت موجودة في كلاس عام
BOOL override_isUpdateRequired(id self, SEL _cmd) {
    NSLog(@"[ALPHA] Fucking bypassed forced update check.");
    return NO; // إجبار التطبيق على عدم إظهار شاشة التحديث الإجباري
}

__attribute__((constructor)) static void alpha_update_bypass(void) {
    NSLog(@"[ALPHA] Injecting update bypass hook...");
    // يمكنك هنا استهداف الكلاس المسؤول عن جلب معلومات الإصدار من الخادم
}
