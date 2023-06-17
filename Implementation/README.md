Now with main script.

Run CW1_script.m

Implemented algorithm:


1.GNSS
-Get initial position using least square first epoch
-Using multiepoch GNSS Kalman Filter

2.Dead Reckoning
-Get initial position using least square first epoch
-Calculate solution
-Get corrected heading using Gyro-Mag Smoothing

3.Integration
-Apply Kalman Filter to correct DR solution using GNSS.

Output:

1.xls files each solution for GNSS, DR and Integration

2.Plot of position, velocity and heading
