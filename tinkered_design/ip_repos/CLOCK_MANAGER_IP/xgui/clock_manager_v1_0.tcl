# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "FAN_OUT_SW_RST_RIUCLK_N" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FAN_OUT_SW_RST_RIUCLK" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FAN_OUT_SW_RST_APPCLK_N" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FAN_OUT_SW_RST_APPCLK" -parent ${Page_0}


}

proc update_PARAM_VALUE.FAN_OUT_SW_RST_APPCLK { PARAM_VALUE.FAN_OUT_SW_RST_APPCLK } {
	# Procedure called to update FAN_OUT_SW_RST_APPCLK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FAN_OUT_SW_RST_APPCLK { PARAM_VALUE.FAN_OUT_SW_RST_APPCLK } {
	# Procedure called to validate FAN_OUT_SW_RST_APPCLK
	return true
}

proc update_PARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N { PARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N } {
	# Procedure called to update FAN_OUT_SW_RST_APPCLK_N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N { PARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N } {
	# Procedure called to validate FAN_OUT_SW_RST_APPCLK_N
	return true
}

proc update_PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK { PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK } {
	# Procedure called to update FAN_OUT_SW_RST_RIUCLK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK { PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK } {
	# Procedure called to validate FAN_OUT_SW_RST_RIUCLK
	return true
}

proc update_PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N { PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N } {
	# Procedure called to update FAN_OUT_SW_RST_RIUCLK_N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N { PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N } {
	# Procedure called to validate FAN_OUT_SW_RST_RIUCLK_N
	return true
}


proc update_MODELPARAM_VALUE.FAN_OUT_SW_RST_APPCLK { MODELPARAM_VALUE.FAN_OUT_SW_RST_APPCLK PARAM_VALUE.FAN_OUT_SW_RST_APPCLK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FAN_OUT_SW_RST_APPCLK}] ${MODELPARAM_VALUE.FAN_OUT_SW_RST_APPCLK}
}

proc update_MODELPARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N { MODELPARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N PARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N}] ${MODELPARAM_VALUE.FAN_OUT_SW_RST_APPCLK_N}
}

proc update_MODELPARAM_VALUE.FAN_OUT_SW_RST_RIUCLK { MODELPARAM_VALUE.FAN_OUT_SW_RST_RIUCLK PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK}] ${MODELPARAM_VALUE.FAN_OUT_SW_RST_RIUCLK}
}

proc update_MODELPARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N { MODELPARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N}] ${MODELPARAM_VALUE.FAN_OUT_SW_RST_RIUCLK_N}
}

