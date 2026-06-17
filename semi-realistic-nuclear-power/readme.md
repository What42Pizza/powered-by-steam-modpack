# Semi-Realistic Nuclear Power

This mod adds somewhat realistic nuclear power generation. You have to feed pressurized water to reactors, use the resulting superheated water to boil more steam, and (optionally) dry the steam and feed it to multi-stage turbines. And of course, you need to control the temperature of the reactor.

Details to know:

- Control rods automatically start deploying at 1000C (with 100% strength at 1100C)
- Even though there's no gui for it, you can manually increase the control rod strength by giving the reactors an 'iron stick' circuit signal
- Reactors continue producing heat even after control rods are activated / after fuel runs out
- Efficiency increases the hotter the reactor is (consumption stays the same but heat output increases)
- The base efficiency of a reactor is (0.5 + #neighbors * 0.2) * (1.0 + (quality_level - 1) * 0.2)
- Reactors get a neighbor efficiency bonus even when neighboring reactors are not fueled
- A reactor will only be cooled if:
  - Its fluid input has more than 15 fluid units
  - Its fluid output has space available
  - It is above 700°

### Credits:

- What42Pizza: all code
- [borQue](https://freesound.org/people/borQue/): sound files [1](https://freesound.org/people/borQue/sounds/336838/) and [2](https://freesound.org/people/borQue/sounds/336837/)
