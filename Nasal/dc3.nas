##########################################################
#         BACON Guillaume for Douglas DC-3 C47           #
#         Modified by DE L'HAMAIDE Clément               #
##########################################################

setprop('/controls/gear/tailwheel-lock', 1);
setprop('/controls/gear/tailwheel-lock-armed', 0);
setprop('/controls/gear/tailwheel-lock-engaged', 1);

setlistener('/controls/gear/tailwheel-lock', func (node) {
    if (node.getBoolValue()) {
        # arm
        var angle = getprop('/gear/gear[2]/caster-angle-deg') or 0.0;
        if (angle > 3.0) {
            setprop('/controls/gear/tailwheel-lock-armed', 1);
        }
        elsif (angle < -3.0) {
            setprop('/controls/gear/tailwheel-lock-armed', -1);
        }
        else {
            setprop('/controls/gear/tailwheel-lock-engaged', 1);
            setprop('/controls/gear/tailwheel-lock-armed', 0);
        }
    }
    else {
        setprop('/controls/gear/tailwheel-lock-engaged', 0);
        setprop('/controls/gear/tailwheel-lock-armed', 0);
    }
}, 1, 0);

setlistener('/gear/gear[2]/caster-angle-deg', func (node) {
    var engaged = getprop('/controls/gear/tailwheel-lock-engaged');
    if (engaged == 1)
        return; # nothing to do
    var armed = getprop('/controls/gear/tailwheel-lock-armed');
    if (armed == 0)
        return; # nothing to do
    var angle = node.getValue() or 0.0;
    if ((armed > 0 and angle < 3.0) or (armed < 0 and angle > -3.0)) {
        setprop('/controls/gear/tailwheel-lock-engaged', 1);
        setprop('/controls/gear/tailwheel-lock-armed', 0);
    }
}, 1, 0);

var mousex =0;
var msx = 0;
var msxa = 0;
var mousey = 0;
var msy = 0;
var msya=0;

setlistener("/sim/signals/fdm-initialized", func{
  setprop("/instrumentation/doors/crew/position-norm",0);
  settimer(update_system, 2);
  settimer(mouse_accel, 1);
  print("Aircraft System ... OK");
});

setlistener("controls/flight/flaps", func(flaps){
  var flaps_current = flaps.getValue() / 0.25;
  flaps_current = int(flaps_current+0.5);
  flaps = flaps_current * 0.25;
  setprop("sim/flaps/current-setting", flaps_current);
  setprop("controls/flight/flaps", flaps);
});

controls.gearDown = func(v) {
    if (v < 0) {
      setprop("controls/gear/gear-down-lock", 0);
      setprop("controls/gear/gear-down-cmd", 0);
      settimer(func{setprop("controls/gear/gear-down-lock", 1);}, 6);
    } elsif (v > 0) {
      setprop("controls/gear/gear-down-lock", 0);
      setprop("controls/gear/gear-down-cmd", 1);
      settimer(func{setprop("controls/gear/gear-down-lock", 1);}, 6);
    }
}

var gearDown = func(v) {
    if (v < 0) {
      setprop("/controls/gear/gear-down", 0);
    } elsif (v > 0) {
      setprop("/controls/gear/gear-down", 1);
    }
}

controls.flapsDown = func(step) {
  if(step != 0){
    setprop("controls/flight/flaps-cmd", step);
  }
}

var flapsDown = func(step) {
  if(step == 0) return;
  if(props.globals.getNode("/sim/flaps") != nil) {
    controls.stepProps("/controls/flight/flaps", "/sim/flaps", step);
    return;
  }
  # Hard-coded flaps movement in 3 equal steps:
  var val = 0.3333334 * step + getprop("/controls/flight/flaps");
  setprop("/controls/flight/flaps", val > 1 ? 1 : val < 0 ? 0 : val);
}

