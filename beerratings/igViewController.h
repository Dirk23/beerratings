//
//  igViewController.h
//  ScanBarCodes
//
//  Created by Torrey Betts on 10/10/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol igViewControllerDelegate;

@interface igViewController : UIViewController
@property (weak) id<igViewControllerDelegate> delegate;
@end

@protocol igViewControllerDelegate <NSObject>
-(void)cameraDidFinish:(igViewController *)inController data:(NSString*)code;
@end