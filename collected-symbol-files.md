## Download

You can download the symbols you need here:

[iOS system symbol files(7.0-9.2)](https://drive.google.com/drive/folders/0B-0LZDbSzubRaUdMdTJQc1ZzMUU?usp=sharing)

[iOS system symbol files(9.2.1-10.3.1)](https://drive.google.com/drive/folders/0B5oBYvBG2NS7aDVTR1JzX2JXaFE?usp=sharing)

[iOS system symbol files(10.3.2-11.1.1)](https://drive.google.com/drive/folders/0B9ItUz-PHtRLb3hidV9kUGJUMkE?usp=sharing)

If you're in China, check here:

Baidu Netdisk: [https://pan.baidu.com/s/1mibhDyg](https://pan.baidu.com/s/1mibhDyg) sharing code: `md1s`

I take those `dyld_shared_cache_xxxx` files in `Symbols/System/Library/Caches/com.apple.dyld` out to reduce the size of the symbol files. They're not necessary for symbolicating. They're only needed when debugging with a real device. If you need them, download those `xxxx-Caches` files.

## Symbols list

There are 67 versions from `7.0 (11A465)` to `11.2 (15C114)`(if you count OS version with CPU architecture, it's 151).

Here is the list of symbols from `7.0`to`11.2`, with their CPU architecture version I've got.

I will update the list if i get new symbol files.

Collected OS Version|Collected CPU Version|Description
-------------------|------------------|---------------
11.2 (15C114)|arm64|
**11.2 (15C113)**|**none**|iPhone X only
11.1.2 (15B202)|arm64|
11.1.1 (15B150)|arm64|
**11.1 (15B101)**|**none**|iPad Pro2 12.9-inch and iPad Pro 10.5-inch only
11.1 (15B93)|arm64|
11.0.3 (15A432)|arm64|
11.0.2 (15A421)|arm64|
11.0.1 (15A403)|arm64|iPhone 8 and 8 Plus only
11.0.1 (15A402)|arm64|
11.0 (15A372)|arm64|
10.3.3 (14G60)|arm64,armv7s|
10.3.2 (14F91)|arm64,armv7s|iPad mini4(Cellular) only
10.3.2 (14F90)|arm64,armv7s|iPad (5th gen) only
10.3.2 (14F89)|arm64,armv7s|
10.3.1 (14E304)|arm64,armv7s|
10.3 (14E277)|arm64,armv7s|
10.2.1 (14D27)|arm64,armv7s|
10.2 (14C92)|arm64,armv7s|
10.1.1 (14B150)|arm64,armv7s|
10.1.1 (14B100)|arm64,armv7s|
10.1 (14B72c)|arm64,armv7s|
10.1 (14B72)|arm64,armv7s|
10.0.3 (14A551)|arm64,armv7s|
10.0.2 (14A456)|arm64,armv7s|
10.0.1 (14A403)|arm64,armv7s|
**10.0 (14A346)**|**none**|iPhone 7 and 7 Plus only, default OS when leave factory
9.3.5 (13G36)|arm64,armv7s,armv7|
9.3.4 (13G35)|arm64,armv7s,armv7|
9.3.3 (13G34)|arm64,armv7s,armv7|
9.3.2 (13F72)|arm64,armv7s|iPad Pro 9.7-inch only, fix bricked problem
9.3.2 (13F69)|arm64,armv7s,armv7|
9.3.1 (13E238)|arm64,armv7s,armv7|
9.3 (13E237)|armv7s,armv7|5s and older devices only, fix activation problem
9.3 (13E236)|armv7|iPad2-only, fix activation problem
9.3 (13E234)|arm64,armv7s|6s, 6s Plus and iPad Pro 9.7-inch only
9.3 (13E233)|arm64,armv7s,armv7|
9.2.1 (13D20)|arm64,armv7s|iPhone 6 and newer devices only
9.2.1 (13D15)|arm64,armv7s,armv7|
9.2 (13C75)|arm64,armv7s,armv7|
9.1 (13B143)|arm64,armv7s,armv7|
9.0.2 (13A452)|arm64,armv7s,armv7|
9.0.1 (13A404)|arm64,armv7s,armv7|
9.0 (13A344)|arm64,armv7s,armv7|
8.4.1 (12H321)|arm64,armv7s,armv7|
8.4 (12H143)|arm64,armv7s,armv7|
8.3 (12F70)|arm64,armv7s,armv7|iPhone only
8.3 (12F69)|arm64,armv7s,armv7|iPad only
8.2 (12D508)|arm64,armv7s,armv7|
8.1.3 (12B466)|arm64,armv7s,armv7|
8.1.2 (12B440)|arm64,armv7s,armv7|
8.1.1 (12B436)|arm64,armv7s|iPhone 6 and newer devices only
8.1.1 (12B435)|arm64,armv7s,armv7|5s and older devices only
8.1 (12B411)|arm64,armv7s,armv7|iPhone only
8.1 (12B410)|arm64,armv7s,armv7|iPad only
8.0.2 (12A405)|arm64,armv7s,armv7|
8.0.1 (12A402)|armv7s,armv7|`8.0.1`was pulled back soon after released.Because it has serious bugs
8.0 (12A366)|arm64,armv7s|6 Plus only
8.0 (12A365)|armv7s,armv7|
7.1.2 (11D257)|armv7s,armv7|
7.1.1 (11D201)|arm64,armv7s,armv7|
7.1 (11D167)|arm64,armv7s,armv7|
7.0.6 (11B651)|arm64,armv7s,armv7|
7.0.4 (11B554a)|arm64,armv7s,armv7|
7.0.3 (11B511)|arm64,armv7s,armv7|
7.0.2 (11A501)|armv7s,armv7|
7.0.1 (11A470a)|armv7s|5s and 5c only
7.0 (11A465)|arm64,armv7s,armv7|

## Missing Symbols

If you want to share a missing symbols, just move the OS version and CPU version you added in this missing list to collected symbols list above, and append download address in `description` section.

Missing OS Version|Missing CPU Version|Description
----------------|-------------------|----------------
11.2 (15C113)|arm64|iPhone X only
11.1 (15B101)|arm64|iPad Pro2 12.9-inch and iPad Pro 10.5-inch only
10.0 (14A346)|arm64|iPhone 7 and 7 Plus only, default OS when leave factory
9.3 (13E237)|arm64|5s, iPad Air and iPad mini2 only, fix activation problem
8.0.1 (12A402)|arm64|`8.0.1`was pulled back soon after released. Because it has serious bugs. So we can ignore this version actually.
8.0 (12A365)|arm64|
7.1.2 (11D257)|arm64|
7.0.2 (11A501)|arm64|
7.0.1 (11A470a)|arm64|5s only

## CPU Architecture with Devices

CPU|Devices
------|------
armv6|iPhone, iPhone2, iPhone3G, iPod Touch 1 and 2
armv7|iPhone3GS, iPhone4, iPhone4S，iPad, iPad2, iPad3(The New iPad), iPad mini，iPod Touch 3G, iPod Touch4, iPod Touch5
armv7s|iPhone5, iPhone5C, iPad4(iPad with Retina Display)
arm64|iPhone5s, iPad Air, iPad mini2(iPad mini with Retina Display), iPhone6 (Plus), iPhone6s (Plus), iPhone7 (Plus), iPad (5th gen), iPhone 8 (Plus), iPhone X and any new device in the future
