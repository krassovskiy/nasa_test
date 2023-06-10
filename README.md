```To calculate a mission you need to use Calculate#call method```


# **Backend Test Task**
Congratulations! You have received a contract from NASA for software application, which will
help to calculate fuel required for the flight. The goal of this application is to calculate fuel to
launch from one planet of the Solar system, and to land on another planet of the Solar system,
depending on the flight route.

Formula to calculate fuel is quite simple, but it depends on the planet's gravity. Planets NASA
is interested in are:

  * Earth - 9.807 m/s
  * Moon - 1.62 m/s
  * Mars - 3.711 m/s

The formula for fuel calculations for the launch is the following:

```mass * gravity * 0.042 - 33``` rounded down

The formula for fuel calculations for the landing is the following:

```mass * gravity * 0.033 - 42``` rounded down

For example, for the Apollo 11 Command and Service Module, with a weight of 28801 kg, to
land it on the Earth, the required amount of fuel will be:

```28801 * 9.807 * 0.033 - 42 = 9278```

But fuel adds weight to the ship, so it requires additional fuel, until additional fuel is 0 or
negative. Additional fuel is calculated using the same formula from above.

- 9278 fuel requires 2960 more fuel
- 2960 fuel requires 915 more fuel
- 915 fuel requires 254 more fuel
- 254 fuel requires 40 more fuel
- 40 fuel requires no more fuel

So, to land Apollo 11 CSM on the Earth - 13447 fuel required (9278 + 2960 + 915 + 254 + 40).

Application should receive a flight route as 2 arguments. First one is the flight ship mass, and
second is an array of 2 element tuples, with the first element being land or launch directive,
and second element is the target planet gravity.

But take into account that to land a module on the Moon, you need additional fuel, which
should be launched from the Earth - we don’t have a refuel station in space - and we need to
carry fuel for all steps from the very beginning.

For example, for the program to launch the ship from the Earth, land it on the Moon, and
return back to the Earth, input arguments will look like this:

Ruby - ```28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]```
Elixir - ```28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]```
Python - ```28801, [(9.807, 1.62), (1.62, 9.807)]```

And remember, you are hired by NASA, and reliability is crucial. We have no right for a
mistake.

Here are examples of programs and required fuel for the whole mission:

1. Apollo 11:
    * path: launch Earth, land Moon, launch Moon, land Earth
    * weight of equipment: 28801 kg
    * weight of fuel: 51898 kg
    * arguments: 28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]

2. Mission on Mars:

    * path: launch Earth, land Mars, launch Mars, land Earth
    * weight of equipment: 14606 kg
    * weight of fuel: 33388 kg
    * arguments: 14606, [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]
3. Passenger ship:
    * path: launch Earth, land Moon, launch Moon, land Mars, launch Mars, land Earth
    * weight of equipment: 75432 kg
    * weight of fuel: 212161 kg
    * arguments: 75432, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]

**P.S**. It is very important to create not just working code but also **maintainable** and **readable**
code, so take your time and show your best.
