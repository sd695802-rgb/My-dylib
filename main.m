#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FoxMenuController : UIViewController
@end

@implementation FoxMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:0.95];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, self.view.bounds.size.width - 40, 40)];
    titleLabel.text = @"FOX CONFIG 🦊";
    titleLabel.textColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIButton *activateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    activateButton.frame = CGRectMake(40, 120, self.view.bounds.size.width - 80, 50);
    [activateButton setTitle:@"تفعيل 🦊" forState:UIControlStateNormal];
    [activateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    activateButton.backgroundColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
    activateButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    activateButton.layer.cornerRadius = 14;
    [activateButton addTarget:self action:@selector(activateTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activateButton];
}

- (void)activateTapped {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FOX IPA"
                                                                   message:@"تم تنفيذ الأمر بنجاح يا boss man!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"موافق" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
