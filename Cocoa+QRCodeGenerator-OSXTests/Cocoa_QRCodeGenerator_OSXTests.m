
#import <XCTest/XCTest.h>
#import "Cocoa+QRCodeGenerator.h"

@interface Cocoa_QRCodeGenerator_OSXTests : XCTestCase

@end

@implementation Cocoa_QRCodeGenerator_OSXTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQRCodeGeneratorInitialization
{
    XCTAssertNotNil([CIFilter QRCodeGenerator], @"QRCodeGenerator existence");
}

@end
