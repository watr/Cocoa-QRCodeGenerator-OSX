
#import "Cocoa+QRCodeGenerator.h"

@implementation CIFilter (QRCodeGenerator)

+ (CIFilter *)QRCodeGenerator
{
    return [self QRCodeGeneratorWithCorrectionLevel:QRCodeGeneratorCorrectionLevelDefault];
}

+ (CIFilter *)QRCodeGeneratorWithCorrectionLevel:(QRCodeGeneratorCorrectionLevel const)correctionLevel
{
    CIFilter *qrCodeGenerator = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrCodeGenerator setDefaults];
    
    BOOL isCorrectionLevelDefault = (correctionLevel == QRCodeGeneratorCorrectionLevelDefault);
    if (! isCorrectionLevelDefault) {
        NSString *correctionLevelString = nil;
        switch (correctionLevel) {
            case QRCodeGeneratorCorrectionLevelL:
                correctionLevelString = @"L";
                break;
            case QRCodeGeneratorCorrectionLevelM:
                correctionLevelString = @"M";
                break;
            case QRCodeGeneratorCorrectionLevelQ:
                correctionLevelString = @"Q";
                break;
            case QRCodeGeneratorCorrectionLevelH:
                correctionLevelString = @"H";
                break;
            default:
                break;
        }
        NSAssert((correctionLevelString != nil), @"correction level string must not be nil");
        
        [qrCodeGenerator setValue:correctionLevelString
                           forKey:@"inputCorrectionLevel"];
    }
    return qrCodeGenerator;
}

- (NSImage *)QRCodeImageWithMessageString:(NSString *)messageString
                                 encoding:(NSStringEncoding)stringEncoding
{
    [self setValue:[messageString dataUsingEncoding:stringEncoding]
            forKey:@"inputMessage"];
    CIImage *ciImage = [self valueForKey:@"outputImage"];
    NSImage *image = [[NSImage alloc] init];
    [image addRepresentation:[NSCIImageRep imageRepWithCIImage:ciImage]];
    return image;
}

@end

@implementation NSImage (QRCodeGenerator)

+ (NSImage *)QRCodeImageWithMessageString:(NSString *)messageString
                                 encoding:(NSStringEncoding)stringEncoding
{
    return [self QRCodeImageWithMessageString:messageString
                                     encoding:stringEncoding
                              correctionLevel:QRCodeGeneratorCorrectionLevelDefault];
}


+ (NSImage *)QRCodeImageWithMessageString:(NSString *)messageString
                                 encoding:(NSStringEncoding)stringEncoding
                          correctionLevel:(QRCodeGeneratorCorrectionLevel)correctionLevel
{
    CIFilter *qrCodeGenerator = [CIFilter QRCodeGeneratorWithCorrectionLevel:correctionLevel];
    NSImage *qrCodeImage = [qrCodeGenerator QRCodeImageWithMessageString:messageString
                                                                encoding:stringEncoding];
    return qrCodeImage;
}

@end

@implementation NSImageView (QRCodeGenerator)

- (void)updateSettingsToShowQRCodeImage
{
    self.wantsLayer = YES;
    NSImageCell *imageCell = [self cell];
    [imageCell setImageFrameStyle:NSImageFrameNone];
    self.layer.magnificationFilter = kCAFilterNearest;
}

@end

@implementation CodePreviewImageView

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self updateSettingsToShowQRCodeImage];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateSettingsToShowQRCodeImage];
    }
    return self;
}

@end
