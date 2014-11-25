//
//  ViewController.m
//  DocumentPickerSample
//
//  Created by tud on 2014/07/26.
//  Copyright (c) 2014年 D2B Solution. All rights reserved.
//
// Notes:
// 1. In Xcode, please set up below:
//   (1) Capability of DocumentPickerSample : iCloud = ON (check iCloud Document), App Groups = ON
//   (2) Capability of DocumentProvider : App Groups = ON
//   (3) Capability of DocumentProviderFileProvider : App Groups = ON
//   and Fix Issues.
//
// 2. Check App Group IDs are same, and set App Group ID in AppGroupID.h
// 3. Check DocumentProviderFileProvider's Info.plist : NSExtension -> NSExtensionFileProviderDocumentGroup = App Group ID

#import "ViewController.h"
#import "AppGroupID.h"

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // If you want to provide documents to other apps, you should copy your documents under "App Group Folder/File Provider Storage".
    NSArray *documents = @[@"test.txt", @"test.html"];
    NSString *storagePath = [self storagePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *document in documents) {
        NSString *srcPath = [[NSBundle mainBundle] pathForResource:document ofType:nil];
        NSString *dstPath = [storagePath stringByAppendingPathComponent:document];
        [fileManager copyItemAtPath:srcPath toPath:dstPath error:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)storagePath {
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:APP_GROUP_ID];
    NSString *groupPath = [groupURL path];
    NSString *storagePath = [groupPath stringByAppendingPathComponent:@"File Provider Storage"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:storagePath]) {
        [fileManager createDirectoryAtPath:storagePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return storagePath;
}

// Open Document Picker with document types
// UTI : https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html
- (IBAction)displayDocumentPickerForHTML:(id)sender {
    NSArray *UTIs = @[@"public.html"];
    [self displayDocumentPicker:UTIs];
}
- (IBAction)displayDocumentPickerForText:(id)sender {
    NSArray *UTIs = @[@"public.text"];
    [self displayDocumentPicker:UTIs];
}
- (void)displayDocumentPicker:(NSArray *)UTIs {
    UIDocumentMenuViewController *importMenu = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:UTIs inMode:UIDocumentPickerModeImport];
    importMenu.delegate = self;
    [self presentViewController:importMenu animated:YES completion:nil];
}

#pragma mark - UIDocumentMenuDelegate
-(void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker
{
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    self.nameOfFile.text = [url lastPathComponent];
    self.contentOfFile.text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.contentOfURL loadRequest:request];
}
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

@end
