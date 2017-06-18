import numpy as np
from numpy import *
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# y = mx + b
# m is slope, b is y-intercept
def compute_error_for_line_given_points(b, m, points):
    totalError = 0
    for i in range(0, len(points)):
        x = points[i, 0]
        y = points[i, 1]
        totalError += (y - (m * x + b)) ** 2
    return totalError / float(len(points))

def step_gradient(b_current, m_current, points, learningRate):
    b_gradient = 0
    m_gradient = 0
    N = float(len(points))
    for i in range(0, len(points)):
        x = points[i, 0]
        y = points[i, 1]
        b_gradient += -(2/N) * (y - ((m_current * x) + b_current))
        m_gradient += -(2/N) * x * (y - ((m_current * x) + b_current))
    new_b = b_current - (learningRate * b_gradient)
    new_m = m_current - (learningRate * m_gradient)
    return [new_b, new_m]

def gradient_descent_runner(points, starting_b, starting_m, learning_rate, num_iterations):
    b = [starting_b]
    m = [starting_m] 
    err = []
    for i in range(num_iterations):
        b.append(step_gradient(b[i-1], m[i-1], array(points), learning_rate)[0])
        m.append(step_gradient(b[i-1], m[i-1], array(points), learning_rate)[1])
        print "After {0} iterations b = {1}, m = {2}, error = {3}".format(i, b[i]                                                                   , m[i],compute_error_for_line_given_points(b[i],m[i], points))
        
        err.append(compute_error_for_line_given_points(b[i],m[i], points))
    return [b, m, err] 

if __name__ == '__main__':
    
    points = genfromtxt("data.csv", delimiter=",")
    learning_rate = 0.00001
    initial_b = 0 # initial y-intercept guess
    initial_m = 0 # initial slope guess
    num_iterations = 1000
    
    fig, ax = plt.subplots()
    x1 = np.arange(0,num_iterations)
    
    print "Starting gradient descent at b = {0}, m = {1}, error = {2}".format(initial_b, initial_m, compute_error_for_line_given_points(initial_b, initial_m, points))
    
    print "Running..."
    [b, m, err] = gradient_descent_runner(points, initial_b, initial_m, learning_rate, num_iterations)
    
    plt.plot(x1, err, c='b')
    plt.title('error curve')
    plt.xlabel('No of iterations')
    plt.ylabel('Error')
    plt.show()
    
