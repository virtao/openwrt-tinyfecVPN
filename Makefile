#
# Copyright (c) 2017 Virtao <virtao.org@gmail.com>
#
# This is free software, licensed under the MIT.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tinyfecVPN
PKG_VERSION:=20180228.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/wangyu-/tinyfecVPN.git
PKG_SOURCE_VERSION:=8a4fed34102b1018047069f75105648c01bc306b
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Virtao

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tinyfecVPN
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A Lightweight VPN with Build-in Forward Error Correction Support(or A Network Improving Tool which works at VPN mode). Improves your Network Quality on a High-latency Lossy Link.
	URL:=https://github.com/wangyu-/tinyfecVPN
	DEPENDS:= +libstdcpp +librt
endef

define Package/tinyfecVPN/description
	A Lightweight VPN with Build-in Forward Error Correction Support(or A Network Improving Tool which works at VPN mode). Improves your Network Quality on a High-latency Lossy Link.
endef

MAKE_FLAGS += nolimit_cross

define Build/Configure
	$(call Build/Configure/Default)
	$(SED) 's/cc_cross[[:space:]]*=.*/cc_cross=$(TARGET_CXX)/' \
		-e 's/\\".*shell git rev-parse HEAD.*\\"/\\"$(PKG_SOURCE_VERSION)\\"/' \
		$(PKG_BUILD_DIR)/makefile
endef

define Package/tinyfecVPN/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tinyvpn_cross $(1)/usr/bin/tfvpn
endef

$(eval $(call BuildPackage,tinyfecVPN))
