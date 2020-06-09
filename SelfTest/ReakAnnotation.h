//
//  ReakAnnotation.h
//  SelfTest
//
//  Created by 严华停 on 2020/1/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ReakAnnotation : NSObject <MKAnnotation>
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;
@property(nonatomic,assign) BOOL IsStart;

@end

NS_ASSUME_NONNULL_END
