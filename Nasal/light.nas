##########################################################
#      DE L'HAMAIDE Clément for Douglas DC-3 C47         #
##########################################################

var passingLight = aircraft.light.new("/sim/model/lights/passing", [0.04, 0.7, 0.5, 2], "/controls/lighting/passing-lights");
var tailLight = aircraft.light.new("/sim/model/lights/tail", [0], "/controls/lighting/tail-lights");
var navLight = aircraft.light.new("/sim/model/lights/running", [0], "/controls/lighting/running-lights");
var landingLightL = aircraft.light.new("/sim/model/lights/landing[0]", [0], "/controls/lighting/landing-lights");
var landingLightR = aircraft.light.new("/sim/model/lights/landing[1]", [0], "/controls/lighting/landing-lights[1]");
var recognition1 = aircraft.light.new("/sim/model/lights/recognition[0]", [0], "/controls/lighting/recognition-lights");
var recognition2 = aircraft.light.new("/sim/model/lights/recognition[1]", [0], "/controls/lighting/recognition-lights[1]");
var recognition3 = aircraft.light.new("/sim/model/lights/recognition[2]", [0], "/controls/lighting/recognition-lights[2]");
var formationLight = aircraft.light.new("/sim/model/lights/formation", [0], "/controls/lighting/formation-lights");