var CrewDoor = aircraft.door.new("instrumentation/doors/crew", 8.0);
var CargoDoor = aircraft.door.new("instrumentation/doors/cargo", 10.0);
var PassengerDoor = aircraft.door.new("instrumentation/doors/passenger", 10.0);

var config_dlg = gui.Dialog.new("/sim/gui/dialogs/config/dialog", "Aircraft/Douglas-Dc3/Dialogs/config.xml");

var mouse_accel=func{
  msx=getprop("devices/status/mice/mouse/x") or 0;
  mousex=msx-msxa;
  mousex*=0.5;
  msxa=msx;
  msy=getprop("devices/status/mice/mouse/y") or 0;
  mousey=msya-msy;
  mousey*=0.5;
  msya=msy;
  settimer(mouse_accel, 0);
}

var set_levers = func(type,num,min,max){
  var ctrl=[];
  var cpld=-1;
  if(type == "throttle"){
    ctrl = ["controls/engines/engine[0]/throttle","controls/engines/engine[1]/throttle"];
    cpld = "controls/throttle-coupled";
  }elsif(type == "prop"){
    ctrl = ["controls/engines/engine[0]/propeller-pitch","controls/engines/engine[1]/propeller-pitch"];
    cpld = "controls/prop-coupled";
  }elsif(type == "mixture"){
    ctrl = ["controls/engines/engine[0]/mixture","controls/engines/engine[1]/mixture"];
    cpld ="controls/mixture-coupled";
  }

  var amnt =mousey* getprop("controls/movement-scale");
  var ttl = getprop(ctrl[num]) + amnt;
  if(ttl > max) ttl = max;
  if(ttl<min)ttl=min;
  setprop(ctrl[num],ttl);
  if(getprop(cpld))setprop(ctrl[1-num],ttl);
}

##############################################
######### AUTOSTART / AUTOSHUTDOWN ###########
##############################################

setlistener("/sim/model/start-idling", func(idle){
    var run= idle.getBoolValue();
    if(run){
    Startup();
    }else{
    Shutdown();
    }
},0,0);

var Startup = func{
  setprop("controls/fuel/left-valve", 3);
  setprop("controls/fuel/right-valve", 2);
  setprop("controls/fuel/tank/boost-pump", 1);
  setprop("controls/fuel/tank[1]/boost-pump", 1);
  setprop("controls/electric/engine[0]/generator",1);
  setprop("controls/electric/engine[1]/generator",1);
  setprop("/controls/engines/engine[0]/magnetos",3);
  setprop("controls/engines/engine[0]/propeller-pitch",1);
  setprop("controls/engines/engine[0]/mixture",0.7);
  setprop("/controls/engines/engine[1]/magnetos",3);
  setprop("controls/engines/engine[1]/propeller-pitch",1);
  setprop("controls/engines/engine[1]/mixture",0.7);
  setprop("/controls/gear/brake-parking",0);
  setprop("/instrumentation/doors/crew/position-norm",0);
  setprop("/controls/lighting/instruments-norm",1);
  setprop("controls/electric/battery-switch",1);
  setprop("sim/messages/copilot", "Now press s to start engines");
}

var Shutdown = func{
  setprop("controls/electric/engine[0]/generator",0);
  setprop("controls/electric/engine[1]/generator",0);
  setprop("/controls/engines/engine[0]/magnetos",0);
  setprop("controls/engines/engine[0]/propeller-pitch",0);
  setprop("controls/engines/engine[0]/mixture",0);
  setprop("/engines/engine[0]/rpm",0);
  setprop("/engines/engine[0]/running",0);
  setprop("/controls/engines/engine[1]/magnetos",0);
  setprop("controls/engines/engine[1]/propeller-pitch",0);
  setprop("controls/engines/engine[1]/mixture",0);
  setprop("/engines/engine[1]/rpm",0);
  setprop("/engines/engine[1]/running",0);
  setprop("/controls/gear/brake-parking",1);
  setprop("/instrumentation/doors/crew/position-norm",1);
  setprop("/controls/lighting/instruments-norm",0);
  setprop("controls/electric/battery-switch",0);
  setprop("controls/fuel/left-valve", 0);
  setprop("controls/fuel/right-valve", 0);
  setprop("controls/fuel/tank/boost-pump", 0);
  setprop("controls/fuel/tank[1]/boost-pump", 0);
  setprop("sim/messages/copilot", "Engines are stopped");
}

