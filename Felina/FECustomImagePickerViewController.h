//
//  FECustomImagePickerViewController.h
//  Felina
//
//  Created by Sam Bodanis on 09/02/2014.
//  Copyright (c) 2014 Sam Bodanis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ELCImagePickerController.h>

#import <ELCImagePickerController/ELCAlbumPickerController.h>
#import <ELCImagePickerController/ELCAsset.h>
#import <ELCImagePickerController/ELCAssetCell.h>
#import <ELCImagePickerController/ELCAssetPickerFilterDelegate.h>
#import <ELCImagePickerController/ELCAssetSelectionDelegate.h>
#import <ELCImagePickerController/ELCAssetTablePicker.h>
#import <ELCImagePickerController/ELCImagePickerController.h>

//#import <ELCImagePickerController/ELCImagePickerController.h>
//#import <ELCImagePickerController/ELCImagePickerController.h>
//#import <ELCImagePickerController/ELCAlbumPickerController.h>
//#import <ELCImagePickerController/ELCAssetTablePicker.h>


@interface FECustomImagePickerViewController : UIViewController <ELCImagePickerControllerDelegate, UIScrollViewDelegate>

@end
