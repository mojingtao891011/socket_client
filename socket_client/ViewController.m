//
//  ViewController.m
//  socket_client
//
//  Created by 莫景涛 on 15/4/8.
//  Copyright (c) 2015年 莫景涛. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_myClient ;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myClient = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_myClient connectToHost:@"192.168.1.104" onPort:0x8080 withTimeout:60.0 error:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendAction:(UIButton *)sender
{
    NSData *data = [_textField.text dataUsingEncoding:NSUTF8StringEncoding];
    [_myClient writeData:data withTimeout:60 tag:10];
}
#pragma mark-GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    
    //一直监听服务器端的回复
    [sock readDataWithTimeout:-1 tag:11];
    
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    //一直监听服务器端的回复
    [sock readDataWithTimeout:-1 tag:11];
    //收到服务器端的回复
    _label.text =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
   
}
- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock
{
    NSLog(@"关闭socket");
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"%@",[err debugDescription]);
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"写入完成");
    
    

}
@end
