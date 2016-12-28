# iOS-System-Symbols
Share iOS system symbol files copied from 'iOS DeviceSupport' folder. Useful for symbolicating iOS crash log.

The download address is in [collected-symbol-files.md](https://github.com/Zuikyo/iOS-System-Symbols/blob/master/collected-symbol-files.md).

When I get new symbol file, i will add it into the google drive sharing folder, and update the [collected-symbol-files.md](https://github.com/Zuikyo/iOS-System-Symbols/blob/master/collected-symbol-files.md).You can follow this repository to get the latest update.

## What's the use of system symbol files

It's for symbolicating those system frameworks in your iOS crash report.

When you get a crash report like this:

```
Thread 0 name:  Dispatch queue: com.apple.main-thread
Thread 0 Crashed:
0   libobjc.A.dylib                 0x000000018b816f30 0x18b7fc000 + 110384 (objc_msgSend + 16)
1   UIKit                           0x0000000192e0a79c 0x192c05000 + 2119580 (<redacted> + 72)
2   UIKit                           0x0000000192c4db48 0x192c05000 + 297800 (<redacted> + 312)
3   UIKit                           0x0000000192c4d988 0x192c05000 + 297352 (<redacted> + 160)
4   QuartzCore                      0x00000001900d6404 0x18ffc5000 + 1119236 (<redacted> + 260)
5   libdispatch.dylib               0x000000018bc551c0 0x18bc54000 + 4544 (<redacted> + 16)
6   libdispatch.dylib               0x000000018bc59d6c 0x18bc54000 + 23916 (_dispatch_main_queue_callback_4CF + 1000)
7   CoreFoundation                  0x000000018cd79f2c 0x18cc9d000 + 905004 (<redacted> + 12)
8   CoreFoundation                  0x000000018cd77b18 0x18cc9d000 + 895768 (<redacted> + 1660)
9   CoreFoundation                  0x000000018cca6048 0x18cc9d000 + 36936 (CFRunLoopRunSpecific + 444)
10  GraphicsServices                0x000000018e729198 0x18e71d000 + 49560 (GSEventRunModal + 180)
11  UIKit                           0x0000000192c80628 0x192c05000 + 505384 (<redacted> + 684)
12  UIKit                           0x0000000192c7b360 0x192c05000 + 484192 (UIApplicationMain + 208)
13  MyApp                           0x0000000100016e54 0x100004000 + 77396 (_mh_execute_header + 77396)
14  libdyld.dylib                   0x000000018bc885b8 0x18bc84000 + 17848 (<redacted> + 4)
```

The callstack doesn't catch your app's code, it only has code from system framework. So you need to symbolicate these system code.

Here is the symbolicated report, those`<redacted>` were changed into specific method name:

```
Thread 0 name:  Dispatch queue: com.apple.main-thread
Thread 0 Crashed:
0   libobjc.A.dylib                 0x000000018b816f30 objc_msgSend + 16
1   UIKit                           0x0000000192e0a79c -[UISearchDisplayController _sendDelegateDidBeginDidEndSearch] + 72
2   UIKit                           0x0000000192c4db48 -[UIViewAnimationState sendDelegateAnimationDidStop:finished:] + 312
3   UIKit                           0x0000000192c4d988 -[UIViewAnimationState animationDidStop:finished:] + 160
4   QuartzCore                      0x00000001900d6404 CA::Layer::run_animation_callbacks(void*) + 260
5   libdispatch.dylib               0x000000018bc551c0 _dispatch_client_callout + 16
6   libdispatch.dylib               0x000000018bc59d6c _dispatch_main_queue_callback_4CF + 1000
7   CoreFoundation                  0x000000018cd79f2c __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 12
8   CoreFoundation                  0x000000018cd77b18 __CFRunLoopRun + 1660
9   CoreFoundation                  0x000000018cca6048 CFRunLoopRunSpecific + 444
10  GraphicsServices                0x000000018e729198 GSEventRunModal + 180
11  UIKit                           0x0000000192c80628 -[UIApplication _run] + 684
12  UIKit                           0x0000000192c7b360 UIApplicationMain + 208
13  MyApp                           0x0000000100016e54 main (main.m:15)
14  libdyld.dylib                   0x000000018bc885b8 start + 4
```
We can make out that the problem was caused by `UISearchDisplayController`'s`delegate`. It's`assign`. This crash happened when tap search bar while poping the viewController.

##The problem of symbolicating system frameworks

You may find out that you can't always symbolicate those system code. There're several problems:

* If you want to symbolicate system frameworks in your crash report, you need the corresponding system symbols, matching the OS Version and CPU architecture.
* Those system symbols can only be gained from physical iOS devices. Apple never  offer a website to download these symbols.

When you first connect a new iOS device to Xcode, Xcode will show a loading message: `Processing symbol files`. It's copying system symbol files from device to your Mac's path: `~/Library/Developer/Xcode/iOS DeviceSupport`.

That means you need a corresponding device if you want to symbolicate a crash report. There are 86 versions from `7.0 (11A465)` to `10.2 (14C92)`(most OS version contains three different type:`arm64`,`armv7s`,`armv7`. A`arm64`device contains both`arm64`and`armv7s`). That's obviously very difficult to collect them all.

That's the meaning of this repository, to share these system symbols.

##How to use

1. When you need to symbolicate a crash report, check the `Code Type` and `OS Version` section. Such as:`Code Type:       ARM-64`
`OS Version:      iOS 10.2 (14C82)`. That means you need `arm64`version symbols of `10.2 (14C82)`system.

2. Find the package in my sharing folder and extract it to `~/Library/Developer/Xcode/iOS DeviceSupport`. (Check the file's name and path, it should be`~/Library/Developer/Xcode/iOS DeviceSupport/10.2 (14C82)/Symbols`).

3. Use Xcode's`symbolicatecrash` tool to symbolicate your crash report. This tool will search system symbols in the`iOS DeviceSupport`path automatically. Read this to learn how to use`symbolicatecrash`: [How to symbolicate crashes in Xcode 7.3?](http://stackoverflow.com/questions/36189121/how-to-symbolicate-crashes-in-xcode-7-3).

##Missing symbols

I still miss some CPU's symbols, if you have any of them, please share.

The missing list is in [collected-symbol-files.md](https://github.com/Zuikyo/iOS-System-Symbols/blob/master/collected-symbol-files.md)

## How to share your symbol files

### 1.Check which CPU version the symbol file contains

If you already have a system symbol file, and want to know which CPU version it contains, check files in the path like`10.2 (14C92)/Symbols/System/Library/Caches/com.apple.dyld`. There should be files named`dyld_shared_cache_arm64`,`dyld_shared_cache_armv7s`,`dyld_shared_cache_armv7`.

If you miss one, that means you don't have that CPU version's symbols.

### 2.Merge the symbol files

If you have a device in the missing list, you may need to merge it's symbol files before sharing.

Xcode merges different CPU's symbol files to same folder. For example, if you already have a `arm64` version's symbol file in `iOS DeviceSupport` folder (such as `10.2 (14C82)`), when you connect a`armv7`device, Xcode will merge `armv7` version symbol files to `10.2 (14C82)` folder too.

So you need to download other CPU version's symbol files in my sharing folder(if it exists), extract it to `~/Library/Developer/Xcode/iOS DeviceSupport`. Then connect your device, let Xcode merge those symbol files. 

Then we get a file containing `arm64`,`armv7s`and`armv7`. If you don't merge them, we'll have to distinguish the corresponding CPU version's symbol file when 
symbolicating.

### 3.Upload and share

Upload your files to your sharing drive, and commit the download address to [collected-symbol-files.md](https://github.com/Zuikyo/iOS-System-Symbols/blob/master/collected-symbol-files.md).

---

这个项目的目的是分享iOS系统库符号文件，对iOS crash日志分析有很大帮助。

具体内容，请看[iOS Crash分析必备：获取系统库符号文件](http://www.jianshu.com/p/f9eeeecff8d8)。