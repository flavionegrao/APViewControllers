//
//  ViewFotoVC.h
//  donaRaposa
//
//  Created by Flavio Negrão Torres on 05/02/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFotoVC : UIViewController

@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) BOOL errorLoading;
@property (nonatomic, strong) UIImage* image;

@end
