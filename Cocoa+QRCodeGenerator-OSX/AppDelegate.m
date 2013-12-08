
#import "AppDelegate.h"
#import "Cocoa+QRCodeGenerator.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.imageView updateSettingsToShowQRCodeImage];
    
    self.imageView.image = [NSImage QRCodeImageWithMessageString:@"Hello, I am Macintosh."
                                                        encoding:NSUTF8StringEncoding];
}

@end
