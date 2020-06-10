//
//  ViewController.m
//  SelfTest
//
//  Created by 严华停 on 2020/1/13.
//  Copyright © 2020 apple. All rights reserved.
//
#define wid    self.view.frame.size.width
#define hei  self.view.frame.size.height
#import "ViewController.h"
#import "FirstVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NearannotationView.h"
#import "ReakAnnotation.h"
@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *mapview;
    CLLocationManager *locationManager;
    NSMutableArray *dataArr;
}
@end

@implementation ViewController
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDarkContent;
//}

-(void)viewWillAppear:(BOOL)animated
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIView *v =[[UIView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, wid, 44)];
        v.backgroundColor =[UIColor grayColor];
        [[self.navigationController.navigationBar subviews][0] addSubview:v];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor yellowColor];
    self.title =@"主页";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    
    dataArr =[NSMutableArray array];
    CLLocation *loca =[[CLLocation alloc] initWithLatitude:40.23 longitude:116.39];
    [dataArr addObject:loca];
    
    mapview =[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, wid, hei)];
     mapview.showsUserLocation =YES;
     mapview.userTrackingMode =MKUserTrackingModeFollow;
    mapview.delegate =self;
     [self.view addSubview:mapview];
    
    
    locationManager =[[CLLocationManager alloc] init];

    locationManager.distanceFilter =5.0;
    
    locationManager.delegate = self;

    
     // 判断系统定位服务是否开启
     if (![CLLocationManager locationServicesEnabled]) {

         NSLog(@"%@", @"提示：系统定位服务不可用，请开启 ！");

     } else {

         // 判断应用定位服务授权状态
         if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){                 // 没有授权

             // 8.0 及以上系统需手动请求定位授权
             if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {

                 // 前台定位，需在 info.plist 里设置 Privacy - Location When In Use Usage Description 的值
                 [locationManager requestWhenInUseAuthorization];

                 // 前后台同时定位，需在 info.plist 里设置 Privacy - Location Always Usage Description 的值
                 // [self.locationManager requestAlwaysAuthorization];
             }

             // 开始定位追踪（第一次打开软件时）
             [locationManager startUpdatingLocation];

         } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse
                    || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {  // 允许定位授权

             // 开始定位追踪
             [locationManager startUpdatingLocation];

         } else{                                                                                             // 拒绝定位授权

             // 创建警告框（自定义方法）
             NSLog(@"%@", @"提示：当前应用的定位服务不可用，请检查定位服务授权状态 ！");
         }
     }
//    [locMgr requestWhenInUseAuthorization];
    
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Touch:)];
//    [mapview addGestureRecognizer:tap];
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

//    if ([annotation isKindOfClass:[ReakAnnotation class]]) {
//
//        MKAnnotationView *annotitV =[mapView dequeueReusableAnnotationViewWithIdentifier:@"Anitition"];
//        if (!annotitV) {
//
//            annotitV =[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Anitition"];
//
//        }
//        annotitV.annotation =annotation;
//        return annotitV;
//    }else{
//        return nil;
//    }
    
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]init];
    pinView.pinTintColor =[UIColor redColor];
      if ([annotation isKindOfClass:[ReakAnnotation class]]) {

          ReakAnnotation *kcAnnotation = annotation;
          pinView.annotation =kcAnnotation;
          pinView.pinTintColor =kcAnnotation.IsStart ==YES ? [UIColor greenColor]:[UIColor redColor];

          return pinView;
      }else{
          return nil;
      }


//      return pinView;
}

