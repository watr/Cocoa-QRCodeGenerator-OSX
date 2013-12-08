
#import <Cocoa/Cocoa.h>
@import QuartzCore;

typedef NS_ENUM(NSInteger, QRCodeGeneratorCorrectionLevel)
{
    QRCodeGeneratorCorrectionLevelDefault = 0,
    QRCodeGeneratorCorrectionLevelL,// 7%
    QRCodeGeneratorCorrectionLevelM,// 15%
    QRCodeGeneratorCorrectionLevelQ,// 25%
    QRCodeGeneratorCorrectionLevelH,// 30%
};

@interface CIFilter (QRCodeGenerator)

+ (CIFilter *)QRCodeGenerator;
+ (CIFilter *)QRCodeGeneratorWithCorrectionLevel:(QRCodeGeneratorCorrectionLevel)correctionLevel;

- (NSImage *)QRCodeImageWithMessageString:(NSString *)messageString
                                 encoding:(NSStringEncoding)stringEncoding;

@end

@interface NSImage (QRCodeGenerator)

+ (NSImage *)QRCodeImageWithMessageString:(NSString *)messageString
                                 encoding:(NSStringEncoding)stringEncoding;

+ (NSImage *)QRCodeImageWithMessageString:(NSString *)messageString
                                 encoding:(NSStringEncoding)stringEncoding
                          correctionLevel:(QRCodeGeneratorCorrectionLevel)correctionLevel;

@end

@interface NSImageView (QRCodeGenerator)

- (void)updateSettingsToShowQRCodeImage;

@end

@interface CodePreviewImageView : NSImageView

@end