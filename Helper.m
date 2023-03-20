//
//  Helper.m
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 20/03/2023.
//

#import <Foundation/Foundation.h>
#import "Helper.h"

/**
 *  Device Telemetry class.
 */

static const unsigned char START_TELEMETRY_V1 = 0x28;
static const int NOT_FOUND = -1;

typedef NS_ENUM(NSUInteger, FrameId) {
    SystemHealth = 0x03,
    Accelerometer = 0x04,
    Sensors = 0x06,
    Movement = 0x17,
    AirPressure = 0x19,
};

@implementation DeviceTelemetry

    -(void) runTest {
        NSString *hexString = @"28090410feed3affffffff06035b03b9614803060015021530020b130326ffff05198410c147041705fafa";
        NSData *hexData = [hexString dataUsingEncoding: NSASCIIStringEncoding];
        NSData *data = [self dataFromHexString: hexData];
        [self updateWithData:data];
    }

    - (void)updateWithData:(NSData *)data
    {
        int startPosition = [self findIn: data positionOf: START_TELEMETRY_V1 startingFrom: 0];
        if (startPosition == NOT_FOUND) {
            return;
        }
        
        const int dataLength = data.length;
        const unsigned char * cdata = data.bytes;
        
        int currentPosition = startPosition+1;
        while (currentPosition+2 < dataLength) {
            currentPosition = [self parse:cdata offset:currentPosition];
            if (currentPosition == NOT_FOUND) {
                return;
            } else {
                currentPosition += 1;
            }
        }
    }

- (int)parse:(const char*)cdata offset:(int)offset {
    FrameId frameIdentifier = cdata[offset+1];
    switch (frameIdentifier) {
        case Accelerometer:
            return [self parseAccelerometer: cdata offset: offset];
        case Sensors:
            return [self parseSensors: cdata offset: offset];
        case SystemHealth:
            return [self parseHealth: cdata offset: offset];
        case Movement:
            return [self parseMovement:cdata offset:offset];
        case AirPressure:
            return [self parseAirPressure:cdata offset:offset];
    }
    return NOT_FOUND;
}

- (int)parseAccelerometer: (const char *)cdata offset:(int) offset {
    if (cdata[offset] != 0x09) {
        return NOT_FOUND;
    }
    if (cdata[offset+1] != Accelerometer) {
        return NOT_FOUND;
    }
    unsigned char sensitivity = cdata[offset+2];
    self.sensitivity = [[NSNumber alloc] initWithInt:sensitivity];
   
    DeviceAcceleration a;
    a.x = (int8_t)cdata[offset+3];
    a.y = (int8_t)cdata[offset+4];
    a.z = (int8_t)cdata[offset+5];
    self.acceleration = a;
    
    unsigned short tap = cdata[offset+6]<<8;
    tap |= cdata[offset+7];
   
    unsigned char threshold = (cdata[offset+8] << 8);
    threshold |= cdata[offset+9];
    self.lastThreshold = [[NSNumber alloc]initWithInt:threshold];
    return offset+0x09;
}

- (int)parseSensors: (const char *)cdata offset:(int) offset {
    if (cdata[offset] != 0x03) {
        return NOT_FOUND;
    }
    if (cdata[offset+1] != Sensors) {
        return NOT_FOUND;
    }
    unsigned char lightLevel = cdata[offset+2];
    if (lightLevel >= 100) {
        lightLevel = 0xFF;
    }
    
    self.lightSensor = [[NSNumber alloc]initWithInt:lightLevel];
    
    unsigned char temperature = cdata[offset+3];
    self.temperature = [[NSNumber alloc]initWithInt:temperature];
    return offset+0x03;
}

- (int)parseHealth: (const char *)cdata offset:(int) offset {
    if (cdata[offset] != 0x06) {
        return NOT_FOUND;
    }
    if (cdata[offset+1] != SystemHealth) {
        return NOT_FOUND;
    }
    unsigned int timestamp = 0;
    timestamp |= cdata[offset+2]<<24;
    timestamp |= cdata[offset+3]<<16;
    timestamp |= cdata[offset+4]<<8;
    timestamp |= cdata[offset+5]<<0;
    
    self.date = [NSDate dateWithTimeIntervalSinceReferenceDate:timestamp];
    
    self.batteryLevel = [[NSNumber alloc]initWithInt:cdata[offset+6]];
    return offset+0x06;
}

- (int)parseMovement: (const char *)cdata offset:(int) offset {
    if (cdata[offset] != 0x04) {
        return NOT_FOUND;
    }
    if (cdata[offset+1] != Movement) {
        return NOT_FOUND;
    }
    
    unsigned char movement = cdata[offset+2];
    self.movementID =  [[NSNumber alloc]initWithInt:movement];
    
    unsigned short threshold = cdata[offset+3] << 8;
    threshold |= cdata[offset+4];
    
    //self.lastThreshold = [[NSNumber alloc]initWithInt:threshold];
    
    return offset+0x04;
}


- (int)parseAirPressure: (const char *)cdata offset:(int) offset {
    
}

- (int)findIn:(NSData *) data positionOf:(unsigned char)byte startingFrom:(int) offset {
    int currentPosition = offset;
    const unsigned char * cdata = data.bytes;
    while (currentPosition < data.length) {
        if (cdata[currentPosition] == byte) {
            return currentPosition;
        }
        currentPosition += 1;
    }
    return NOT_FOUND;
}


- (NSData *)dataFromHexString: (NSData *)hexData {
    NSString* hex = [[NSString alloc] initWithData:hexData encoding:NSUTF8StringEncoding];
    const char *chars = [hex UTF8String];
    int i = 0, len = hex.length;
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    return data;
}

@end

