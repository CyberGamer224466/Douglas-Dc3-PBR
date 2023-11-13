###############################################################################
##  Nasal for dual control of the Douglas DC3-C47 over the multiplayer network.
##
##  Copyright (C) 2007 - 2008  Anders Gidenstam  (anders(at)gidenstam.org)
##  This file is licensed under the GPL license version 2 or later.
##
##  Modified by Clément de l'Hamaide for Douglas DC3-C47 - 13/08/2011
##
###############################################################################

## Renaming (almost :)
var DCT = dual_control_tools;

## Pilot/copilot aircraft identifiers. Used by dual_control.
var pilot_type   = "Aircraft/Douglas-Dc3/Models/dc-3.xml";
var copilot_type = "Aircraft/Douglas-Dc3/Models/dc-3-psg1.xml";

############################ PROPERTIES MP ###########################

#####
# pilot properties
##
var flaps           = "sim/multiplay/generic/float[3]";
var elevator_trim   = "sim/multiplay/generic/float[4]";
var rudder          = "sim/multiplay/generic/float[5]";
var elevator        = "sim/multiplay/generic/float[6]";
var aileron         = "sim/multiplay/generic/float[7]";
var throttle        = ["sim/multiplay/generic/float[8]", "sim/multiplay/generic/float[9]"];
var mixture         = ["sim/multiplay/generic/float[10]", "sim/multiplay/generic/float[11]"];
var propeller       = ["sim/multiplay/generic/float[12]", "sim/multiplay/generic/float[13]"];
var rpm             = ["engines/engine[0]/rpm", "engines/engine[1]/rpm"];
var brake           = ["sim/multiplay/generic/float[14]", "sim/multiplay/generic/float[15]"];
var gear            = "sim/multiplay/generic/float[16]";
var switch_mpp      = "sim/multiplay/generic/int[0]";
var TDM_mpp         = "sim/multiplay/generic/string[0]";

######################################################################
# Useful instrument related property paths.

# Flight controls
var rudder_cmd        = "controls/flight/rudder";
var elevator_cmd      = "controls/flight/elevator";
var aileron_cmd       = "controls/flight/aileron";
var elevator_trim_cmd = "controls/flight/elevator-trim";
var flaps_cmd         = "controls/flight/flaps";
var throttle_cmd      = ["controls/engines/engine[0]/throttle", "controls/engines/engine[1]/throttle"];
var mixture_cmd       = ["controls/engines/engine[0]/mixture", "controls/engines/engine[1]/mixture"];
var propeller_cmd     = ["controls/engines/engine[0]/propeller-pitch", "controls/engines/engine[1]/propeller-pitch"];
var magnetos_cmd      = ["controls/engines/engine[0]/magnetos", "controls/engines/engine[1]/magnetos"];
var rpm_cmd           = ["engines/engine[0]/rpm", "engines/engine[1]/rpm"];
var brake_cmd         = ["controls/gear/brake-left", "controls/gear/brake-right"];
var gear_cmd          = "controls/gear/gear-down";

# Switch controls
var battery_switch          = "controls/electric/battery-switch";
var starter_switch          = ["controls/engines/engine[0]/starter", "controls/engines/engine[1]/starter"];
var light_instrument_switch = "controls/lighting/instrument-lights";

# Boolean properties
var running        = ["engines/engine[0]/running", "engines/engine[1]/running"];
var cranking       = ["engines/engine[0]/cranking", "engines/engine[1]/cranking"];
#var gear_pos          = "gear/gear[0]/position-norm";
var brake_parking  = "controls/gear/brake-parking";

var l_dual_control    = "dual-control/active";

######################################################################
###### Used by dual_control to set up the mappings for the pilot #####
######################## PILOT TO COPILOT ############################
######################################################################

var pilot_connect_copilot = func (copilot) {
  # Make sure dual-control is activated in the FDM FCS.
  setprop(l_dual_control, 1);
  return [];
}

