//
//  SensorAdvertisementFrame.h
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 18/03/2023.
//

#ifndef SensorAdvertisementFrame_h
#define SensorAdvertisementFrame_h

NS_ASSUME_NONNULL_BEGIN
@protocol Frame <NSObject>
@end

typedef struct {
    int temperature;
    char batteryLevel;
} SensorAdvertisementMessage;

@interface SensorAdvertisementFrame: NSObject <Frame>
@property(readonly) SensorAdvertisementMessage message;
- (instancetype)initWithMessage:(SensorAdvertisementMessage)message;
@end

NS_ASSUME_NONNULL_END

#endif /* SensorAdvertisementFrame_h */
