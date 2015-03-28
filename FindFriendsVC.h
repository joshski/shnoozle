//
//  FindFriendsViewController.h
//  Shnoozle
//
//  Created by Leo on 26/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindFriendsVC : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
