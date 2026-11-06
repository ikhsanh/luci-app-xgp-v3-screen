local m, s, o

m = Map("xgp_screen", translate("XiGuaPi V3 Screen Control"),
	translate("Manage LCD screen power, brightness, interval cycling, and operating schedules for XiGuaPi V3."))

s = m:section(NamedSection, "config", "xgp_screen", translate("Screen Settings"))
s.anonymous = true
s.addremove = false

-- 1. Master Switch (Enable / Disable)
o = s:option(Flag, "enabled", translate("Enable Screen"))
o.rmempty = false
o.default = "1"
o.description = translate("Master switch to turn the LCD display on or off.")

-- 2. Brightness
o = s:option(Value, "brightness", translate("Brightness"))
o.datatype = "range(0,255)"
o.default = "128"
o.rmempty = false
o.description = translate("Screen brightness level (0 - 255). 0 is completely off, 255 is maximum brightness.")
o:depends("enabled", "1")

-- 3. Display Interval Section
o = s:option(Flag, "interval_enable", translate("Enable Display Interval"))
o.rmempty = false
o.default = "0"
o.description = translate("Cycle the screen on and off at regular intervals (e.g., 10 minutes on, 10 minutes off).")
o:depends("enabled", "1")

o = s:option(Value, "interval_on", translate("Active Duration (Minutes)"))
o.datatype = "uinteger"
o.default = "10"
o.description = translate("Number of minutes the screen stays active/on during each cycle.")
o:depends("interval_enable", "1")

o = s:option(Value, "interval_off", translate("Rest Duration (Minutes)"))
o.datatype = "uinteger"
o.default = "10"
o.description = translate("Number of minutes the screen turns off during each cycle.")
o:depends("interval_enable", "1")

-- 4. Time Schedule Section
o = s:option(Flag, "schedule_enable", translate("Enable Time Schedule"))
o.rmempty = false
o.default = "0"
o.description = translate("Automatically turn on the screen during specific hours and turn it off outside those hours.")
o:depends("enabled", "1")

o = s:option(Value, "schedule_start", translate("Start Time (HH:MM)"))
o.default = "20:00"
o.description = translate("Time to turn screen on in 24-hour format (e.g., 20:00 for 8:00 PM).")
o:depends("schedule_enable", "1")

o = s:option(Value, "schedule_end", translate("End Time (HH:MM)"))
o.default = "23:00"
o.description = translate("Time to turn screen off in 24-hour format (e.g., 23:00 for 11:00 PM). Overnight schedules (e.g. 22:00 to 06:00) are supported.")
o:depends("schedule_enable", "1")

function m.on_after_commit(self)
	luci.sys.call("/etc/init.d/xgp_screen restart >/dev/null 2>&1")
end

return m

