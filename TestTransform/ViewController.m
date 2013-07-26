//
//  ViewController.m
//  TestTransform
//
//  Created by Abdul Rehman on 26/07/2013.
//  Copyright (c) 2013 InnovationNext. All rights reserved.
//

#import "ViewController.h"

#import <CoreGraphics/CoreGraphics.h>
#import "TouchImageView.h"
#define degreesToRadians(x) (M_PI * x / 180.0)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image=[UIImage imageNamed:@"cena-1.png"];
    CGRect imageFrame=CGRectMake(0, 0, image.size.width, image.size.height);
    self.imgOverlay=[[TouchImageView alloc] initWithFrame:imageFrame];
    self.imgOverlay.image=image;
    self.imgOverlay.center=CGPointMake(image.size.width*0.5, image.size.height*0.5);
    [self.view addSubview:self.imgOverlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [_imgOverlay release];
    self.imgOverlay=nil;
    [super dealloc];
}
- (IBAction)actionExport:(id)sender {
    
    NSLog(@"self.imgOverlay.image.scale: %f", self.imgOverlay.image.scale);
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    //    CGContextScaleCTM(context, 1, -1);
//    CGContextTranslateCTM(context, self.imgOverlay.image.size.width*0.5, self.imgOverlay.image.size.height*0.5);
    CGContextConcatCTM(context, self.imgOverlay.transform);

    
    CGRect modifiedRect=CGRectApplyAffineTransform(self.imgOverlay.frame, CGAffineTransformInvert(self.imgOverlay.transform));
    //    [imageView.image drawInRect:modifiedRect];
    [self.imgOverlay.image drawAtPoint:modifiedRect.origin];
    
    UIGraphicsPopContext();
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *imagePath=[NSTemporaryDirectory() stringByAppendingPathComponent:@"test.png"];
    NSData *imageData=UIImagePNGRepresentation(outputImage);
    [imageData writeToFile:imagePath atomically:YES];
    
    NSLog(@"putputImage path: %@", imagePath);

}
@end
