//
//  ViewController.h
//  DocumentPickerSample
//
//  Created by tud on 2014/07/26.
//  Copyright (c) 2014年 D2B Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIDocumentMenuDelegate,UIDocumentPickerDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameOfFile;
@property (weak, nonatomic) IBOutlet UITextView *contentOfFile;
@property (weak, nonatomic) IBOutlet UIWebView *contentOfURL;
- (IBAction)displayDocumentPickerForText:(id)sender;
- (IBAction)displayDocumentPickerForHTML:(id)sender;

@end

