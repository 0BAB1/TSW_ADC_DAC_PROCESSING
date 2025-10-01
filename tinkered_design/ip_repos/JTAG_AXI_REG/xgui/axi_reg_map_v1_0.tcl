# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  ipgui::add_param $IPINST -name "REG_1_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_2_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_3_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_4_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_5_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_6_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_7_CTRL_DEFAULT"
  ipgui::add_param $IPINST -name "REG_8_CTRL_DEFAULT"

}

proc update_PARAM_VALUE.REG_1_CTRL_DEFAULT { PARAM_VALUE.REG_1_CTRL_DEFAULT } {
	# Procedure called to update REG_1_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_1_CTRL_DEFAULT { PARAM_VALUE.REG_1_CTRL_DEFAULT } {
	# Procedure called to validate REG_1_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_2_CTRL_DEFAULT { PARAM_VALUE.REG_2_CTRL_DEFAULT } {
	# Procedure called to update REG_2_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_2_CTRL_DEFAULT { PARAM_VALUE.REG_2_CTRL_DEFAULT } {
	# Procedure called to validate REG_2_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_3_CTRL_DEFAULT { PARAM_VALUE.REG_3_CTRL_DEFAULT } {
	# Procedure called to update REG_3_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_3_CTRL_DEFAULT { PARAM_VALUE.REG_3_CTRL_DEFAULT } {
	# Procedure called to validate REG_3_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_4_CTRL_DEFAULT { PARAM_VALUE.REG_4_CTRL_DEFAULT } {
	# Procedure called to update REG_4_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_4_CTRL_DEFAULT { PARAM_VALUE.REG_4_CTRL_DEFAULT } {
	# Procedure called to validate REG_4_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_5_CTRL_DEFAULT { PARAM_VALUE.REG_5_CTRL_DEFAULT } {
	# Procedure called to update REG_5_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_5_CTRL_DEFAULT { PARAM_VALUE.REG_5_CTRL_DEFAULT } {
	# Procedure called to validate REG_5_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_6_CTRL_DEFAULT { PARAM_VALUE.REG_6_CTRL_DEFAULT } {
	# Procedure called to update REG_6_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_6_CTRL_DEFAULT { PARAM_VALUE.REG_6_CTRL_DEFAULT } {
	# Procedure called to validate REG_6_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_7_CTRL_DEFAULT { PARAM_VALUE.REG_7_CTRL_DEFAULT } {
	# Procedure called to update REG_7_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_7_CTRL_DEFAULT { PARAM_VALUE.REG_7_CTRL_DEFAULT } {
	# Procedure called to validate REG_7_CTRL_DEFAULT
	return true
}

proc update_PARAM_VALUE.REG_8_CTRL_DEFAULT { PARAM_VALUE.REG_8_CTRL_DEFAULT } {
	# Procedure called to update REG_8_CTRL_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_8_CTRL_DEFAULT { PARAM_VALUE.REG_8_CTRL_DEFAULT } {
	# Procedure called to validate REG_8_CTRL_DEFAULT
	return true
}


proc update_MODELPARAM_VALUE.REG_1_CTRL_DEFAULT { MODELPARAM_VALUE.REG_1_CTRL_DEFAULT PARAM_VALUE.REG_1_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_1_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_1_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_2_CTRL_DEFAULT { MODELPARAM_VALUE.REG_2_CTRL_DEFAULT PARAM_VALUE.REG_2_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_2_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_2_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_3_CTRL_DEFAULT { MODELPARAM_VALUE.REG_3_CTRL_DEFAULT PARAM_VALUE.REG_3_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_3_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_3_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_4_CTRL_DEFAULT { MODELPARAM_VALUE.REG_4_CTRL_DEFAULT PARAM_VALUE.REG_4_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_4_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_4_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_5_CTRL_DEFAULT { MODELPARAM_VALUE.REG_5_CTRL_DEFAULT PARAM_VALUE.REG_5_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_5_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_5_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_6_CTRL_DEFAULT { MODELPARAM_VALUE.REG_6_CTRL_DEFAULT PARAM_VALUE.REG_6_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_6_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_6_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_7_CTRL_DEFAULT { MODELPARAM_VALUE.REG_7_CTRL_DEFAULT PARAM_VALUE.REG_7_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_7_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_7_CTRL_DEFAULT}
}

proc update_MODELPARAM_VALUE.REG_8_CTRL_DEFAULT { MODELPARAM_VALUE.REG_8_CTRL_DEFAULT PARAM_VALUE.REG_8_CTRL_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_8_CTRL_DEFAULT}] ${MODELPARAM_VALUE.REG_8_CTRL_DEFAULT}
}

