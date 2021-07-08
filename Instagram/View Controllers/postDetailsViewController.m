//
//  postDetailsViewController.m
//  Instagram
//
//  Created by Santy Mendoza on 7/8/21.
//

#import "postDetailsViewController.h"
#import <Parse/Parse.h>
@import Parse;

@interface postDetailsViewController ()



@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet PFImageView *postImage;

@property (weak, nonatomic) IBOutlet UILabel *captionLabel;



@end

@implementation postDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionLabel.text = self.post.caption;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.timeLabel.text = [formatter stringFromDate:self.post.createdAt];
//    self.timeLabel.text = self.post.createdAt;
    self.postImage.file = self.post[@"image"];
    [self.postImage loadInBackground];
//    NSString *createdAtString = self.post[@"createdAt"];
//    self.timeLabel.text = createdAtString;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
