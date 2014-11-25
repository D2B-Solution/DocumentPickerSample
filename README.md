DocumentPickerSample
=============
This is Document Picker and Document Provider Sample in iOS 8.0+.

### Notes: 
1. In Xcode, please set up below:
	
  (1) Capability of DocumentPickerSample : iCloud = ON, App Groups = ON
  
  (2) Capability of DocumentProvider : App Groups = ON 
  
  (3) Capability of DocumentProviderFileProvider : App Groups = ON

  and Fix Issues.

2. Check App Group IDs are same, and set App Group ID in AppGroupID.h

3.  Check DocumentProviderFileProvider's Info.plist : NSExtension -> NSExtensionFileProviderDocumentGroup = App Group ID
