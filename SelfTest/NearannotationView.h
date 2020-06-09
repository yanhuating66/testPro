//
//  NearannotationView.h
//  SelfTest
//
//  Created by 严华停 on 2020/1/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NearannotationView : MKAnnotationView
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *subtitle;
@end

NS_ASSUME_NONNULL_END
