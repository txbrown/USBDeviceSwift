//
//  USBDevice.swift
//  USBDeviceSwift
//
//  Created by Artem Hruzd on 6/11/17.
//  Copyright © 2017 Artem Hruzd. All rights reserved.
//

import Cocoa
import IOKit
import IOKit.usb
import IOKit.usb.IOUSBLib

//from IOUSBLib.h
public let kIOUSBDeviceUserClientTypeID = CFUUIDGetConstantUUIDWithBytes(nil,
                                                                  0x9d, 0xc7, 0xb7, 0x80, 0x9e, 0xc0, 0x11, 0xD4,
                                                                  0xa5, 0x4f, 0x00, 0x0a, 0x27, 0x05, 0x28, 0x61)
public let kIOUSBDeviceInterfaceID = CFUUIDGetConstantUUIDWithBytes(nil,
                                                             0x5c, 0x81, 0x87, 0xd0, 0x9e, 0xf3, 0x11, 0xD4,
                                                             0x8b, 0x45, 0x00, 0x0a, 0x27, 0x05, 0x28, 0x61)

//from IOCFPlugin.h
public let kIOCFPlugInInterfaceID = CFUUIDGetConstantUUIDWithBytes(nil,
                                                            0xC2, 0x44, 0xE8, 0x58, 0x10, 0x9C, 0x11, 0xD4,
                                                            0x91, 0xD4, 0x00, 0x50, 0xE4, 0xC6, 0x42, 0x6F)

public let kIOUSBInterfaceInterfaceID700 = CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault, 0x17, 0xF9, 0xE5, 0x9C, 0xB0, 0xA1, 0x40, 0x1D, 0x9A, 0xC0, 0x8D, 0xE2, 0x7A, 0xC6, 0x04, 0x7E)


/*!
 @defined USBmakebmRequestType
 @discussion Macro to encode the bRequest field of a Device Request.  It is used when constructing an IOUSBDevRequest.
 */

public func USBmakebmRequestType(direction:Int, type:Int, recipient:Int) -> UInt8 {
    return UInt8((direction & kUSBRqDirnMask) << kUSBRqDirnShift)|UInt8((type & kUSBRqTypeMask) << kUSBRqTypeShift)|UInt8(recipient & kUSBRqRecipientMask)
}

public extension Notification.Name {
    static let USBDeviceConnected = Notification.Name("USBDeviceConnected")
    static let USBDeviceDisconnected = Notification.Name("USBDeviceDisconnected")
}

public struct USBMonitorData {
    public let vendorId:UInt16
    public let productId:UInt16
    
    public init (vendorId:UInt16, productId:UInt16) {
        self.vendorId = vendorId
        self.productId = productId
    }
}

public struct USBDevice {
    public let id:UInt64
    public let vendorId:UInt16
    public let productId:UInt16
    public let name:String
    
 
    public let deviceInterfacePtrPtr:UnsafeMutablePointer<UnsafeMutablePointer<IOUSBDeviceInterface650>?>?
    public let plugInInterfacePtrPtr:UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>?>?
    
    public let interfaceInterfacePtr:UnsafeMutablePointer<UnsafeMutablePointer<IOUSBInterfaceInterface700>?>?
    
    public init(id:UInt64,
                vendorId:UInt16,
                productId:UInt16,
                name:String,
                deviceInterfacePtrPtr:UnsafeMutablePointer<UnsafeMutablePointer<IOUSBDeviceInterface650>?>?,
                plugInInterfacePtrPtr:UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>?>?,
                interfaceInterfacePtr:UnsafeMutablePointer<UnsafeMutablePointer<IOUSBInterfaceInterface700>?>?
                ) {
        self.id = id
        self.vendorId = vendorId
        self.productId = productId
        self.name = name
        self.deviceInterfacePtrPtr = deviceInterfacePtrPtr
        self.plugInInterfacePtrPtr = plugInInterfacePtrPtr
        self.interfaceInterfacePtr = interfaceInterfacePtr
    }
}
