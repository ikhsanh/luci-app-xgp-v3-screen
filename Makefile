include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-xgp-v3-screen
PKG_VERSION:=1.2
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=zzzz0317

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-xgp-v3-screen
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=XiGuaPi V3 Screen Control
  DEPENDS:=+luci-base +xgp-v3-screen
  PKGARCH:=all
  PROVIDES:=luci-app-xgp-v3-screen-brightness
endef

define Package/luci-app-xgp-v3-screen/description
  OpenWrt LuCI app to manage LCD screen power, brightness, interval cycling, and operating schedules for XiGuaPi V3.
endef

define Build/Compile
endef

define Package/luci-app-xgp-v3-screen/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/xgp_screen.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./luasrc/model/cbi/xgp_screen.lua $(1)/usr/lib/lua/luci/model/cbi/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/xgp_screen $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/xgp_screen $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/xgp-screen-ctrl $(1)/usr/bin/
	$(INSTALL_BIN) ./root/usr/bin/xgp-screen-daemon $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/bin
	ln -sf /usr/bin/xgp-screen-ctrl $(1)/bin/set-xgp-screen-brightness
endef

define Package/luci-app-xgp-v3-screen/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	/etc/init.d/xgp_screen enable
	/etc/init.d/xgp_screen restart
}
exit 0
endef

define Package/luci-app-xgp-v3-screen/prerm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	/etc/init.d/xgp_screen stop
	/etc/init.d/xgp_screen disable
}
exit 0
endef

$(eval $(call BuildPackage,luci-app-xgp-v3-screen))