##############################################
################ TIRE SYSTEM #################
##############################################

#tire rotation per minute by circumference/groundspeed#
TireSpeed = {
    new : func(number){
        m = { parents : [TireSpeed] };
            m.num=number;
            m.circumference=[];
            m.tire=[];
            m.rpm=[];
            for(var i=0; i<m.num; i+=1) {
                var diam =arg[i];
                var circ=diam * math.pi;
                append(m.circumference,circ);
                append(m.tire,props.globals.initNode("gear/gear["~i~"]/tire-rpm",0,"DOUBLE"));
                append(m.rpm,0);
            }
        m.count = 0;
        return m;
    },
    #### calculate and write rpm ###########
    get_rotation: func (fdm1){
        var speed=0;
        if(fdm1=="yasim"){ 
            speed =getprop("gear/gear["~me.count~"]/rollspeed-ms") or 0;
            speed=speed*60;
            }elsif(fdm1=="jsb"){
                speed =getprop("fdm/jsbsim/gear/unit["~me.count~"]/wheel-speed-fps") or 0;
                speed=speed*18.288;
            }
        var wow = getprop("gear/gear["~me.count~"]/wow");
        if(wow){
            me.rpm[me.count] = speed / me.circumference[me.count];
        }else{
            if(me.rpm[me.count] > 0) me.rpm[me.count]=me.rpm[me.count]*0.95;
        }
        me.tire[me.count].setValue(me.rpm[me.count]);
        me.count+=1;
        if(me.count>=me.num)me.count=0;
    },
};

#var tire=TireSpeed.new(# of gear,diam[0],diam[1],diam[2], ...);
var tire=TireSpeed.new(3, 1.143, 1.143, 0.560);

##############################################
############### ENGINE SYSTEM ################
##############################################

