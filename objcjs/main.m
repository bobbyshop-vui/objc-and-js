#import <Foundation/Foundation.h>
#import <GCDWebServer/GCDWebServer.h>
#import <GCDWebServer/GCDWebServerDataResponse.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Tạo web server
        GCDWebServer* webServer = [[GCDWebServer alloc] init];
        
        // Thêm endpoint trả về JSON (button)
        [webServer addHandlerForMethod:@"GET"
                                   path:@"/ui"
                           requestClass:[GCDWebServerRequest class]
                           processBlock:^GCDWebServerResponse *(GCDWebServerRequest *request) {
            // Tạo JSON button
            NSDictionary *response = @{
                @"type": @"button",
                @"label": @"Click Me!",
                @"action": @"Button Clicked!"
            };
            
            // Tạo response
            GCDWebServerDataResponse *dataResponse = [GCDWebServerDataResponse responseWithJSONObject:response];
            
            // Thêm headers CORS để chấp nhận tất cả các nguồn
            [dataResponse setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
            [dataResponse setValue:@"GET, POST, PUT, DELETE" forAdditionalHeader:@"Access-Control-Allow-Methods"];
            [dataResponse setValue:@"Content-Type, Authorization" forAdditionalHeader:@"Access-Control-Allow-Headers"];
            
            return dataResponse;
        }];
        
        // Chạy server trên port 8080
        [webServer startWithPort:8080 bonjourName:nil];
        NSLog(@"Server đang chạy tại: %@", webServer.serverURL);
        
        // Để server chạy liên tục
        [[NSRunLoop mainRunLoop] run];  // Giữ ứng dụng hoạt động cho đến khi người dùng dừng
    }
    return 0;
}
