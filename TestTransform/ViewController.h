//
//  ViewController.h
//  TestTransform
//
//  Created by Abdul Rehman on 26/07/2013.
//  Copyright (c) 2013 InnovationNext. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchImageView.h"
@interface ViewController : UIViewController

//@property (retain, nonatomic) IBOutlet UIImageView *imgOverlay;

@property (retain, nonatomic) IBOutlet TouchImageView *imgOverlay;

- (IBAction)actionExport:(id)sender;

@end
