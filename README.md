# Numerical Approximation of Definite Integrals
**<h1>Purpose</h1>**  
If the current reference is in the direction of the voltage drop across the terminals of the inductor as shown in Figure 1, the power p(t) is

p(t)=v(t)i(t)     (1)

where v(t) is the voltage in Volts [V] and i(t) is the current in Amperes [A]. The power p(t) is in Watts [W]. Knowing that the power is the time rate of expending energy and assuming a reference for a zero energy corresponds to zero current in the inductor, the stored energy w(t) in Joules [J] can be given as

w(t)= ∫_0^t〖p(t)dt〗= ∫_0^t〖v(t)i(t)dt〗     (2)

Using the voltage-current relation of the inductor, the stored energy can also be found as

w(t)=  1/2 Li^2 (t)    (3)

![1](/images/1.jpg)  

The current and voltage values of an inductor with L=100 mH are measured for a time step size of  ∆t=25 ms  at the time interval  t ∈[0,1]s . In the measurement dat file(pr3data.dat), the first  column is the time in seconds (s), the second column is the current value in Amperes (A), and the third column is the voltage value in Volts (V).

Should be writen a code to import the associated data, plotting the current i(t) and the voltage v(t) data and comment on their consistency, determining and plotting the power p(t), determining the stored energy in the inductor by numerically integrating the equation (2) using Composite Midpoint Rule, Composite Trapezoid Rule, Composite Simpson’s Rule and equation 3, comparing all results and commenting on the stored energy.  

**<h1>Preparatory Work</h1>**  

Self-inductance, usually just called inductance, L is the ratio between the induced voltage and the rate of change of the current.

v(t) = L di/dt       (4)

Thus, inductance is a property of a conductor or circuit, due to its magnetic field, which tends to oppose changes in current through the circuit. The unit of inductance in the SI system is the henry (H), named after American scientist Joseph Henry, which is the amount of inductance that generates a voltage of one volt when the current is changing at a rate of one ampere per second.

Power can be expressed as in equation 1. With the data given, voltage and current can be multiplied depending on time and it can be learned how much power the inductance has in each time interval.

The time-dependent power function will indicate a path. The area under the power function can be learned with an integral whose lower limit is 0 and the upper limit depends on time. It is required to use 3 numerical methods to calculate this integral.

∫_a^b〖f(x)dx = 2h ∑_(j=0)^(n/2)〖f(x_2j )+ (b-a)/6 h^2 f^'' (μ)     (5)〗〗

The first requested method is the Composite Midpoint Rule given in Equation 5. In equation, h=(b-a)/(n+2) and x_j=a+(j+1)h for each j= -1,0,1,…,n+1. The Composite Midpoint rule needs double-spacing when computing the integral. We need power value information for each time interval. Therefore, it may not be able to obtain power information for some time intervals with this method.

∫_a^b〖f(x)dx=h/2+[ f(a)+f(b)+ 2 ∑_(j=1)^(n-1)〖f(x_j )]- (b-a)/12 h^2 f^'' (μ)     (6)〗〗

Secondly, the desired method is the Composite Trapezoid rule as shown in equation 6. In equation, h=(b-a)/n and x_j=a+jh for each j= 0,1,…,n. This method does not need double-spacing like the previous method when calculating the integral. So we can calculate the power value for each time interval.

∫_a^b〖f(x)dx=h/3+[ f(a)+f(b)+ 2 ∑_(j=1)^((n/2)-1)〖f(x_2j )  +4∑_(j=1)^(n/2)〖f(x_(2j-1))〗  ]- (b-a)/180 h^4 f^((4)) (μ)     (7)〗〗

Third, the method requested is Composite Simpson's rule. This method also needs a double interval when calculating the integral area as in the first method. So our sub-interval number should be even. Therefore, we may not be able to calculate the power at some time values.  

**<h1>Analysis</h1>**  

In the first question, it was asked to draw the graphs of the voltage and current values together with the data from the file given. In the code written accordingly:  

![2](/images/2.jpg)  

The variables that will be used throughout the entire script are defined first. The files given with the load command were taken. With these data, the desired graphics were drawn with the plot command. The reason for using the subplot command is that it is desired to include 2 more related graphics in the same figure.

Also, it is requested to check whether the voltage and current values are consistent. This check can be done using Equation 4. For Equation 4 to be applied, the derivative of the current must be taken. The three-point midpoint with endpoints method will be used to derive the current. The reason why this method is preferred is that the values at all points can be easily differentiated.  

![3](/images/3.jpg)  

To apply the three-point midpoint method, the left endpoint and right endpoint points were calculated separately. Derivative values taken at all time intervals are assigned to the vector named "derivatives" respectively. To apply Equation 4, the derivative values must also be multiplied by the L value. So in a for loop, all derivative values are assigned to a new vector named "new" after multiplying by the value of L. To check that the results are the same as the voltage value, a graph is drawn with the x-axis voltage values and the y-axis calculated values. The line y=x is expected from this graph. It is seen that the results meet the expectation in Figure 4.  

![4](/images/4.jpg)  

It is requested to calculate and plot the power value by using the voltage and current values given in the second question. Power can be calculated using Equation 1.  

![5](/images/5.jpg)  

