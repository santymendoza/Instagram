//
//  PostCell.m
//  Instagram
//
//  Created by Santy Mendoza on 7/7/21.
//

#import "PostCell.h"
#import <Parse/Parse.h>
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.photoImageView.image = image_placeHolder;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    self.captionLabel.text = post[@"caption"];
    self.usernameLabel.text = post[@"author"][@"username"];
   
    NSString *countString = [NSString stringWithFormat: @"%lu likes", post.likers.count];
    [self.likeButton setTitle:countString forState:UIControlStateNormal];
    [self.photoImageView loadInBackground];
}

- (void) likePost:(Post *)post {
    if (post.likers == nil) {
        post.likers = [NSMutableArray new];
        [post[@"likers"] addObject:PFUser.currentUser[@"username"]];
    }
    else if (![post.likers containsObject:PFUser.currentUser]){
        [post[@"likers"] addObject:PFUser.currentUser[@"username"]];
    }
    NSString *countString = [NSString stringWithFormat: @"%lu likes", post.likers.count];
    [self.likeButton setTitle:countString forState:UIControlStateNormal];
    [self.likeButton setSelected:TRUE];
    [post saveInBackground];
}

- (IBAction)likeButtonClicked:(id)sender {
    [self likePost:_post];
}

@end
