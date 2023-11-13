##########################################################
#      DE L'HAMAIDE Clément for Douglas DC-3 C47         #
##########################################################

var EngineState   = ["engines/engine/running", "engines/engine[1]/running"];
var EngineRpm     = ["engines/engine/rpm", "engines/engine[1]/rpm"];
var LandingGear   = "controls/gear/gear-down-cmd";
var GearLock      = "controls/gear/gear-down-lock";
var Flaps         = "controls/flight/flaps-cmd";
var CowlFlaps     = ["controls/engines/engine/cowl-flaps-cmd", "controls/engines/engine[1]/cowl-flaps-cmd"];
var CowlFlapsNorm = ["controls/engines/engine/cowl-flaps-norm", "controls/engines/engine[1]/cowl-flaps-norm"];
var AirSpeedKt    = "velocities/airspeed-kt";
var BrakeCmd      = ["controls/gear/brake-left", "controls/gear/brake-right"];
var Brake         = ["controls/gear/brake-left-apply", "controls/gear/brake-right-apply"];
var Wiper         = ["controls/hydraulic/wiper-left", "controls/hydraulic/wiper-right"];
var as            = 0;
Hydraulic         = {};

var Hydraulic = {
  new : func {
    m                        = { parents : [Hydraulic] };
    m.node                   = props.globals.initNode("systems/hydraulics");
    m.PumpPsi                = m.node.initNode("pump-psi", 0, "DOUBLE");
    m.LandingGearPsi         = m.node.initNode("landing-gear-psi", 950, "DOUBLE");
    m.FlapsUpPsi             = m.node.initNode("flaps-up-psi", 0.0, "DOUBLE");
    m.FlapsDownPsi           = m.node.initNode("flaps-down-psi", 0.0, "DOUBLE");
    m.CowlFlapsLeftOpenPsi   = m.node.initNode("cowl-flaps-left-open-psi", 0.0, "DOUBLE");
    m.CowlFlapsLeftClosePsi  = m.node.initNode("cowl-flaps-left-close-psi", 0.0, "DOUBLE");
    m.CowlFlapsRightOpenPsi  = m.node.initNode("cowl-flaps-right-open-psi", 0.0, "DOUBLE");
    m.CowlFlapsRightClosePsi = m.node.initNode("cowl-flaps-right-close-psi", 0.0, "DOUBLE");
    m.BrakeLeftPsi           = m.node.initNode("brake-left-psi", 0.0, "DOUBLE");
    m.BrakeRightPsi          = m.node.initNode("brake-right-psi", 0.0, "DOUBLE");
    m.WiperLeftPsi           = m.node.initNode("wiper-left-psi", 0.0, "DOUBLE");
    m.WiperRightPsi          = m.node.initNode("wiper-right-psi", 0.0, "DOUBLE");
    return m;
  },

  update : func {

    var HydSystemPsi = me.PumpPsi.getValue();
    var CowlFlapsOpenPsi = ["systems/hydraulics/cowl-flaps-left-open-psi", "systems/hydraulics/cowl-flaps-right-open-psi"];
    var CowlFlapsClosePsi = ["systems/hydraulics/cowl-flaps-left-close-psi", "systems/hydraulics/cowl-flaps-right-close-psi"];

    ########## Engine Pump Pressure ##########
    if(getprop(EngineState[0]) or getprop(EngineState[1])){
      if(getprop(EngineRpm[0]) > 250 or getprop(EngineRpm[1]) > 250){
        me.PumpPsi.setValue(950);
      }else{
        me.PumpPsi.setValue(((getprop(EngineRpm[0])*3.45)+(getprop(EngineRpm[1])*3.45))/2);
      }
    }else{
        me.PumpPsi.setValue(((getprop(EngineRpm[0])*0.75)+(getprop(EngineRpm[1])*0.75))/2);
    }

    ########## Landing Gear ##########
    if(getprop(LandingGear) and !getprop(GearLock)){        # Landing Gear Down
      interpolate(me.LandingGearPsi, HydSystemPsi, 1);
    }elsif(!getprop(LandingGear) and !getprop(GearLock)){   # landing Gear Up
      interpolate(me.LandingGearPsi, 0, 1);
    }
    
    ########## Flaps ##########
    if(getprop(Flaps) < 0){                                # Flaps Dow
      interpolate(me.FlapsUpPsi, 0, 0.05);
      interpolate(me.FlapsDownPsi, HydSystemPsi, 0.2);
      settimer(func{setprop(Flaps, 0);}, 0.6);
    }elsif(getprop(Flaps) > 0){                            # Flaps Up
      interpolate(me.FlapsDownPsi, 0, 0.05);
      interpolate(me.FlapsUpPsi, HydSystemPsi, 0.2);
      settimer(func{setprop(Flaps, 0);}, 0.6);
    }elsif(getprop(Flaps) == 0){
      interpolate(me.FlapsDownPsi, 0, 0.1);
      interpolate(me.FlapsUpPsi, 0, 0.1);
    }

    ########## Cowl-Flaps-Left ##########

    ### OPEN ###
    if(getprop(CowlFlaps[0]) == 0){
      interpolate(me.CowlFlapsLeftClosePsi, 0, 0.2);
      interpolate(me.CowlFlapsLeftOpenPsi, HydSystemPsi, 0.5);
    }

    ### OFF ###
    if(getprop(CowlFlaps[0]) == 1 or getprop(CowlFlaps[0]) == 3){
      interpolate(me.CowlFlapsLeftOpenPsi, 0, 0.5);
      interpolate(me.CowlFlapsLeftClosePsi, 0, 0.5);
    }

    ### TRAIL ###
    if(getprop(CowlFlaps[0]) == 2){
      # Automatic system
      as = getprop(AirSpeedKt);
      if(as > 180) as = 180;
      if(as < 60) as = 60;
      var acfl = 1- ((as - 60) * (1/120));
      interpolate(CowlFlapsNorm[0], acfl, 0.2);
      interpolate(me.CowlFlapsLeftOpenPsi, 0, 0.5);
      interpolate(me.CowlFlapsLeftClosePsi, 0, 0.5);
    }

    ### CLOSE ###
    if(getprop(CowlFlaps[0]) == 4){
      interpolate(me.CowlFlapsLeftOpenPsi, 0, 0.2);
      interpolate(me.CowlFlapsLeftClosePsi, HydSystemPsi, 0.5);
    }

    ########## Cowl-Flaps-Right ##########

    ### OPEN ###
    if(getprop(CowlFlaps[1]) == 0){
      interpolate(me.CowlFlapsRightClosePsi, 0, 0.2);
      interpolate(me.CowlFlapsRightOpenPsi, HydSystemPsi, 0.5);
    }

    ### OFF ###
    if(getprop(CowlFlaps[1]) == 1 or getprop(CowlFlaps[1]) == 3){
      interpolate(me.CowlFlapsRightOpenPsi, 0, 0.5);
      interpolate(me.CowlFlapsRightClosePsi, 0, 0.5);
    }

    ### TRAIL ###
    if(getprop(CowlFlaps[1]) == 2){
      # Automatic system
      as = getprop(AirSpeedKt);
      if(as > 180) as = 180;
      if(as < 60) as = 60;
      var acfr = 1- ((as - 60) * (1/120));
      interpolate(CowlFlapsNorm[1], acfr, 0.2);
      interpolate(me.CowlFlapsRightOpenPsi, 0, 0.5);
      interpolate(me.CowlFlapsRightClosePsi, 0, 0.5);
    }

    ### CLOSE ###
    if(getprop(CowlFlaps[1]) == 4){
      interpolate(me.CowlFlapsRightOpenPsi, 0, 0.2);
      interpolate(me.CowlFlapsRightClosePsi, HydSystemPsi, 0.5);
    }

    ########## Brake ##########
    me.BrakeLeftPsi.setValue(getprop(BrakeCmd[0])*350);
    me.BrakeRightPsi.setValue(getprop(BrakeCmd[1])*350);

    ########## Wipers ##########
    me.WiperLeftPsi.setValue(HydSystemPsi);
    me.WiperRightPsi.setValue(HydSystemPsi);

    #####################################
    ########## SETUP ANIMATION ##########

    if(me.LandingGearPsi.getValue() > 900){
      dc3.gearDown(1);
    }
    if(me.LandingGearPsi.getValue() < 200){
      dc3.gearDown(-1);
    }
    if(me.FlapsDownPsi.getValue() > 900 and me.FlapsUpPsi.getValue() < 200){
      interpolate(me.FlapsDownPsi, 0, 0.2);
      dc3.flapsDown(-1);
      dc3.flapsDown(0);
      gui.popupTip(sprintf("Flaps: %d deg", 30*getprop("/controls/flight/flaps")+0.1));      
    }
    if(me.FlapsUpPsi.getValue() > 900 and me.FlapsDownPsi.getValue() < 200){
      interpolate(me.FlapsUpPsi, 0, 0.2);
      dc3.flapsDown(1);
      dc3.flapsDown(0);
      gui.popupTip(sprintf("Flaps: %d deg", 30*getprop("/controls/flight/flaps")+0.1));      
    }
    if(me.CowlFlapsLeftOpenPsi.getValue() > 900 and me.CowlFlapsLeftClosePsi.getValue() < 200){
      var cflop = getprop(CowlFlapsNorm[0]) + 0.001;
      setprop(CowlFlapsNorm[0], cflop);
      #interpolate(CowlFlapsNorm[0], 1, 2);
    }
    if(me.CowlFlapsLeftClosePsi.getValue() > 900 and me.CowlFlapsLeftOpenPsi.getValue() < 200){
      var cflcp = getprop(CowlFlapsNorm[0]) - 0.001;
      setprop(CowlFlapsNorm[0], cflcp);
      #interpolate(CowlFlapsNorm[0], 0, 2);
    }
    if(me.CowlFlapsRightOpenPsi.getValue() > 900 and me.CowlFlapsRightClosePsi.getValue() < 200){
      var cfrop = getprop(CowlFlapsNorm[1]) + 0.001;
      setprop(CowlFlapsNorm[1], cfrop);
      #interpolate(CowlFlapsNorm[1], 1, 2);
    }
    if(me.CowlFlapsRightClosePsi.getValue() > 900 and me.CowlFlapsRightOpenPsi.getValue() < 200){
      var cfrcp = getprop(CowlFlapsNorm[1]) - 0.001;
      setprop(CowlFlapsNorm[1], cfrcp);
      #interpolate(CowlFlapsNorm[1], 0, 2);
    }
    if(me.BrakeLeftPsi.getValue() > 50){
      interpolate(Brake[0], 1, 0.5);
    }else{
      interpolate(Brake[0], 0, 0.5);
    }
    if(me.BrakeRightPsi.getValue() > 50){
      interpolate(Brake[1], 1, 0.5);
    }else{
      interpolate(Brake[1], 0, 0.5);
    }
  }
};

var HydraulicSystem = Hydraulic.new();

var update_hydraulic = func {
  HydraulicSystem.update();
  settimer(update_hydraulic, 0);
}

setlistener("/sim/signals/fdm-initialized", func {
  settimer(update_hydraulic, 2);
  print("Hydraulic system ... OK");
});
