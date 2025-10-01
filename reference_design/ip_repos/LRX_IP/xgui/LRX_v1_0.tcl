# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"

}

proc update_PARAM_VALUE.ADC_RESOLUTION { PARAM_VALUE.ADC_RESOLUTION } {
	# Procedure called to update ADC_RESOLUTION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADC_RESOLUTION { PARAM_VALUE.ADC_RESOLUTION } {
	# Procedure called to validate ADC_RESOLUTION
	return true
}

proc update_PARAM_VALUE.STROBE_PAT1 { PARAM_VALUE.STROBE_PAT1 } {
	# Procedure called to update STROBE_PAT1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STROBE_PAT1 { PARAM_VALUE.STROBE_PAT1 } {
	# Procedure called to validate STROBE_PAT1
	return true
}

proc update_PARAM_VALUE.STROBE_PAT2 { PARAM_VALUE.STROBE_PAT2 } {
	# Procedure called to update STROBE_PAT2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STROBE_PAT2 { PARAM_VALUE.STROBE_PAT2 } {
	# Procedure called to validate STROBE_PAT2
	return true
}

proc update_PARAM_VALUE.SW_RST_APP_FANOUT { PARAM_VALUE.SW_RST_APP_FANOUT } {
	# Procedure called to update SW_RST_APP_FANOUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SW_RST_APP_FANOUT { PARAM_VALUE.SW_RST_APP_FANOUT } {
	# Procedure called to validate SW_RST_APP_FANOUT
	return true
}

proc update_PARAM_VALUE.SW_RST_RIU_FANOUT { PARAM_VALUE.SW_RST_RIU_FANOUT } {
	# Procedure called to update SW_RST_RIU_FANOUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SW_RST_RIU_FANOUT { PARAM_VALUE.SW_RST_RIU_FANOUT } {
	# Procedure called to validate SW_RST_RIU_FANOUT
	return true
}


proc update_MODELPARAM_VALUE.SW_RST_RIU_FANOUT { MODELPARAM_VALUE.SW_RST_RIU_FANOUT PARAM_VALUE.SW_RST_RIU_FANOUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SW_RST_RIU_FANOUT}] ${MODELPARAM_VALUE.SW_RST_RIU_FANOUT}
}

proc update_MODELPARAM_VALUE.STROBE_PAT1 { MODELPARAM_VALUE.STROBE_PAT1 PARAM_VALUE.STROBE_PAT1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STROBE_PAT1}] ${MODELPARAM_VALUE.STROBE_PAT1}
}

proc update_MODELPARAM_VALUE.STROBE_PAT2 { MODELPARAM_VALUE.STROBE_PAT2 PARAM_VALUE.STROBE_PAT2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STROBE_PAT2}] ${MODELPARAM_VALUE.STROBE_PAT2}
}

proc update_MODELPARAM_VALUE.SW_RST_APP_FANOUT { MODELPARAM_VALUE.SW_RST_APP_FANOUT PARAM_VALUE.SW_RST_APP_FANOUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SW_RST_APP_FANOUT}] ${MODELPARAM_VALUE.SW_RST_APP_FANOUT}
}

proc update_MODELPARAM_VALUE.ADC_RESOLUTION { MODELPARAM_VALUE.ADC_RESOLUTION PARAM_VALUE.ADC_RESOLUTION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADC_RESOLUTION}] ${MODELPARAM_VALUE.ADC_RESOLUTION}
}

