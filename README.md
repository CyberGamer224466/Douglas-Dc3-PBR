I edited the DC-3 for FlightGear by TDammers to be compatible with HDR/PBR.

Changes made:

    Fuselage
    Windows
    Instruments
    Livery specific levels of metalness and roughness

I am only credited for making the aircraft HDR/PBR compatible, I under no circumstances take credit or ownership over the models, FDM, sounds etc.

Beware that the aircraft is still in development stages and therefore there might be bugs and some thing that don't quite work. Also, this version only works on FlightGear 2020.4 with the HDR compositor turned on.

IMPORTANT!!! Remove PBR and master from the folder name, in the end the folder's name should only contain the aircraft name.

From here on is the original README file.


# Douglas DC-3 / C-47

## About The Aircraft

The DC-3 was developed from the DC-2, to meet the need for a larger aircraft
that could fit bunks in a sleeper configuration for American transcontinental
overnight routes. The airframe was adapted as a military transport for WW II,
and over 16,000 were produced. After the war, the abundant supply of surplus
military aircraft made it the single most popular airliner of the early
post-war period, and it has made a lasting impression as one of the most iconic
aircraft in history. The type remains in limited service today, over 80 years
after its maiden flight.

## Specifications:

- **Propulsion**: Pratt & Whitney 1830 Twin Wasp (2x), 14-cylinder air-cooled
  two-row radial engines, 1,200 HP each
- **Flight Crew**: 2 (captain + first officer)
- **Capacity**: 21-32 passengers
- **Empty Weight (OEW)**: 16865 lbs / 7650 kg
- **Typical Takeoff Weight**: 25200 lbs / 11431 kg
- **Range**: 1370 nmi
- **Service Ceiling**: 23,200 ft

## Configuration Options

The aircraft comes in 2 basic versions: a landplane (dc-3), and a seaplane
version with floats (dc-3A). Both versions can be configured with 3 different
interiors: civilian red, civilian grey, and military.

For the flightdeck, two options are currently available: an original ca. 1940
panel, with the instruments installed in typical nonstandard locations, and
equipped with a Sperry autopilot; and a later, ca. mid-1980's panel as used by
airlines such as Piedmont, with more modern instruments in a standard T-shaped
arrangement, and a Century 41 autopilot system.

## Flying the DC-3

The main thing to remember with this aircraft is that, being a taildragger, it
is quite different from your typical modern airliner.

### Startup

- Running light: ON (left overhead panel)
- Tail light: ON (left overhead panel)
- Turn on master battery (left overhead panel)
- Turn on both fuel boost pumps (right overhead panel)
- Mixture levers in "AUTO RICH" position
- Prop levers in "feather" position (full back)
- Both magnetos in "BOTH" position (center overhead panel)
- Left fuel selector: MAIN LH
- Right fuel selector: MAIN RH
- Throttles: ~1/2 inch forward.
- Parking brake: set.
- Left engine starter: ON (right overhead panel)
- Wait for left RPM to rise to about 500 rpm
- Left starter: OFF.
- Right engine starter: ON (right overhead panel)
- Wait for right RPM to rise to about 500 rpm
- Right starter: OFF.
- Throttles: IDLE.

### Taxiing

- Landing lights: AS NEEDED (the DC-3 has no taxi lights; standard procedure is
  to taxi with one landing light on and the other off)
- Throttles: IDLE
- Props: FULL FORWARD
- Tail wheel: UNLOCK ("l" key)
- Parking brake: RELEASE
- Use differential brakes and differential thrust to steer; lock tail wheel for
  longer straight sections.

### Takeoff

- Flaps: UP
- Cowl flaps: OPEN
- Landing lights: ON
- Tail wheel: LOCKED
- Props: FULL FORWARD
- Throttle: advance to manifold pressure (MP) 48
- Pull slightly on the elevator to keep tail down
- Use differential braking to steer while tail is down
- Allow tail to come up at 50 knots
- Maintain level pitch, use brakes and rudder to steer
- At positive climb: gear up
- Accelerate to 105 knots
- ~300 ft AGL: reduce MP to 40, maintain 105 knots
- ~800 ft AGL: accelerate to 115-120 knots
- Reduce MP to 35
- Props: pull back to maintain 2500 RPM
- Cowl flaps: TRAIL

### Cruise

- Landing lights: OFF
- Throttles: MP 20-25
- Props: 1800-2200 RPM
- Cowl flaps: CLOSE
- Airspeed: 150-155 knots

### Descent

- Landing lights: ON
- Cowl flaps: TRAIL
- Airspeed: 150-160 knots
- Throttles: MP 18-20
- Props: 1800-2200 RPM

### Approach

- Airspeed: 105 knots
- Throttles: as needed
- Props: FULL FORWARD
- Flaps: 7 deg
- Gear: down

### Final approach

- Flaps: 30 deg (set gradually; keep at 22 deg for crosswind landing)
- Cowl flaps: TRAIL
- Airspeed: 80 knots (85 for crosswind landing)
- Gear: confirm down & locked
- Tailwheel: LOCKED

