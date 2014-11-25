//
//  FileProvider.m
//  DocumentProviderFileProvider
//
//  Created by tud on 2014/11/24.
//  Copyright (c) 2014年 D2B Solution. All rights reserved.
//

#import "FileProvider.h"
#import <UIKit/UIKit.h>

@interface FileProvider ()

@end

@implementation FileProvider

- (NSFileCoordinator *)fileCoordinator {
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    [fileCoordinator setPurposeIdentifier:[self providerIdentifier]];
    return fileCoordinator;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.fileCoordinator coordinateWritingItemAtURL:[self documentStorageURL] options:0 error:nil byAccessor:^(NSURL *newURL) {
            // ensure the documentStorageURL actually exists
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtURL:newURL withIntermediateDirectories:YES attributes:nil error:&error];
        }];
    }
    return self;
}

- (void)providePlaceholderAtURL:(NSURL *)url completionHandler:(void (^)(NSError *error))completionHandler {
    // Should call + writePlaceholderAtURL:withMetadata:error: with the placeholder URL, then call the completion handler with the error if applicable.
    NSString* fileName = [url lastPathComponent];
    
    NSURL *placeholderURL = [NSFileProviderExtension placeholderURLForURL:[self.documentStorageURL URLByAppendingPathComponent:fileName]];
    
    NSUInteger fileSize = 0;
    // TODO: get file size for file at <url> from model
    
    [self.fileCoordinator coordinateWritingItemAtURL:placeholderURL options:0 error:NULL byAccessor:^(NSURL *newURL) {
        
        NSDictionary* metadata = @{ NSURLFileSizeKey : @(fileSize)};
        [NSFileProviderExtension writePlaceholderAtURL:placeholderURL withMetadata:metadata error:NULL];
    }];
    if (completionHandler) {
        completionHandler(nil);
    }
}

- (void)startProvidingItemAtURL:(NSURL *)url completionHandler:(void (^)(NSError *))completionHandler {
    // Should ensure that the actual file is in the position returned by URLForItemWithIdentifier:, then call the completion handler
    NSError* error = nil;
    __block NSError* fileError = nil;
#if 0
    NSData * fileData = [NSData data];
    // TODO: get the contents of file at <url> from model
    
    [self.fileCoordinator coordinateWritingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
        [fileData writeToURL:newURL options:0 error:&fileError];
    }];
#endif
    if (error!=nil) {
        completionHandler(error);
    } else {
        completionHandler(fileError);
    }
}


- (void)itemChangedAtURL:(NSURL *)url {
    // Called at some point after the file has changed; the provider may then trigger an upload
    
    // TODO: mark file at <url> as needing an update in the model; kick off update process
    //    NSLog(@"Item changed at URL %@", url);
}

- (void)stopProvidingItemAtURL:(NSURL *)url {
    // Called after the last claim to the file has been released. At this point, it is safe for the file provider to remove the content file.
    // Care should be taken that the corresponding placeholder file stays behind after the content file has been deleted.
#if 0
    [self.fileCoordinator coordinateWritingItemAtURL:url options:NSFileCoordinatorWritingForDeleting error:NULL byAccessor:^(NSURL *newURL) {
        [[NSFileManager defaultManager] removeItemAtURL:newURL error:NULL];
    }];
    [self providePlaceholderAtURL:url completionHandler:NULL];
#endif
}

@end