##############
var pilot_disconnect_copilot = func {
  setprop(l_dual_control, 0);
}


######################################################################
##### Used by dual_control to set up the mappings for the copilot ####
######################## COPILOT TO PILOT ############################
######################################################################

var copilot_connect_pilot = func (pilot) {
  # Make sure dual-control is activated in the FDM FCS.
  setprop(l_dual_control, 1);
  pilot.getNode("sim/model/config/version", 1).setValue("civilian-red");
  return [
    ##################################################
    # Map copilot flight controls to MP properties.
      # Map /controls/flight/*
      DCT.Translator.new
        (pilot.getNode(rudder),
	 pilot.getNode(rudder_cmd)),
      DCT.Translator.new
        (pilot.getNode(aileron),
	 pilot.getNode(aileron_cmd)),
      DCT.Translator.new
        (pilot.getNode(elevator),
	 pilot.getNode(elevator_cmd)),
      DCT.Translator.new
        (pilot.getNode(throttle[0]),
	 pilot.getNode(throttle_cmd[0])),
      DCT.Translator.new
        (pilot.getNode(throttle[1]),
	 pilot.getNode(throttle_cmd[1])),
      DCT.Translator.new
        (pilot.getNode(mixture[0]),
	 pilot.getNode(mixture_cmd[0])),
      DCT.Translator.new
        (pilot.getNode(mixture[1]),
	 pilot.getNode(mixture_cmd[1])),
      DCT.Translator.new
        (pilot.getNode(propeller[0]),
	 pilot.getNode(propeller_cmd[0])),
      DCT.Translator.new
        (pilot.getNode(propeller[1]),
	 pilot.getNode(propeller_cmd[1])),
      DCT.Translator.new
        (pilot.getNode(rpm[0]),
	 props.globals.getNode(rpm_cmd[0])),
      DCT.Translator.new
        (pilot.getNode(rpm[1]),
	 props.globals.getNode(rpm_cmd[1])),
      DCT.Translator.new
        (pilot.getNode(flaps),
	 props.globals.getNode("surface-positions/flap-pos-norm")),
      DCT.Translator.new
        (pilot.getNode(gear),
	 props.globals.getNode("gear/gear[0]/position-norm")),
      DCT.MostRecentSelector.new
        (props.globals.getNode("dual-control/pilot/"~flaps_cmd), props.globals.getNode(flaps_cmd), props.globals.getNode(flaps_cmd), 0.1),
      DCT.MostRecentSelector.new
        (props.globals.getNode("dual-control/pilot/"~magnetos_cmd[0]), props.globals.getNode(magnetos_cmd[0]), props.globals.getNode(magnetos_cmd[0]), 0.1),
      DCT.MostRecentSelector.new
        (props.globals.getNode("dual-control/pilot/"~magnetos_cmd[1]), props.globals.getNode(magnetos_cmd[1]), props.globals.getNode(magnetos_cmd[1]), 0.1),

      DCT.Translator.new(props.globals.getNode("sim/model/config/details-high"), pilot.getNode("sim/model/config/details-high")),
      DCT.Translator.new(props.globals.getNode("sim/model/config/version"), pilot.getNode("sim/model/config/version")),
      DCT.Translator.new(props.globals.getNode("sim/model/config/show-pilot"), pilot.getNode("sim/model/config/show-pilot")),
      DCT.Translator.new(props.globals.getNode("sim/model/config/show-copilot"), pilot.getNode("sim/model/config/show-copilot")),
      DCT.Translator.new(props.globals.getNode("sim/model/config/show-yokes"), pilot.getNode("sim/model/config/show-yokes")),
      DCT.Translator.new(props.globals.getNode("sim/model/config/glass-reflection"), pilot.getNode("sim/model/config/glass-reflection")),
      DCT.Translator.new(props.globals.getNode("sim/model/config/light-cone"), pilot.getNode("sim/model/config/light-cone")),
  ];
}

var copilot_disconnect_pilot = func {
  setprop(l_dual_control, 0);
}