Power values for each time interval are assigned to a vector named "powers" by multiplying the current and voltage values from the given data in a for a loop. The calculated power values are plotted with the plot command. With the Subplot command, the power values graph is added to the figure 1, where the voltage and current graphs were drawn before.

The third question will first be calculated with the composite midpoint method.  

![6](/images/6.jpg)  

The method in equation 5 is wanted to be obtained with nested for loops. The initial value of the integral is given as 0 at first. While the outer for loop changes the upper bound, the inner for loop calculates the series sum for each n value. These calculations are added to the first column of the matrix named "integral" to which integral values to be calculated will be added. The outer loop resets the series sum every round.

If the results obtained by Composite midpoint method are plotted:  

![7](/images/7.jpg)  

As seen in Figure 7, a smooth graphic could not be obtained. The reason for this is that, as mentioned in the composite midpoint method section in the preparatory work section, the method calculates using double intervals. Since the upper limit of the series sum is n/2, even if the loop value is increased, the same series sum as the previous step will be obtained. Therefore, there were linear lines at some points. Since only composite midpoint method was requested to calculate the integral, a different method was not used.

The third question will be calculated secondly by the composite trapezoid method.  

![8](/images/8.jpg)  

As in the previous method, the first integral value is assigned 0. In order to apply the Composite Trapezoid method, equation 6 will be adapted. Nested for loops are used to calculate integrals at each time value. While the outer for loop changes the upper bound of the integral and calculates the integral result for that time value, the inner for loop calculates the sum of the series calculated for each time value. The integral results are added to the second column of the matrix named "integral". Composite midpoint method results were added to the first column.

If the results obtained by Composite Trapezoid method are plotted:  

![9](/images/9.jpg)  

Since the Composite Trapezoid method can calculate integrals for each interval, the resulting graph is closer to a smoother result. Convergence will be discussed at the end of the report.

Finally, the third question will be calculated using the composite trapezoid method.  

![10](/images/10.jpg)  

As in the previous methods, the first integral value is given 0. Nested for loops are used to calculate the integral for each time interval. Equation 7 is tried to be implemented in code. In the equation, the values that are in the single row, and the values in the double row are calculated in different series totals with different limits. These series totals have been multiplied by different coefficients and the result has been reached. To put the data into this separation, farm-uniqueness control has been made in the internal for a loop. This control is done by taking the mode of the number with 2 with the mode command. These data are collected in different for loops. In the outer for loop, integrals are calculated according to the method by using the series sums and assigned to the 3rd column of the matrix named "integral". The first 2 columns were assigned the results of the previous methods.

If the results obtained by Composite Trapezoid method are plotted:  

![11](/images/11.jpg)  

As seen in Figure 11, a smooth graphic could not be obtained. The reason for this is that, as mentioned in the Composite Simpson's method section in the preparatory work section, the method calculates using double intervals. Since the upper limit of the series sum is n/2 and (n/2)-1, even if the loop value is increased, the same series sum as the previous step will be obtained. Although the series totals are made in two different ways, a completely smooth graph could not be reached. Since only Composite Simpson's method was requested to calculate the integral, a different method was not used.

The integral can be calculated using equation 3. Since the calculation made in this way will be a direct result, it can be used as a real value in the error calculation.  

![12](/images/12.jpg)  

As seen in Figure 12, the operation could be performed in a single for loop. The formula is applied in the for loop and added to the 4th column of the matrix named "integral".  

![13](/images/13.jpg)  

As can be seen in Figure 13, the graphic is as it should be. This graphic was tried to be obtained with the 3 methods used.

If the graphs obtained by 4 methods are compared:  

![14](/images/14.jpg)  

When Figure 14 is observed, it can be seen that the best converging method is the Composite Trapezoidal method. The reason for this is that the other 2 methods cannot be used as desired. In fact, a better convergence of Composite Simpson's method was expected.  

![15](/images/15.jpg)  

In Figure 15, it is aimed to show the energy of each method in the time period when the energy obtained in the 3rd equation is the highest. The 1st column was obtained by the Composite Midpoint method, the 2nd column by the Composite Trapezoidal method, the 3rd column by the Composite Simpson's method, and the 4th by the 3rd equation. The time interval considered is 0.125 s. It is seen that the method that best converges to the highest energy value is the Composite Trapezoidal method.  

![16](/images/16.jpg)  

In Figure 16, the energies obtained in the last time interval, ie 1 s, are given. Column information is as written in the previous paragraph. At this point, it is seen that the best convergent method is the Composite Trapezoidal method. The reasons for this situation are given in the previous paragraphs.  

**<h1>Errors</h1>**  

Norm command has been used for error analysis. The results obtained in the third equation were taken as basis and error analysis of other methods was made according to these results.  

![17](/images/17.jpg)  

Looking at the errors obtained, it was seen that the best Composite Trapezoidal method converged. It has been written in the previous paragraphs that it should not be the case and why it is. It should also be said that the error rates are not at an acceptable level.

Looking at the errors obtained, it was seen that the best Composite Trapezoidal method converged. It has been written in the previous paragraphs that it should not be the case and why it is. It should also be said that the error rates are not at an acceptable level. However, it was tried to be applied to what the rules and requirements required and codes were tried to be written in accordance with the rules. I would also like to submit that the homework is carried out entirely by my individual work and effort.
