# Navigation-for-a-Robotic-Lawnmower (Team Project)
This project is a graded part of the module 'Robotic Vision and Navigation' COMP0130 at [UCL London](https://www.ucl.ac.uk/). It is a team project done by 3 students. The goal of this project is to implement Integrated Navigation for a Robotic Lawnmower by fusing data from a variety of sensors to obtain an optimal position, velocity and heading solution.

The tasks description is detailed [here.](Task_Description.pdf)

## Author
* Hei Yin Wong (heiyin.wong.22@ucl.ac.uk)
* Akshet Patel (akshet.patel.22@ucl.ac.uk)
* Agung Nuza Dwiputra (agung.dwiputra.22@ucl.ac.uk)

## Sensor Fusion
### Algorithm:

#### GNSS:
* Initialize error_cov and state
* Use least square to calc first epoch
* Use multi epoch with kalman filter

#### Deadreckoning:
* Calculate dead reckoning using GNSS data

### Combine both:
* Use Kalman Filter

## How to run the package
Open the [main.m](Implementation/main.m) file in MATLAB and run it.

## Team member contribution
We each contributed equally to the project (33.33% each). We developed the solution independantly and tested the code for bugs and edge cases, and we discussed our findings and optimized the code as needed.

## PS:
(The code has missing parts to prevent plagiarism.)