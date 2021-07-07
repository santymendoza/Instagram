//
//  HomeViewController.m
//  Instagram
//
//  Created by Santy Mendoza on 7/6/21.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostCell.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong,nonatomic) NSArray *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getData];
    // Do any additional setup after loading the view.
}
- (IBAction)logOutPressed:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController: loginViewController];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

- (void) getData {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        }
        else {
            // handle error
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfPosts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.photoImageView = post[@"image"];
    
    
    
//    cell.name.text = tweet.user.name;
//    cell.userName.text = tweet.user.screenName;
//
//    cell.date.text = tweet.createdAtString;
//
//
//    cell.tweetText.text = tweet.text;
//    cell.tweet = tweet;
//    NSString *countString = [NSString stringWithFormat: @"%d", tweet.favoriteCount];
//    [cell.favoritedButton setTitle:countString forState:UIControlStateNormal];
//    countString = [NSString stringWithFormat: @"%d", tweet.retweetCount];
//    [cell.retweetButton setTitle:countString forState:UIControlStateNormal];
//
//    NSString *URLString = tweet.user.profilePicture;
//    URLString = [URLString
//           stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
//    NSURL *url = [NSURL URLWithString:URLString];
//
//    cell.profilePicture.image = nil;
//    [cell.profilePicture setImageWithURL: url];
    
    
    
    return cell;
    
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
