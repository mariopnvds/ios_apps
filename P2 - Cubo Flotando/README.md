# IWEB - Project 2
## Authors
Pablo Caraballo Llorente
Mario Penavades Suárez

## Built With
- [Swift](https://www.apple.com/swift/)

## Statement:
Create a class derived from UIView that allows to represent parametric functions. The objects of this class must represent some axes of coordinates and draw a parametric function defined as x (t) and y (t). They must use the DataSource pattern to obtain the data they must represent.

This class will be used to create an application that allows to represent the vertical movement of a cube floating in water.

Suppose that the edge of the cube measures L, that its density is half that of water, and that it is floating in the water with its upper face lying horizontally. As the density of the cube is half that of water, in a state of rest the cube will be half sunk.

The idea is to push the cube a little down, without sinking it completely, carefully so that it does not turn, that is, so that a vertical movement occurs along the Z axis always maintaining the same orientation.

We will place the origin of coordinates on the surface of the water with the Z axis pointed upwards, and the position of the cube will be established by fixing on the center of gravity of the cube. Thus, the position of the cube for z = 0 will correspond to the cube sunken halfway; the position z = L / 2 will correspond to the cube floating just above the surface of the water; and the position z = -L / 2 will correspond to the sunken cube flush with the surface of the water.

For this practice, we will only deal with the simplified case in which there is no damping, that is, without taking into account the viscosity of the water or the aerodynamic losses. The equations for the damped real case can be found in:

     `https://es.wikipedia.org/wiki/Armónico_Scilador

The forces acting on the cube are its weight P (downwards) and the push E (upwards).
The value of the weight is: `P = -m g`
The value of the thrust is: `E = mh g`

where:
* m is the mass of the cube: `m = Dc L3`
* Da is the density of water: Da = 1
* Dc is the density of the cube, which was established as half that of the water: Dc = Da / 2
* L is the side of the cube.
* mh is the mass of water displaced by the sunken part of the cube: `mh = Da L2 (L / 2 - z)`
* g is the force of gravity: g = 9.8
* The total force F that the cube suffers upwards is equal to the thrust less its weight, and it is also equal to the mass of the cube multiplied by the acceleration that the cube experiences:

`F = m a = E - P = mh g - m g`

Substituting values ​​and clearing:

`a = -2 g z / L`

This last equation represents the movement of a harmonic oscillator.

The acceleration a is the second derivative of the z position with respect to time.

`d2z / dt2 = -2 g z / L`

It is a differential equation that when solved is obtained:

`z = 1/2 L cos (wt)`

`v = -1/2 L w sin (wt)`

`a = - g cos (wt)`

where:
* v is the speed of the cube on the Z axis.
* w is the angular frequency: `w = sqrt (2g / L)`

The application that is asked to develop must show the following graphs:
* The z position of the cube as a function of time.
* Its speed v as a function of time.
* Its acceleration a in function of time.
* Its speed v as a function of its position z.
* The application must have two sliders:

One to select the size L of the edge of the cube.
Another slider to select an instant of time that will be shown in the first three graphs as a point of interest on the drawn curve.
The application must have only one screen, implemented by the ViewController class that generates the Xcode Single View App template. This Class will be the controller of the application and the data source of the views. Apply the MVC pattern in the realization of this practice, that is, eliminate from sight everything that should belong to the model (the data). Develop a class for the model that implements the previous formulas and that is responsible for doing all the calculations on positions, speeds, accelerations, ...

The view and the model will be communicated using the UIViewController object, which acts as a controller according to the MVC pattern.

The application must have icons and initial image.

It is mandatory to use Autolayout and Size Classes so that the interface adapts perfectly to devices of different sizes, and the orientation changes.

## Upgrades
Add two gesture recognizers.

## Demo
<p align="center">
    <img src="p2.gif" alt="Demo" height="400" />
</p>