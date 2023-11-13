#usage :     var wiper = Wiper.new(wiper property , wiper power source (separate from on off switch));
#
#    var wiper = Wiper.new("controls/electric/wipers","systems/electrical/volts");

Wiper = [];

var Wiper = {
    new : func {
        m = { parents : [Wiper] };
        m.direction = 0;
        m.delay_count = 0;
        m.spd_factor = 0;
        m.node = props.globals.getNode(arg[0],1);
        m.power = props.globals.getNode(arg[1],1);
        if(m.power.getValue()==nil)m.power.setDoubleValue(0);
        m.spd = m.node.getNode("arc-sec",1);
        if(m.spd.getValue()==nil)m.spd.setDoubleValue(1);
        m.delay = m.node.getNode("delay-sec",1);
        if(m.delay.getValue()==nil)m.delay.setDoubleValue(0);
        m.position = m.node.getNode("position-norm", 1);
        m.position.setDoubleValue(0);
        m.switch = m.node.getNode("switch", 1);
        if (m.switch.getValue() == nil)m.switch.setBoolValue(0);
        return m;
    },
    active: func{
        if(me.power.getValue()<=5)return;
        var spd_factor = 1/me.spd.getValue();
        var pos = me.position.getValue();
        if(!me.switch.getValue()){
          if(pos <= 0.000)return;
        }
        if(pos >=1.000){
          me.direction=-1;
        }elsif(pos <=0.000){
          me.direction=0;
          me.delay_count+=getprop("/sim/time/delta-sec");
          if(me.delay_count >= me.delay.getValue()){
            me.delay_count=0;
            me.direction=1;
          }
        }
        var wiper_time = spd_factor*getprop("/sim/time/delta-sec");
        pos +=(wiper_time * me.direction);
        me.position.setValue(pos);
    }
};

var wiperL = Wiper.new("controls/hydraulic/wipers-left", "systems/hydraulics/wiper-left-psi");
var wiperR = Wiper.new("controls/hydraulic/wipers-right", "systems/hydraulics/wiper-right-psi");

setlistener("/sim/signals/fdm-initialized", func {
    settimer(update_systems, 2);
});

var update_systems = func {
    wiperL.active();
    wiperR.active();
    settimer(update_systems, 0);
}
