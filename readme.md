Divider units has been implemented using two different algorithm:
	-Restoring algorithm
	-Non restoring algorithm
Both algorithm works considering the recursive equation for the reminder R(j+1) = rR(j) - q(j+1)D
where R(j)is the remider at step j, r is the radix (i.e the number of element in the alphabet), in this case r = 2.
q(j) is the j-th bit of the quotient, D is the divider.
The restoring algorithm assumes that the q(j+1) in the formula is always one (S = {0,1}) so if R(j+1) became negative a restore is needed (R(j+1) += D).
The non restoring algorithm chenges the alphabet (S = {-1,1}) so is possible to restore the R(j+1) meanwhile guessing q(j+1) and no restore stage is actually needed.
The main difference between the two is that the Restoring has a random delay (in terms of clock cycles), instead the non-restoring has a fixed delay.

Restoring algorithm:
![Restoring] (flowchart/Restoring_flowchart.png)

Non restoring algorithm:
![Non-restoring] (flowchart/Non_restoring_flowchart.png)