##########################################################
#      DE L'HAMAIDE Clément for Douglas DC-3 C47         #
##########################################################

var TANKS = props.globals.getNode("consumables/fuel").getChildren("tank");

var fuel_pressure = func(tank, engine){
  var from_tank = tank;
  var to_engine = engine;
  var boost_pump = getprop("systems/electrical/outputs/boost-pump["~to_engine~"]");
  var fuel_psi = "engines/engine["~to_engine~"]/fuel-psi-norm";
  var fuel_qty = getprop("consumables/fuel/tank["~from_tank~"]/level-gal_us");
  var eng_state = getprop("engines/engine["~to_engine~"]/running");

  if(boost_pump > 8){
    if(fuel_qty >= 40) interpolate(fuel_psi, 16, 3);
    elsif(fuel_qty < 40) interpolate(fuel_psi, fuel_qty*0.4, 3);
  }else{
    if(eng_state){
      if(fuel_qty >= 40) interpolate(fuel_psi, 14.5, 3);
      elsif(fuel_qty < 40) interpolate(fuel_psi, fuel_qty*0.36, 3);
    }else{
      interpolate(fuel_psi, 0, 3);
    }
  }

  if(getprop(fuel_psi) < 10){
    setprop("engines/engine["~to_engine~"]/out-of-fuel", 1);
  }else{
    setprop("engines/engine["~to_engine~"]/out-of-fuel", 0);
  }
}

var fuel_update = func{
  var LEFTVALVE  = props.globals.getNode("controls/fuel/left-valve").getValue();
  var RIGHTVALVE = props.globals.getNode("controls/fuel/right-valve").getValue();

  for(var i=0; i < size(TANKS); i=i+1){
    setprop("controls/fuel/tank["~i~"]/to_engine", "-1");
    setprop("controls/fuel/tank["~i~"]/fuel_selector", 0);
  }

  if(LEFTVALVE > 0){
    LEFTVALVE -= 1;
    if(getprop("controls/fuel/tank["~LEFTVALVE~"]/fuel_selector")){
      setprop("controls/fuel/tank["~LEFTVALVE~"]/to_engine", 2);
    }else{
      setprop("controls/fuel/tank["~LEFTVALVE~"]/fuel_selector", 1);
      setprop("controls/fuel/tank["~LEFTVALVE~"]/to_engine", 0);
    }
  }else{
    interpolate("engines/engine/fuel-psi-norm", 0, 3);
    setprop("engines/engine/out-of-fuel", 1);
  }

  if(RIGHTVALVE > 0){
    RIGHTVALVE -= 1;
    if(getprop("controls/fuel/tank["~RIGHTVALVE~"]/fuel_selector")){
      setprop("controls/fuel/tank["~RIGHTVALVE~"]/to_engine", 2);
    }else{
      setprop("controls/fuel/tank["~RIGHTVALVE~"]/fuel_selector", 1);
      setprop("controls/fuel/tank["~RIGHTVALVE~"]/to_engine", 1);
    }
  }else{
    interpolate("engines/engine[1]/fuel-psi-norm", 0, 3);
    setprop("engines/engine[1]/out-of-fuel", 1);
  }

  for(var i=0; i < size(TANKS); i=i+1){
    if(getprop("controls/fuel/tank["~i~"]/fuel_selector")){
		#print("At least one tank is selected");
      if(props.globals.getNode("controls/fuel/tank["~i~"]/to_engine").getValue() == 0){
		#print("Engine Left consume fuel from tank "~i);
        var ConsumedFuelEng0 = props.globals.getNode("engines/engine/fuel-flow-gph").getValue() / 3600;
        var TankQty = props.globals.getNode("consumables/fuel/tank["~i~"]/level-gal_us").getValue();
        var NewQty = TankQty - ConsumedFuelEng0;
        setprop("consumables/fuel/tank["~i~"]/level-gal_us", NewQty);
        fuel_pressure(i,0);
      }
      if(props.globals.getNode("controls/fuel/tank["~i~"]/to_engine").getValue() == 1){
		#print("Engine Right consume fuel from tank "~i);
        var ConsumedFuelEng1 = props.globals.getNode("engines/engine[1]/fuel-flow-gph").getValue() / 3600;
        var TankQty = props.globals.getNode("consumables/fuel/tank["~i~"]/level-gal_us").getValue();
        var NewQty = TankQty - ConsumedFuelEng1;
        setprop("consumables/fuel/tank["~i~"]/level-gal_us", NewQty);
        fuel_pressure(i,1);
      }
      if(props.globals.getNode("controls/fuel/tank["~i~"]/to_engine").getValue() == 2){
		#print("Engine Left and Right consume fuel from tank "~i);
        var ConsumedFuelEng0 = props.globals.getNode("engines/engine/fuel-flow-gph").getValue() / 3600;
        var ConsumedFuelEng1 = props.globals.getNode("engines/engine[1]/fuel-flow-gph").getValue() / 3600;
        var TankQty = props.globals.getNode("consumables/fuel/tank["~i~"]/level-gal_us").getValue();
        var NewQty = TankQty - (ConsumedFuelEng0 + ConsumedFuelEng1);
        setprop("consumables/fuel/tank["~i~"]/level-gal_us", NewQty);
        fuel_pressure(i,0);
        fuel_pressure(i,1);
      }
    }
  }

  var n = props.globals.getNode("controls/fuel/tank-gauge").getValue();
  if(n == 0){n = 1;}
  elsif(n == 1){n = 0;}
  elsif(n == 2){n = 3;}
  elsif(n == 3){n = 2;}
  var fuelQty = props.globals.getNode("consumables/fuel/tank["~n~"]/level-gal_us").getValue();
  interpolate("consumables/fuel/needle-gauge", fuelQty, 0.25);

  settimer(fuel_update, 0.9);
}

setlistener("/sim/signals/fdm-initialized", func{
  print("Fuel System ... OK");
  settimer(fuel_update, 2);
});
