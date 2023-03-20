//
//  Helper.h
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 20/03/2023.
//

#ifndef Helper_h
#define Helper_h

typedef struct {
    int8_t x;
    int8_t y;
    int8_t z;
} DeviceAcceleration;

@interface DeviceTelemetry : NSObject
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable batteryLevel;
    @property (nonatomic, readwrite, copy) NSDate   * _Nullable date;
    @property (nonatomic, readwrite, assign) DeviceAcceleration acceleration;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable sensitivity;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable airPressuer;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable movementID;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable lastThreshold;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable lightSensor;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable temperature;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable humidity;
    @property (nonatomic, readwrite, copy) NSNumber * _Nullable pirDetection;

-(void) runTest;
@end


#endif /* Helper_h */
