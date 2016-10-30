//
//  AppDelegate.m
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//  Copyright (c) 2556 BE 星凤. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

   // Insert code here to initialize your application
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:NULL];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification; {
   [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤HoạtĐộngLại" object:NULL];
//   NSLog( @"AppDelegate: becomeActive" );
}

- (void)applicationDidResignActive:(NSNotification *)notification; {
   [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤DấuChươngTrình" object:NULL];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
   
   [[self window] makeKeyAndOrderFront:self];
   
   return YES;
}

#pragma mark ---- WindowWillClose
- (void)windowWillClose:(NSNotification *)notification; {
   // ---- only terminate if _window close
   if( [notification object] == _window )
      [NSApp terminate:self];
}

@end
