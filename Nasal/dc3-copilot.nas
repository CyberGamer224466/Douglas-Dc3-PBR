##########################################################
#      DE L'HAMAIDE Clément for Douglas DC-3 C47         #
##########################################################

var mousex =0;
var msx = 0;
var msxa = 0;
var mousey = 0;
var msy = 0;
var msya=0;

setlistener("/sim/signals/fdm-initialized", func{
  settimer(mouse_accel, 1);
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
