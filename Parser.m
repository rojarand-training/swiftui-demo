//
//  Parser.m
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 17/03/2023.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "Helper.h"

@implementation Parser

- (instancetype)init {
    self = [super init];
    return self;
}

- (nonnull ParsingResult *)parse:(nonnull NSData*)data {
    ParsingResultCode code = FrameNotFound;
    NSMutableArray<Frame> *frames = [[NSMutableArray<Frame> alloc] init];
    
    int offset = 0;
    const unsigned char *cdata = data.bytes;
    while (offset < data.length) {
        int startPosition = [Parser findIn: data positionOf: MESSAGE_START startingFrom: offset];
        if (startPosition == POSITION_NOT_FOUND) {
            return [[ParsingResult alloc] initWithCode: code frames: frames];
        }
        
        offset = startPosition+1;
        int endPosition = [Parser findIn: data positionOf: MESSAGE_END startingFrom: offset];
        if (endPosition == POSITION_NOT_FOUND) {
            return [[ParsingResult alloc] initWithCode: code frames: frames];
        }
        
        if ((endPosition-startPosition) < MIN_FRAME_LENGHT) {
            if (code != Success) {
                code = FrameTooShort;
            }
        }
       
        char tempLo = cdata[startPosition + TEMPERATURE_OFFSET];
        char tempHi = cdata[startPosition + TEMPERATURE_OFFSET + 1];
        
        SensorAdvertisementMessage message;
        message.temperature = (tempHi<<8);
        message.temperature |= (tempLo & 0xFF);
        message.batteryLevel = (cdata[startPosition + BATTERY_OFFSET] & 0xFF);
        
        SensorAdvertisementFrame *frame = [[SensorAdvertisementFrame alloc] initWithMessage: message];
        [frames addObject: frame];
        code = Success;
        offset = endPosition+1;
    }
    return [[ParsingResult alloc] initWithCode: code frames: frames];
}


+ (int)findIn:(NSData *) data positionOf:(unsigned char)byte startingFrom:(int) offset {
    int currentPosition = offset;
    const unsigned char * cdata = data.bytes;
    while (currentPosition < data.length) {
        if (cdata[currentPosition] == byte) {
            return currentPosition;
        }
        currentPosition += 1;
    }
    return POSITION_NOT_FOUND;
}


+ (void)misc {
    
    DeviceTelemetry* dev = [[DeviceTelemetry alloc]init];
    [dev runTest];
    /*
    NSString *res4 = [self isValid:@"aabbc"];
    NSLog(@"res4: %@", res4);
     */
}

+ (NSString *) isValid:(NSString *)s {
    const char *data = [s cStringUsingEncoding: NSASCIIStringEncoding];
    const int bufferSize = 'z'-'a'+1;
    int buffer[bufferSize];
    memset(buffer, 0, sizeof(buffer));
    for (int i=0; i<s.length; i++) {
        int pos = data[i] - 'a';
        buffer[pos]++;
    }
   
    NSMutableDictionary<NSNumber*, NSNumber*> *occurences = [[NSMutableDictionary alloc] init];
    for (int i=0; i<bufferSize; i++) {
        if (buffer[i] > 0) {
            NSNumber *key = [[NSNumber alloc]initWithInt:buffer[i]];
            NSNumber *occurence = [occurences objectForKey: key];
            long o = 1;
            if (occurence != nil) {
                o = occurence.integerValue + 1;
            }
            NSNumber *newValue = [[NSNumber alloc] initWithInt:o];
            [occurences setObject:newValue forKey:key];
            if (occurences.count > 2) {
                return @"NO";
            } else if (occurences.count == 2) {
                NSArray<NSNumber *> *keys = occurences.allKeys;
                NSNumber *key1 = [keys objectAtIndex:0];
                NSNumber *value1 = [occurences objectForKey: key1];
                NSNumber *key2 = [keys objectAtIndex:1];
                NSNumber *value2 = [occurences objectForKey: key2];
                
                if (key1.intValue > key2.intValue) {
                    if (value1.intValue > 1) {
                        return @"NO";
                    }
                    if ((key1.intValue - key2.intValue) > 1) {
                        return @"NO";
                    }
                } else if (key2.intValue > key1.intValue) {
                    if (value2.intValue > 1) {
                        return @"NO";
                    }
                    if ((key2.intValue - key1.intValue) > 1) {
                        return @"NO";
                    }
                }
            }
        }
    }
    return @"YES";
}

