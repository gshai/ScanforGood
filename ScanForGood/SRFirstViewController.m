//
//  SRFirstViewController.m
//  ScanForGood
//
//  Created by Gilad Shai on 3/3/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import "SRFirstViewController.h"
#import <ZXingObjC/ZXingObjC.h>
#import "SRDonation.h"



@interface SRFirstViewController ()
- (void)decodeImage:(UIImage *)scanedImage;
- (SRDonation *)parseQRResults:(ZXResult *)result;
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
    [self decodeImage:[UIImage imageNamed:@"spottedRhino.png"]];
}

#pragma mark - Processing scaned image

- (void)decodeImage:(UIImage *)scanedImage {
    
    // Given a CGImage in which we are looking for barcodes
    CGImageRef imageToDecode = scanedImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError* error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        SRDonation *parsedResults = [self parseQRResults:result];
        NSLog(@"parsed results: %@", parsedResults);
        
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
        NSLog(@"Error");
    }
}

- (SRDonation *)parseQRResults:(ZXResult *)result {
    /*
     Testing data:
     
     {
        "url": "http://www.spottedrhino.com",
        "account_id": "23-11223344b",
        "options": [
            2,
            3,
            5
        ]
     }    
     */
    
    // The coded result as a string. The raw data can be accessed with
    // result.rawBytes and result.length.
    NSError *jsonParsingError = nil;
    NSData *data = [result.text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonParsingError];

    if (!response) {
        return nil;
    }
    
    // Build are Donation obj
    SRDonation *donation = [[SRDonation alloc] initWithDictionary: response];
    
    // The barcode format, such as a QR code or UPC-A
    ZXBarcodeFormat format = result.barcodeFormat;
    NSLog(@"format: %d",format);
    
    return (SRDonation *)donation;
}
@end