### Landing

- Make sure you're aligned with the centerline
- Maintain 80 knots into flare
- Perform a slight flare to bleed off speed
- Use rudder to maintain centerline, help with diff braking
- Use elevator to avoid nosing over while applying gentle braking to slow down;
  keep the tail up to maintain rudder authority.
- At 50 knots, land the tail; use elevator to keep tail down for better
  directional stability. Remember that the rudder becomes ineffective once the
  tail is down.
- At 30 knots, release elevator, unlock tailwheel as needed for runway turnoff.
- Clean up aircraft while taxiing.

### Some general tips

- Diff braking and diff thrust are fairly critical to keep this bird
  controllable; rudder pedals with toe brakes and split thrust levers are
  absolute game changers.
- For crosswind landings, neither the usual "de-crab" technique (approaching
  the runway in a crab, then using rudder to align while flaring) nor the
  "slip" technique (use cross-controlled rudder and ailerons to keep the
  aircraft aligned through the final approach, and touch down with the upwind
  wheel first) work particularly well; I have found that the best technique is
  to fly most of the approach in a crab, then transition into a bit of a slip,
  but keeping the wings level, and finally kicking out the remaining crab
  shortly before touchdown. The aircraft can take a bit of side loading, but
  you have to be quick on the rudder and brakes to prevent a ground loop. Don't
  forget to use ailerons to counter the tendency to tip over when doing this.

## The Autopilots

### Sperry Autopilot

The Sperry unit isn't an autopilot in the modern sense; it has only very
limited capabilities, but nonetheless it is surprisingly useful. It controls 3
axes: rudder, ailerons, and elevator; and they are controlled completely
independently. The rudder axis is coupled to a pair of gyros, and will deflect
the rudder in an attempt to achieve and maintain a selected heading; the
aileron axis holds a selected bank angle, and the elevator axis holds a
selected pitch.

To execute a turn, first synchronize the two gyros using the rudder knob, and
synchronize the attitude bar on the attitude indicator on the Sperry unit with
the current attitude using the ; then
enable the autopilot, use the rudder knob to select the target heading, and the
aileron knob to bank in the desired direction. You will have to manually select
level attitude again as the aircraft approaches the target heading; the
autopilot will not do this for you. Once established on the target heading, the
rudder control is usually enough to keep the aircraft on course.

The elevator axis is fairly straightforward: turn the knob to select a target
pitch.

### Century 41 Autopilot system

The full operation manual for the Century 41 can be found here:

https://www.centuryflight.com/images/operating-manuals/CENT41.pdf

A short summary is provided here.

#### Configuration

- The AP can be enabled and disabled with the "ON/OFF" rocker switch on the
  autopilot control unit. You can also bind a joystick button to the property
  `controls/autoflight/autopilot[0]/engage` property. When the autopilot is
  disconnected, the "AP" light on the FMA panel will flash for 5 seconds.
- The unit faithfully models "CWS" ("Control Wheel Steering"), a button that
  temporarily disconnects the autopilot, and synchronizes the flight director
  with the current attitude and/or altitude. The autopilot will revert to its
  previous lateral and vertical modes and maintains the new attitude / altitude
  when the CWS button is released. CWS is not bound to anything by default, but
  you can bind a joystick button to `controls/autoflight/cws`.
- The unit also supports a "go-around" mode ("GA"), accessible through the
  `controls/autoflight/toga` property.
- The "UP/DOWN" rocker on the right of the control unit can be used to adjust
  the selected altitude / pitch to make fine adjustments. It can be mapped to
  joystick buttons or an axis using the `autopilot/inputs/pitch-button`
  property.

#### Lateral modes

- **ROLL** (no annunciation): this mode is the default when the autopilot is
  first engaged, a basic wing leveler.
- **HDG**: capture and hold the heading indicated by the heading bug on the
  HSI.
- **NAV**: fly a 45° intercept course, capture and track the VOR radial
  selected on NAV1.
- **NAV ARM** (both HDG and NAV light up): fly the selected heading as per HSI
  until intercepting the VOR radial on NAV1, then switch to NAV mode.

#### Vertical modes

- **ATT**: hold current pitch attitude. UP/DOWN rocker switch increases or
  reduces pitch up to +/- 500 fpm while pressed, and maintains the resulting
  pitch upon release.
- **ALT**: hold current pressure altitude. UP/DOWN rocker switch initiates a
  climb/descent up to +/- 500 fpm while pressed, and maintains the resulting
  pressure altitude upon release.
- **GA**: pitch for best single-engine climb speed (105 knots). Lateral mode is
  unaffected.
- **GS**: maintain ILS glideslope. This mode cannot be selected directly, but
  engages when capturing the glideslope with APR armed (see below).

#### Combined modes

- **APR**: approach mode. Lateral mode is set to NAV, vertical mode remains
  unaffected until an ILS glideslope is captured, at which point it transitions
  to GS.
- **APR ARM** (both HDG and APR light up): same as NAV ARM, but transitions to
  APR after capturing the localizer.