+ (void)misc1 {
  
    NSString *hexString = @"AB CD FF";
    const char * data = [hexString cStringUsingEncoding:kCFStringEncodingUTF8];
    const int bufferLenght = ((hexString.length)/3)+1;
    unsigned char buffer[bufferLenght];
    memset(buffer, 0, sizeof(buffer));
    int bufferPosition = 0;
    for (int i=0; i<hexString.length; i+=3, bufferPosition += 1) {
        char hex[3] = {data[i+0], data[i+1], 0};
        buffer[bufferPosition] = strtol(hex, NULL, 16);
    }
    
    const unsigned char *p = buffer;
    NSMutableString *outHexString = [NSMutableString string];
    for (int i=0; i < bufferLenght; i++) {
        [outHexString appendFormat:@"%02x", *p++];
    }
    
    char a1 = 0xAB;
    int a2 = a1;
    
    unsigned char b1 = 0xAB;
    int b2 = b1;
    
    if (a2 == b2) {
        NSLog(@"Wtf");
    } else {
        NSLog(@"Ok");
    }
    
    char ch1 = 0b00001111;
    ch1 ^= 0b11110000;
    //assert(ch1 == 0b11111111);
    
    ch1 &= ~0b00000001;
    
    int ch2 = ch1;
    

    /*
    NSArray *ar = [[NSArray alloc]initWithObjects:@10, @20, @20, @10, @10, @30, @50, @10, @20, nil];
    [self sockMerchant:@9 ar:ar];
    
    char bytes[5] = {1,2,3,4,5};
    NSMutableData *mutableData = [[NSMutableData alloc]initWithBytes:bytes length:sizeof(bytes)/sizeof(char)];
    NSLog(@"Mutable 1: %@", mutableData);
    NSRange range = NSMakeRange(0, 4);
    [mutableData replaceBytesInRange:range withBytes:NULL length:0];
    NSLog(@"Mutable 2: %@", mutableData);
    
    [mutableData appendBytes:bytes length:5];
    NSLog(@"Mutable 3: %@", mutableData);
    
    
    NSMutableDictionary<NSString *, NSNumber*> *digits = [[NSMutableDictionary alloc] init];
    [digits setObject:@1 forKey:@"1"];
    [digits setObject:@2 forKey:@"2"];
    NSNumber *numberForKey2 = [digits objectForKey:@"2"];
    //numberForKey2.intValue
    NSLog(@"Number for key2: %@", numberForKey2);
    
    NSDictionary* dict = @{
        @"Key1": @"Value1",
        @"Key2": @"Value2",
    };
    
    // loop through it (dynamic typing)
    for (id tempObject in dict) {
        NSLog(@"Object: %@, Key: %@", [dict objectForKey:tempObject], tempObject);
    }
    
    NSArray *myArray = [[NSArray alloc]initWithObjects:@"One", @"Two", @"Three", @"Four", nil];
     
    // loop through every element (static typing)
    for (NSString *tempObject in myArray) {
        NSLog(@"Single element: %@", tempObject);
    }*/
    NSArray *ar = [[NSArray alloc]initWithObjects:@0, @0, @1, @0, @0, @1, @0, nil];
    [self jumpingOnClouds:ar];
}

+ (NSNumber *) hourglassSum:(NSArray *)arr {
    // Write your code here
    NSLog(@"arr: %@",arr);
    
    const int hgWidth = 3;
    const int hgHeight = 3;
    const int matrixWidth = 6;
    const int matrixHeight = 6;
    int maxSum = -999;
    int top = 0;
    while (top+hgHeight <= matrixHeight) {
        int left = 0;
        while (left+hgWidth <= matrixWidth) {
            NSArray *l1 = [arr objectAtIndex:top+0];
            NSArray *l2 = [arr objectAtIndex:top+1];
            NSArray *l3 = [arr objectAtIndex:top+2];
            NSNumber *numberA = [l1 objectAtIndex:left+0];
            NSNumber *numberB = [l1 objectAtIndex:left+1];
            NSNumber *numberC = [l1 objectAtIndex:left+2];
            
            NSNumber *numberD = [l2 objectAtIndex:left+1];
            
            NSNumber *numberE = [l3 objectAtIndex:left+0];
            NSNumber *numberF = [l3 objectAtIndex:left+1];
            NSNumber *numberG = [l3 objectAtIndex:left+2];
            
            int currentSum =
                numberA.intValue +
                numberB.intValue +
                numberC.intValue +
                numberD.intValue +
                numberE.intValue +
                numberF.intValue +
                numberG.intValue;
            
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
            
            left += 1;
        }
        top += 1;
    }
    
    return [[NSNumber alloc]initWithInt:maxSum];
}

+ (NSNumber *) jumpingOnClouds:(NSArray *)c {
    
    unsigned int offset = 0;
    unsigned int steps = 0;
    unsigned long count = [c count];
    while (offset+1 < count) {
        if (offset+2 < count) {
            NSNumber* cloudPlus2 = [c objectAtIndex: offset+2];
            if (cloudPlus2.intValue == 0) {
                offset += 2;
            } else {
                offset += 1;
            }
            steps += 1;
        } else {
            steps += 1;
            offset += 1;
        }
    }
    return [[NSNumber alloc]initWithInt:steps];
}

+ (NSNumber *) sockMerchant:(NSNumber *)n ar:(NSArray *)ar {
    
    // Write your code here
    int socks[100];
    memset(socks, 0, sizeof(socks));
    
    for (NSNumber *sockNumber in ar) {
        NSLog(@"number: %@", sockNumber);
        socks[sockNumber.intValue-1]++;
    }
    int numberOfPairs = 0;
    for (int i = 0; i<100; i++) {
        numberOfPairs += (socks[i]/2);
    }
    return [[NSNumber alloc]initWithInt:numberOfPairs];
}


+ (void)parseByte:(unsigned char)byte
        valAtBit0:(unsigned char *)valAtBit0
 valAtBitFrom2To5:(unsigned char *)valAtBitFrom2To5
 valAtBitFrom6to7:(unsigned char *)valAtBitFrom6to7 {
    
    *valAtBit0 = (byte & 0b00000001) >> 0;
    *valAtBitFrom2To5 = (byte & 0b00111100) >> 2;
    *valAtBitFrom6to7 = (byte & 0b11000000) >> 6;
}

@end