// 更新到用户的位置
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

       // 只要用户位置改变就调用此方法（包括第一次定位到用户位置），userLocation：是对用来显示用户位置的蓝色大头针的封装

       // 反地理编码
       [[[CLGeocoder alloc] init] reverseGeocodeLocation:userLocation.location
                                       completionHandler:^(NSArray *placemarks, NSError *error) {

           CLPlacemark *placemark = [placemarks firstObject];

           // 设置用户位置蓝色大头针的标题
           userLocation.title = [NSString stringWithFormat:@"当前位置：%@, %@, %@",
                                 placemark.thoroughfare, placemark.locality, placemark.country];
       }];

       // 设置用户位置蓝色大头针的副标题
       userLocation.subtitle = [NSString stringWithFormat:@"经纬度：(%lf, %lf)",
                                userLocation.location.coordinate.longitude, userLocation.location.coordinate.latitude];

       // 手动设置显示区域中心点和范围

       if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {

           // 显示的中心
           CLLocationCoordinate2D center = userLocation.location.coordinate;

           // 设置地图显示的中心点
           [mapview setCenterCoordinate:center animated:YES];

           // 设置地图显示的经纬度跨度
           MKCoordinateSpan span = MKCoordinateSpanMake(0.023503, 0.017424);

           // 设置地图显示的范围
           MKCoordinateRegion rengion = MKCoordinateRegionMake(center, span);
           [mapview setRegion:rengion animated:YES];
       }
    
    CLLocation *s1 =dataArr[0];
    CLLocationCoordinate2D start = s1.coordinate;
      CLLocationCoordinate2D endCoordinate;
            endCoordinate.latitude = userLocation.coordinate.latitude;
            endCoordinate.longitude = userLocation.coordinate.longitude;
//    double meters = [self calculateDistanceWithStart:startCoordinate end:endCoordinate];
//         NSLog(@"移动的距离为%f米",meters);
        CLLocationCoordinate2D pointsToUse[2];
                pointsToUse[0] = start;
                pointsToUse[1] = endCoordinate;

    MKPolyline *lineOne = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
              [mapView addOverlay:lineOne];

    
    

   }
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    render.lineWidth = 5.0;
    render.strokeColor = [UIColor blueColor];
    
    return render;
}
   // 地图显示的区域将要改变
   - (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {

       NSLog(@"区域将要改变：经度：%lf, 纬度：%lf, 经度跨度：%lf, 纬度跨度：%lf",
             mapView.region.center.longitude, mapView.region.center.latitude,
             mapView.region.span.longitudeDelta, mapView.region.span.latitudeDelta);
   }

   // 地图显示的区域改变了
   - (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

       NSLog(@"区域已经改变：经度：%lf, 纬度：%lf, 经度跨度：%lf, 纬度跨度：%lf",
             mapView.region.center.longitude, mapView.region.center.latitude,
             mapView.region.span.longitudeDelta, mapView.region.span.latitudeDelta);
   }
-(void)Touch:(UIGestureRecognizer *)sender
{
    
  CGPoint touchPoint = [sender locationInView:mapview];
    //把 x y的值转化为经纬度 并且让大头针模型存储起来
    CLLocationCoordinate2D coordinate = [mapview convertPoint:touchPoint toCoordinateFromView:mapview];
    //创建大头针模型
    ReakAnnotation * annotation = [[ReakAnnotation alloc] init];
    //给模型赋值
    annotation.coordinate = coordinate;
    annotation.title = @"主标题";
    annotation.subtitle = @"副标题...";
    //添加大头针标注信息
    [mapview addAnnotation:annotation];
    NSLog(@"真的爱你");
    NSString *title =@"奶思";
    if (title.length ==5) {
        return;
    }
    NSLog(@"title =%@",title);
    NSLog(@"sdasdasdasd");
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"开始更新位置了。。。。。。");
    
    NSLog(@"locatin =%@",locations);
    
    CLLocation *loca =locations.firstObject;
    CLLocationCoordinate2D coordinate =loca.coordinate;
    
    [dataArr addObject:loca];
    
    ReakAnnotation * annotation = [[ReakAnnotation alloc] init];
       //给模型赋值
       annotation.coordinate = coordinate;
       annotation.title = @"主标题";
       annotation.subtitle = @"副标题...";
    annotation.IsStart =NO;
       //添加大头针标注信息
    [mapview addAnnotation:annotation];
    
    ReakAnnotation * annotation1 = [[ReakAnnotation alloc] init];
          //给模型赋值
    CLLocation *dirst =dataArr[0];
          annotation1.coordinate = dirst.coordinate;
          annotation1.title = @"k主标题";
          annotation1.subtitle = @"k副标题...";
       annotation1.IsStart =YES;
          //添加大头针标注信息
       [mapview addAnnotation:annotation1];
}



@end
