//
//  PlayMemoViewController.h
//  Shnoozle
//
//  Created by Leo on 26/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayMemoVC : UIViewController<AVAudioPlayerDelegate>
@property (strong, nonatomic) NSURL *memoURL;


@end
