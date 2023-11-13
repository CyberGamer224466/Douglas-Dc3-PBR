##########################################################
#      DE L'HAMAIDE Clément for Douglas DC-3 C47         #
##########################################################

##############################################
################# ANIMATION  #################
################ INTERPOLATE  ################
##############################################

setlistener("/controls/gear/gear-down-lock", func(v) {
  if(v.getValue()){
    interpolate("/controls/gear/gear-down-lock-pos", 1, 1);
  }else{
    interpolate("/controls/gear/gear-down-lock-pos", 0, 1);
  }
});

setlistener("/controls/electric/battery-switch", func(v) {
  if(v.getValue()){
    interpolate("/controls/electric/battery-switch-pos", 1, 0.25);
  }else{
    interpolate("/controls/electric/battery-switch-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/landing-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/landing-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/landing-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/landing-lights[1]", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/landing-lights-pos[1]", 1, 0.25);
  }else{
    interpolate("/controls/lighting/landing-lights-pos[1]", 0, 0.25);
  }
});

setlistener("/controls/engines/engine/oil-dilution", func(v) {
  if(v.getValue()){
    interpolate("/controls/engines/engine/oil-dilution-pos", 1, 0.25);
  }else{
    interpolate("/controls/engines/engine/oil-dilution-pos", 0, 0.25);
  }
});

setlistener("/controls/engines/engine[1]/oil-dilution", func(v) {
  if(v.getValue()){
    interpolate("/controls/engines/engine[1]/oil-dilution-pos", 1, 0.25);
  }else{
    interpolate("/controls/engines/engine[1]/oil-dilution-pos", 0, 0.25);
  }
});

setlistener("/controls/paratroopers/jump-signal", func(v) {
  if(v.getValue()){
    interpolate("/controls/paratroopers/jump-signal-pos", 1, 0.25);
  }else{
    interpolate("/controls/paratroopers/jump-signal-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/passing-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/passing-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/passing-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/anti-ice/pitot-heat", func(v) {
  if(v.getValue()){
    interpolate("/controls/anti-ice/pitot-heat-pos", 1, 0.25);
  }else{
    interpolate("/controls/anti-ice/pitot-heat-pos", 0, 0.25);
  }
});

setlistener("/controls/anti-ice/pitot-heat[1]", func(v) {
  if(v.getValue()){
    interpolate("/controls/anti-ice/pitot-heat-pos[1]", 1, 0.25);
  }else{
    interpolate("/controls/anti-ice/pitot-heat-pos[1]", 0, 0.25);
  }
});

setlistener("/controls/anti-ice/prop-heat", func(v) {
  if(v.getValue()){
    interpolate("/controls/anti-ice/prop-heat-pos", 1, 0.25);
  }else{
    interpolate("/controls/anti-ice/prop-heat-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/running-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/running-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/running-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/tail-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/tail-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/tail-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/anti-ice/window-heat", func(v) {
  if(v.getValue()){
    interpolate("/controls/anti-ice/window-heat-pos", 1, 0.25);
  }else{
    interpolate("/controls/anti-ice/window-heat-pos", 0, 0.25);
  }
});

setlistener("/controls/electric/battery-switch", func(v) {
  if(v.getValue()){
    interpolate("/controls/electric/battery-switch-pos", 1, 0.25);
  }else{
    interpolate("/controls/electric/battery-switch-pos", 0, 0.25);
  }
});

setlistener("/controls/electric/battery-switch", func(v) {
  if(v.getValue()){
    interpolate("/controls/electric/battery-switch-pos", 1, 0.25);
  }else{
    interpolate("/controls/electric/battery-switch-pos", 0, 0.25);
  }
});

setlistener("/controls/fuel/tank/boost-pump", func(v) {
  if(v.getValue()){
    interpolate("/controls/fuel/tank/boost-pump-pos", 1, 0.25);
  }else{
    interpolate("/controls/fuel/tank/boost-pump-pos", 0, 0.25);
  }
});

setlistener("/controls/fuel/tank[1]/boost-pump", func(v) {
  if(v.getValue()){
    interpolate("/controls/fuel/tank[1]/boost-pump-pos", 1, 0.25);
  }else{
    interpolate("/controls/fuel/tank[1]/boost-pump-pos", 0, 0.25);
  }
});

setlistener("/controls/fuel/long-range", func(v) {
  if(v.getValue()){
    interpolate("/controls/fuel/long-range-pos", 1, 0.25);
  }else{
    interpolate("/controls/fuel/long-range-pos", 0, 0.25);
  }
});

setlistener("/controls/anti-ice/engine/carb-heat", func(v) {
  if(v.getValue()){
    interpolate("/controls/anti-ice/engine/carb-heat-pos", 1, 0.25);
  }else{
    interpolate("/controls/anti-ice/engine/carb-heat-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/cabin-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/cabin-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/cabin-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/engines/engine/starter", func(v) {
  if(v.getValue()){
    interpolate("/controls/engines/engine/starter-pos", 1, 0.1);
  }else{
    interpolate("/controls/engines/engine/starter-pos", 0, 0.25);
  }
});

setlistener("/controls/engines/engine[1]/starter", func(v) {
  if(v.getValue()){
    interpolate("/controls/engines/engine[1]/starter-pos", 1, 0.1);
  }else{
    interpolate("/controls/engines/engine[1]/starter-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/recognition-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/recognition-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/recognition-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/recognition-lights[1]", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/recognition-lights-pos[1]", 1, 0.25);
  }else{
    interpolate("/controls/lighting/recognition-lights-pos[1]", 0, 0.25);
  }
});

setlistener("/controls/lighting/recognition-lights[2]", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/recognition-lights-pos[2]", 1, 0.25);
  }else{
    interpolate("/controls/lighting/recognition-lights-pos[2]", 0, 0.25);
  }
});

setlistener("/controls/engines/engine/propeller-feather", func(v) {
  if(v.getValue()){
    interpolate("/controls/engines/engine/propeller-feather-pos", 1, 0.25);
  }else{
    interpolate("/controls/engines/engine/propeller-feather-pos", 0, 0.25);
  }
});

setlistener("/controls/engines/engine[1]/propeller-feather", func(v) {
  if(v.getValue()){
    interpolate("/controls/engines/engine[1]/propeller-feather-pos", 1, 0.25);
  }else{
    interpolate("/controls/engines/engine[1]/propeller-feather-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/compass-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/compass-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/compass-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/lighting/formation-lights", func(v) {
  if(v.getValue()){
    interpolate("/controls/lighting/formation-lights-pos", 1, 0.25);
  }else{
    interpolate("/controls/lighting/formation-lights-pos", 0, 0.25);
  }
});

setlistener("/controls/gear/brake-parking", func(v) {
  if(v.getValue()){
    interpolate("/controls/gear/brake-parking-pos", 1, 0.25);
  }else{
    interpolate("/controls/gear/brake-parking-pos", 0, 0.25);
  }
});

setlistener("/controls/gear/tailwheel-lock", func(v) {
  if(v.getValue()){
    interpolate("/controls/gear/tailwheel-lock-pos", 1, 0.25);
  }else{
    interpolate("/controls/gear/tailwheel-lock-pos", 0, 0.25);
  }
});

setlistener("/controls/engines/engine/magnetos", func(v) {
    interpolate("/controls/engines/engine/magnetos-pos", v.getValue(), 0.25);
});

setlistener("/controls/engines/engine[1]/magnetos", func(v) {
    interpolate("/controls/engines/engine[1]/magnetos-pos", v.getValue(), 0.25);
});

setlistener("/controls/fuel/left-valve", func(v) {
    interpolate("/controls/fuel/left-valve-pos", v.getValue(), 0.25);
});

setlistener("/controls/fuel/right-valve", func(v) {
    interpolate("/controls/fuel/right-valve-pos", v.getValue(), 0.25);
});

setlistener("/controls/fuel/tank-gauge", func(v) {
    interpolate("/controls/fuel/tank-gauge-pos", v.getValue(), 0.25);
});

setlistener("/controls/engines/engine/cowl-flaps-cmd", func(v) {
    interpolate("/controls/engines/engine/cowl-flaps-pos", v.getValue(), 0.25);
});

setlistener("/controls/engines/engine[1]/cowl-flaps-cmd", func(v) {
    interpolate("/controls/engines/engine[1]/cowl-flaps-pos", v.getValue(), 0.25);
});