#Engine sensors class 
# ie: var Eng = Engine.new(engine number);
var Engine = {
    new : func(eng_num){
        m =               { parents : [Engine]};
	m.air_temp =      props.globals.initNode("environment/temperature-degc");
	m.oat =           m.air_temp.getValue() or 0;
        m.eng =           props.globals.initNode("engines/engine["~eng_num~"]");
        m.running =       0;
        m.ot_target =     60;
	m.mp =            m.eng.initNode("mp-inhg");
        m.cutoff =        props.globals.initNode("controls/engines/engine["~eng_num~"]/cutoff");
        m.mixture =       props.globals.initNode("engines/engine["~eng_num~"]/mixture");
        m.mixture_lever = props.globals.initNode("controls/engines/engine["~eng_num~"]/mixture",1,"DOUBLE");
        m.rpm =           m.eng.initNode("rpm",1);
        m.oil_temp =      m.eng.initNode("oil-temp-c",m.oat,"DOUBLE");
        m.cyl_temp =      m.eng.initNode("cyl-temp",m.oat,"DOUBLE");
        m.carb_heat =     m.eng.initNode("carb-heat",0,"DOUBLE");
	m.carb_temp =     m.eng.initNode("carb-temp-degc",m.oat,"DOUBLE");
        m.oil_psi =       m.eng.initNode("oil-pressure-psi",0.0,"DOUBLE");
        m.fuel_psi =      m.eng.initNode("fuel-psi-norm",0,"DOUBLE");
        m.fuel_out =      m.eng.initNode("out-of-fuel",0,"BOOL");
        m.fuel_switch =   props.globals.initNode("controls/fuel/switch-position",-1,"INT");
        m.hpump =         props.globals.initNode("systems/hydraulics/pump-psi["~eng_num~"]",0,"DOUBLE");
	m.Lrunning =      setlistener("engines/engine["~eng_num~"]/running",func (rn){m.running=rn.getValue()},0,0);
	return m;
    },
#### update ####
    update : func(eng_num){
        var rpm =     me.rpm.getValue();
	var mp =      me.mp.getValue();
	var OT =      me.oil_temp.getValue();
        var mx =      me.mixture_lever.getValue();
	var ctemp =   me.air_temp.getValue();
        var cyltemp = me.cyl_temp.getValue();
        var cheat =   me.carb_heat.getValue();
	var cooling =    (getprop("velocities/airspeed-kt") * 0.1) *2;
        ###################################
        ######### OIL TEMPERATURE #########
        ###################################
	cooling += (mx * 5);
	var tgt  = me.ot_target + mp;
	var tgt -= cooling;
	if(me.running){
		if(OT < tgt) OT += rpm * 0.00001;
		if(OT > tgt) OT -= cooling * 0.001;
		}else{
		if(OT > me.air_temp.getValue()) OT-=0.001; 
	}
        me.oil_temp.setValue(OT);
        ###################################
        #### CYLINDER HEAT TEMPERATURE ####
        ###################################
	var thr = getprop("/engines/engine["~eng_num~"]/prop-thrust");
	var ct = getprop("/engines/engine["~eng_num~"]/cyl-temp");
	var cp = getprop("/controls/engines/engine["~eng_num~"]/cowl-flaps-norm");
	var as = getprop("/velocities/airspeed-kt");
	var egt = (getprop("/engines/engine["~eng_num~"]/egt-degf") - 32) * 0.55;
	var et0 = getprop("/environment/temperature-degc");
	var mp = getprop("/engines/engine["~eng_num~"]/mp-osi");
	var mix = getprop("/controls/engines/engine["~eng_num~"]/mixture");
	var visc = getprop("/engines/engine["~eng_num~"]/oil-visc");
	var cbt = et0 + 0.85 * mp; #carb temperature
	var temp = 3.1 * cbt + 0.225 * rpm + 0.5 * egt - 0.0033 * as * as - 0.08 * thr * (1.28 * cp + 0.1) - 20 * mix; #cyl-head temperature
	interpolate("/engines/engine["~eng_num~"]/cyl-temp", temp * 0.4, 45);
        ###################################
        ##### CARBURATOR TEMPERATURE ######
        ###################################
        if(props.globals.getNode("systems/electrical/outputs/carb-heat").getValue() > 8){
          cheat += 0.01;
          if(cheat > 40) cheat = 40;
          setprop("engines/engine["~eng_num~"]/carb-heat", cheat);
          cbt += cheat;
        }else{
          cheat -= 0.05;
          if(cheat < 0) cheat = 0;
          setprop("engines/engine["~eng_num~"]/carb-heat", cheat);
          cbt += cheat;
        }
	ctemp = rpm * 0.007;
	me.carb_temp.setValue(et0 - ctemp + cheat);
        ###################################
        ############# MIXTURE #############
        ###################################
	me.mixture.setValue(mx);
    },
};

EngineLeft = Engine.new(0);
EngineRight = Engine.new(1);

###############################################
###############################################
###############################################

var update_system = func{
  EngineLeft.update(0);
  EngineRight.update(1);

  if(getprop("/systems/electrical/outputs/starter") > 8){
    setprop("/engines/engine[0]/cranking",1);
  }else{
    setprop("/engines/engine[0]/cranking",0);
  }

  if(getprop("/systems/electrical/outputs/starter[1]") > 8){
    setprop("/engines/engine[1]/cranking",1);
  }else{
    setprop("/engines/engine[1]/cranking",0);
  }

  if(PassengerDoor.getpos() > 0 and CargoDoor.getpos() > 0){
    PassengerDoor.close();
  }

  tire.get_rotation("yasim");
  settimer(update_system, 0);
}

ki266.new(0);
