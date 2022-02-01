# iOS-System-Symbols
Share iOS system symbol files copied from `iOS DeviceSupport` folder. Useful for symbolicating iOS crash reports.

The download address is in [collected-symbol-files.md](https://github.com/Zuikyo/iOS-System-Symbols/blob/master/collected-symbol-files.md).

When I get new symbol file, i will add it into the google drive sharing folder, and update the [collected-symbol-files.md](https://github.com/Zuikyo/iOS-System-Symbols/blob/master/collected-symbol-files.md). You can follow this repository to get the latest update.

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

The callstack didn't catch your app's code, it only has code from system frameworks. So you need to symbolicate these system code.

Here is the symbolicated report, those`<redacted>` were changed into specific method names:

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

## The problem of symbolicating system frameworks

You may find out that you can't always symbolicate those system code. There're several problems:

* If you want to symbolicate system frameworks in your crash report, you need the corresponding system symbols, matching the OS Version and CPU architecture.
* Most system symbols can only be got from physical iOS devices. Apple never  offer a website to download these symbols.
* You can download old versions of Xcode and pull out the SDK image you need. Usually the symbols are part of the latest Xcode release, but Apple doesn't always provide Xcode updates when an iOS version only contains bug-fixes but no API changes. And since Apple replace system framework with `tbd` files after Xcode7, this trick doesn't work any more. Read this for more details: [Xcode software image for user iOS in order to symbolicate iOS calls](http://stackoverflow.com/questions/14941773/xcode-software-image-for-user-ios-in-order-to-symbolicate-ios-calls), [Missing iOS symbols at “~/Library/Developer/Xcode/iOS DeviceSupport”](http://stackoverflow.com/a/28408052/6380485). (**Update**: Actually, since Xcode 6, there is no real device SDK. So you can only get SDKs before iOS 7 from Xcode.)

When you first connect a new iOS device to Xcode, Xcode will show a loading message: `Processing symbol files`(after Xcode 9, it's `Preparing debugger support for Device`). It's copying system symbol files from device to your Mac's path: `~/Library/Developer/Xcode/iOS DeviceSupport`.

That means you need a corresponding device if you want to symbolicate a crash report. There are 132 versions from `7.0 (11A465)` to `10.2.1 (14D27)`(most OS version contains three different type:`arm64`,`armv7s`,`armv7`. A`arm64`device contains both`arm64`and`armv7s`). That's obviously very difficult to collect them all.

That's the meaning of this repository, to share these system symbols.

**update**: Since iOS 10, iOS firmware are not encrypted, so we can get symbols from firmware now.

## How to use

1. When you need to symbolicate a crash report, check the `Code Type` and `OS Version` section. Such as:`Code Type:       ARM-64`
`OS Version:      iOS 10.2 (14C82)`. That means you need `arm64`version symbols of `10.2 (14C82)`system.

2. Find the package in my sharing folder and extract it to `~/Library/Developer/Xcode/iOS DeviceSupport`. (Check the file's name and path, it should be`~/Library/Developer/Xcode/iOS DeviceSupport/10.2 (14C82)/Symbols`).

3. Use Xcode's`symbolicatecrash` tool to symbolicate your crash report. This tool will search system symbols in the`iOS DeviceSupport`path automatically. Read this to learn how to use`symbolicatecrash`: [Symbolicating an iOS Crash Report](https://www.apteligent.com/developer-resources/symbolicating-an-ios-crash-report/?partner_code=GDC_so_symbolicateios).

## Extract Symbols from Firmware

If the symbols you need is not in the list, you can get from firmware by yourself.

We can almost get all systems' symbols from firmwares now. And after iOS 10, firmwares are not encrypted any more. You can also get symbols of beta firmwares.

How to extract symbols from firmware:

1. Download the ipsw firmware (not OTA files), corresponding the system version you need
2. Uncompress the firmware file as zip, find the biggest dmg file(it's the iOS system file image)
3. If the version of the firmare system is higher than iOS 10, the dmg is not encrypted. So just double click to load the image, and go to step `6`
4. If the version is lower than iOS 10, you have to decrypt the dmg file with corresponding firmware key. Find key in [Firmware_Keys](https://www.theiphonewiki.com/wiki/Firmware_Keys)(Under`Root Filesystem`section in the corresponding firmware page)
5. Decrypt dmg file with its key. You can use the `dmg`tool in [tools](https://github.com/Zuikyo/iOS-System-Symbols/tree/master/tools):`./dmg extract encrypted.dmg decrypted.dmg -k <firmware_key>`. Then you get the `decrypted.dmg`, double click to load the image
6. In the image folder, go to `System/Library/Caches/com.apple.dyld/`, you can get `dyld_shared_cache_arm64`, `dyld_shared_cache_armv7s`,`dyld_shared_cache_armv7`, they are the compressed system frameworks
7. Uncompress `dyld_shared_cache_armxxx` with `dsc_extractor` tool in Apple's dyld project. I put it in [tools](https://github.com/Zuikyo/iOS-System-Symbols/tree/master/tools):`./dsc_extractor ./dyld_shared_cache_armxxx ./output`
8. If you need all arm64, armv7s and armv7 of frameworks, you need to extract `dyld_shared_cache_arm64`, `dyld_shared_cache_armv7s`,`dyld_shared_cache_armv7`all. Before Xcode 11, `dsc_extractor`will merge different architectures into same files when extracting to a same directory
9. ~~After Xcode 11 for iOS 13.2, `dsc_extractor` won't merge different architectures files. We need to merge symbols with `lipo` command. Try [merge_symbols.sh](https://github.com/Zuikyo/iOS-System-Symbols/tree/master/tools/merge_symbols.sh) : ` sh merge_symbols.sh <path_to_extracted_arm64e_symbols> <path_to_extracted_arm64_symbols>`~~ Since iOS 11 doesn't support armv7 any more, we only care about arm64 and arm64e. For arm64e symbols, just add arm64e suffix in the directory name. `13.3.1 (17D50) arm64e` for arm64e, and `13.3.1 (17D50)` for arm64.
10. Then you get all system frameworks of this firmware in output folder. Put those files into a folder as a symbol file hierarchy, such as `12.0 (16A5288q)/Symbols/`, and you can use this folder to symbolicate crash report now

## Thank you for reading. If this project is helpful, please give me a star :)

---

### My Other Framework

I'd like to introduce [ZIKRouter](https://github.com/Zuikyo/ZIKRouter), a iOS dependency injection framework. ZIKRouter helps your app split into loosely-coupled components. you can see how to perfectly decouple your modules in the demo.
