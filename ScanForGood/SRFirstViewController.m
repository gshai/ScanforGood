//
//  SRFirstViewController.m
//  ScanForGood
//
//  Created by Gilad Shai on 3/3/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import "SRFirstViewController.h"
#import <ZXingObjC/ZXingObjC.h>



@interface SRFirstViewController ()

@end

@implementation SRFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mainAction:(id)sender {
    // Given a CGImage in which we are looking for barcodes
    CGImageRef imageToDecode = [UIImage imageNamed:@"spottedRhino.png"].CGImage;
    
    ZXLuminanceSource* source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap* bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError* error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints* hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader* reader = [ZXMultiFormatReader reader];
    ZXResult* result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString* contents = result.text;
        NSLog(@"contents: %@ \nMetadata: %@", contents, result.resultMetadata);
        
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;
        NSLog(@"format: %d",format);
        
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
        NSLog(@"Error");
    }
}
@end
