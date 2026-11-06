# luci-app-xgp-v3-screen

OpenWrt LuCI web management interface for the **NLnet XiGuaPi V3** TFT LCD screen.

This package works in tandem with [`xgp-v3-screen`](https://github.com/ikhsanh/xgp-v3-screen) to provide power management, brightness adjustment, interval cycling, and operating schedules.

---

## Prerequisites & Dependencies

> [!IMPORTANT]
> This LuCI management application **requires** the core screen driver & rendering package:
> * **[xgp-v3-screen](https://github.com/ikhsanh/xgp-v3-screen)** (Required)
> 
> `luci-app-xgp-v3-screen` acts as the frontend control layer (managing backlight power, intervals, and schedules), while `xgp-v3-screen` is the backend program that renders the LVGL UI to the LCD framebuffer. Both packages must be installed together.

---

## Features

1. **Screen Master Switch**:
   - Turn the LCD screen display completely ON or OFF from the LuCI web interface.
   - When disabled, turns off the backlight and pauses the rendering service to save power.

2. **Brightness Control (0 - 255)**:
   - Adjust screen backlight brightness smoothly between `0` (dark/off) and `255` (maximum brightness).

3. **Display Interval (Interval On/Off Cycling)**:
   - Configurable display cycle to prevent panel fatigue and save energy (similar to OLED display interval).
   - Keeps the screen active for **XX minutes** (e.g. 10 minutes), then rests for **YY minutes** (e.g. 10 minutes), looping continuously.

4. **Time Schedule (Autoswitch)**:
   - Automatically turn the screen on during designated operating hours (e.g. 20:00 to 23:00) and keep it off outside those hours.
   - Supports overnight schedules (e.g. 22:00 to 06:00).

---

## Installation & Build

Add both packages to your OpenWrt SDK `package/` folder:

```bash
cd openwrt
git clone https://github.com/ikhsanh/xgp-v3-screen.git package/xgp-v3-screen
git clone https://github.com/ikhsanh/luci-app-xgp-v3-screen.git package/luci-app-xgp-v3-screen
```

Select both packages in `menuconfig`:
```bash
make menuconfig
# Utilities --->
#   <*> xgp-v3-screen
# LuCI --->
#   3. Applications --->
#     <*> luci-app-xgp-v3-screen
```

Compile:
```bash
make package/xgp-v3-screen/compile V=s
make package/luci-app-xgp-v3-screen/compile V=s
```

---

## Credits & Upstream Source

This project is extended and enhanced based on the original `luci-app-xgp-v3-screen-brightness` package by **zzzz0317**:
* **Core Screen Rendering Package**: [ikhsanh/xgp-v3-screen](https://github.com/ikhsanh/xgp-v3-screen)
* **Original LuCI Source**: [zzzz0317/immortalwrt-xgp-auto-build (luci-app-xgp-v3-screen-brightness)](https://github.com/zzzz0317/immortalwrt-xgp-auto-build/tree/main/zz-packages/luci-app-xgp-v3-screen-brightness)
* **Interval Feature Reference**: [NateLol/luci-app-oled](https://github.com/NateLol/luci-app-oled)
