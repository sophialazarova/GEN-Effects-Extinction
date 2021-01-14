import bpy
from bge import logic
from mathutils import Matrix

import numpy as np
import math

import time

from model import AssociativeAgent

import json

moves = []
trajectories = []
nextMove = 0

a= np.array([[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]])  #np.random.random_sample((3,4)) + 5 #np.array([[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]]) 
b = np.array([[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]])  #np.random.random_sample((3,4)) + 5 #np.array([[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]]) 

agent = AssociativeAgent(a,b,np.copy(a),np.copy(b))

trialStartTime = time.time()

rewards_1 = np.ones(100)
rewards_ext = np.zeros(100)
rewards_renewal = np.zeros(50)
rewards_all = np.concatenate((rewards_1, rewards_ext, rewards_renewal), axis=None)

trial_no = 0

increase_trial_no = 1

isAgentOutOfHouse = 0


# <Vector (6.6335, 0.0192, 0.4242)> start position
def main(cont):
    global nextMove
    global rewards_all

    #runTrial(rewards_all[trial_no],1)

    #Extinction change context!
    if trial_no>100 and trial_no<=200:     
        runTrial(rewards_all[trial_no],1)
    else:
        runTrial(rewards_all[trial_no],0)
    
        
def runTrial(reward, ctx): 
    global agent
    global increase_trial_no
    global isAgentOutOfHouse
    
    if increase_trial_no:    
        agent.trial_no += 1
        increase_trial_no = 0
        
    controller = logic.getCurrentController()
    owner = controller.owner
    
    proximityData = getProximityData(controller)
    stimuli = np.array([[proximityData.get('distFront'),proximityData.get('distLeft'),proximityData.get('distRight'),ctx]]).T
    nextMoveData = agent.getNextMove(stimuli)
    nextMove = nextMoveData[1]
    
    moveAgent(nextMove,controller)
    x_pos = owner.position.x

    if x_pos < 4.0:
        isAgentOutOfHouse = 1
    
    trialState = evalTrialState(controller, trialStartTime)
    isTrialOver = trialState['isTrialOver']
    armChoice = trialState['armChoice']
    
    if isTrialOver and armChoice == 'R' and reward == True:
        print('R reward')
        endTrial(controller, '1', reward)
        agent.reinforceExcWeights()
        agent.reverseInhWeights()
    elif isTrialOver and armChoice == 'R' and reward == False:
        print('R no reward')
        endTrial(controller, '1', reward)
        agent.reverseExcWeights()
        agent.reinforceInhWeights()
    elif isTrialOver and armChoice == 'L':
        print('L')
        endTrial(controller, '-1', reward)
        agent.reverseExcWeights()
        agent.reinforceInhWeights()
    elif isTrialOver and armChoice == 'None':
        print('Omission')
        endTrial(controller, '0', reward)
        agent.reverseExcWeights()
        agent.reinforceInhWeights()
        
        

def getProximityData(controller):
    owner = controller.owner
    
    xRay = controller.sensors["xRay"]
    yRay = controller.sensors["yRay"]
    mYRay = controller.sensors["mYRay"]
    
    hit = xRay.hitPosition
    distX = owner.getDistanceTo(hit)
    
    hitY = yRay.hitPosition
    distY = owner.getDistanceTo(hitY)
    
    hitmY = mYRay.hitPosition
    distmY = owner.getDistanceTo(hitmY)
    
    return {'distFront':normalizeProximimtyData(distX), 'distLeft': normalizeProximimtyData(distmY), 'distRight': normalizeProximimtyData(distY)}

def normalizeProximimtyData(val):
    proximityVal = distanceToProximity(val)
    normalized = (proximityVal - 0.357)/(14.190 - 0.357)
    return normalized

def distanceToProximity(val):
    return (14.190+0.357) - val

def moveAgent(command, controller):
    global moves
    owner = controller.owner
    current_pos = {'x':controller.owner.position.x, 'y':controller.owner.position.y}
    moves.append(current_pos)

    if command == 'R':
        owner.applyRotation([0,0,-.1],0)
    elif command == 'L':
        owner.applyRotation([0,0,.1],0)
        
    owner.applyMovement([-.2, 0, 0],1)
    

def evalTrialState(controller, trialStartTime):
    owner = controller.owner
    y_pos = owner.position.y
    x_pos = owner.position.x
    
    arm = 'None'
    isTrialOver = False
    if y_pos > 4.0:
        isTrialOver = True
        arm = 'R'
    elif y_pos < -4.0:
        isTrialOver = True
        arm = 'L'
    elif time.time() > trialStartTime+90:
        isTrialOver = True
    elif isAgentOutOfHouse and x_pos > 4.0:
        isTrialOver = True
        
    return {'isTrialOver':isTrialOver,'armChoice':arm}
        

def endTrial(controller, response, reward):
    #return agent to start position
    global trialStartTime
    global trial_no
    global rewards_all
    global trajectories
    global moves
    global agent
    global increase_trial_no
    global isAgentOutOfHouse
    
    elapsedTime = time.time() - trialStartTime
    trial_trajectory = {'trajectory':moves, 'response': response, 'reward': str(reward), 'time': str(elapsedTime)}
    trajectories.append(trial_trajectory)
    
    
    print('Trial '+ str(trial_no+1) + ' Ended! | Reward:' + str(rewards_all[trial_no]))
    trial_no += 1
    if trial_no > len(rewards_all)-1:
        print('Simulation over!')
        with open('/Users/sophia/Desktop/coordinates.json', 'w') as f:
            json.dump({'subj_data':trajectories},f)
            
#        print('Activation')
#        print(agent.activation_print)
#        print('Error')
#        print(agent.error_print)
        logic.endGame()
        
    moves = []
    controller.owner.position = [6.6335, 0.0192, 0.4242]
    reset_rotation = [[1.0000, -0.0000,  0.0000],[0.0000,  1.0000, -0.0000],[0.0000,  0.0000,  1.0000]]
    controller.owner.worldOrientation = reset_rotation
    trialStartTime = time.time()
    
    agent.decay_rows = np.array([0,0,0])
    agent.decay_initial_vals = agent.Wexc
    agent.decay_interations = np.array([0,0,0])
    
    increase_trial_no = 1
    
    isAgentOutOfHouse = 0
    

        

        
        

