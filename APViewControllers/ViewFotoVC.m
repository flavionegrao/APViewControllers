//
//  ViewFotoVC.m
//  donaRaposa
//
//  Created by Flavio Negrão Torres on 05/02/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import "ViewFotoVC.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "APUtil.h"

@interface ViewFotoVC()
@property (nonatomic, weak) UIImageView* imageView;
@property (nonatomic, weak) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) UIActivityViewController* activityViewController;

@end


@implementation ViewFotoVC

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem* exportButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(didTouchActionButton:)];
    self.navigationItem.rightBarButtonItem = exportButton;
    
}


- (void) setImage:(UIImage *)image {
    _image = image;
    
    if (!self.imageView) {
        UIImageView* imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
       
        if (self.activityIndicator) {
            [self.view insertSubview:imageView belowSubview:self.activityIndicator];
        } else {
            [self.view addSubview:imageView];
        }
        [self.view addConstraints:[NSLayoutConstraint constraintsToMatchFramesFromView:self.view toView:imageView]];
        self.imageView = imageView;
    }
    
    self.imageView.image = image;
}


- (void) setLoading:(BOOL)loading {
    _loading = loading;
    if (!self.activityIndicator) {
        UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.view addSubview:activityView];
        [activityView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraints:[NSLayoutConstraint constraintsToMatchFramesFromView:self.view toView:activityView]];
        
        self.activityIndicator = activityView;
    }
    
    if (loading) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

- (void)didTouchActionButton:(UIBarButtonItem*) sender {
    NSData* jpegRepresentation = UIImageJPEGRepresentation(self.image, 1);
    self.activityViewController = [[UIActivityViewController alloc]
                                   initWithActivityItems:@[jpegRepresentation] applicationActivities:nil];
    
    if ([self.activityViewController respondsToSelector:@selector(popoverPresentationController)])
    {
        UIPopoverPresentationController *presentationController = [self.activityViewController
                                                                   popoverPresentationController];
        presentationController.sourceView = (UIView*) sender;
    }
    
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

@end
