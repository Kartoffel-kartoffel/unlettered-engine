//
//  bridge c.m
//  unlettered 1.0
//
//  Created by someone on 5/11/2026.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#include "bridgecpp.h"

@interface FullScreenPixelWindow : NSWindow
@end
@implementation FullScreenPixelWindow
- (BOOL)canBecomeKeyWindow { return YES; }
- (BOOL)canBecomeMainWindow { return YES; }
@end

WindowBridge::WindowBridge() : opaqueWindowInstance(nullptr) {}
WindowBridge::~WindowBridge() { closeWindow(); }

void WindowBridge::initWindow() {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    NSScreen *mainScreen = [NSScreen mainScreen];
    NSRect screenFrame = [mainScreen frame];
//the top bar thingy
    
    NSWindowStyleMask styleMask = NSWindowStyleMaskTitled |
                                  NSWindowStyleMaskClosable |
                                  NSWindowStyleMaskMiniaturizable | // Enables the Orange button
                                  NSWindowStyleMaskResizable;       // Enables the Green button
//this will backfire later
    FullScreenPixelWindow *window = [[FullScreenPixelWindow alloc]
        initWithContentRect:screenFrame
                  styleMask:styleMask
                    backing:NSBackingStoreBuffered
                      defer:NO];

    [window setOpaque:YES];
    [window setBackgroundColor:[NSColor blackColor]];
    
    //forgot how this works
    [window setLevel:NSNormalWindowLevel];
    
    [window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];

    opaqueWindowInstance = (__bridge_retained void*)window;
}
//forgot how to edit window dimesions here
void WindowBridge::setWindowSize(int width, int height) {
    if (!opaqueWindowInstance) return;
    NSWindow* window = (__bridge NSWindow*)opaqueWindowInstance;
    NSRect frame = [window frame];
    frame.size.width = width;
    frame.size.height = height;
    [window setFrame:frame display:YES];
}
//idk why a pointer is here
void WindowBridge::closeWindow() {
    if (!opaqueWindowInstance) return;
    NSWindow* window = (__bridge_transfer NSWindow*)opaqueWindowInstance;
    [window close];
    opaqueWindowInstance = nullptr;
}

void WindowBridge::runEventLoop() {
    // cocoa and cpp teamwork does not make the dreamwork in any way
    [NSApp run];
}
