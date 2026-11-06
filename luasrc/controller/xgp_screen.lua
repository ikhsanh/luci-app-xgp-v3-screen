module("luci.controller.xgp_screen", package.seeall)

function index()
	entry({"admin", "system", "xgp_screen"}, cbi("xgp_screen"), _("Screen Control"), 60)
end

