//
//  ThirdVC.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/12.
//

#import "ThirdVC.h"
#import "Header.h"
@interface ThirdVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(ksafeAreaInsetsTop, 10, ksafeAreaInsetsBottom, 10));
    }];
    [self fetchData];
}

-(void)fetchData{
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data1" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
        self.dataArray = [NSArray yy_modelArrayWithClass:[ThirdModel class] json:[jsonDictionary objectForKey:@"list"]];
        [self.tableView reloadData];
    } else if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSArray *jsonArray = (NSArray *)jsonObject;
        NSLog(@"JSON 数据: %@", jsonArray);
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ThirdVCCell class] forCellReuseIdentifier:NSStringFromClass([ThirdVCCell class])];
    }
    return _tableView;
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdVCCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThirdVCCell class]) forIndexPath:indexPath];
    ThirdModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
@end
