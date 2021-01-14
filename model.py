import numpy as np
import random
import math


class AssociativeAgent:
    
    def __init__(self, Wexc, Winh, Wexc_in, Winh_in):
        self.Wexc = Wexc #current weights
        self.Winh = Winh
        self.Wexc_last = Wexc_in #last reinforced weights, needed for reset.
        self.Winh_last = Winh_in
        
        self.decay_rows = np.array([0,0,0])
        self.decay_initial_vals = Wexc
        self.decay_interations = np.array([0,0,0])
        
        self.decay_rows_inh = np.array([0,0,0])
        self.decay_initial_vals_inh = Winh
        self.decay_interations_inh = np.array([0,0,0])
        self.trial_no = 0
        self.tar_trials = [3,5,10,20,30,40,50,60,70,80,90,100];
        
        self.activation_print = []
        self.error_print = []
        self.ext_print = []
        self.inh_print = []
        
    
    def getNextMove(self, stimuli): #
        commands = np.array(['F','L','R'])
        commandsNum = np.array([0,1,2])
            
        err = np.array([[np.random.uniform(0.00,0.15),np.random.uniform(0.00,0.15),np.random.uniform(0.00,0.15)]]).T
        
        activation_u = self.Wexc@stimuli-self.Winh@stimuli
        
        if self.trial_no in self.tar_trials:
#            self.activation_print.append(activation_u)
#            self.error_print.append(err)
#            self.ext_print.append(self.Wexc)
#            self.inh_print.append(self.Winh)
            self.tar_trials.remove(self.trial_no)
            print("Target Trial ", self.trial_no)

        motorInput_m = self.ReLU(activation_u + err) # try without Relu
        
        
        motorInput_max = max(motorInput_m)
        commandIndex = np.where(motorInput_m == motorInput_max)
        nextCommand = commands[commandIndex[0][0]]
        nextCommandNum = commandsNum[commandIndex[0][0]]
    
        if motorInput_max <= 0:
            print('random command')
            commandIndex = random.randint(0,2)
            nextCommand = commands[commandIndex]
            nextCommandNum = commandsNum[commandIndex]
            
        self.updateWeights(nextCommandNum, stimuli)
        
        return ((self.Wexc,self.Winh),nextCommand)
        
    
    def ReLU(self, inputVector):
        input_t = inputVector.T
        inputVals = input_t[0]
        indecesNotPassed = np.where(input_t[0]<0)
        inputVals[indecesNotPassed[0]] = 0
        
        return inputVector # all operation are by reference therefore outputvector will originally hold same values as inputvector
    
    
    def reinforceExcWeights(self):
        self.Wexc_last = np.copy(self.Wexc)
        
        
    def reinforceInhWeights(self):
        self.Winh_last = np.copy(self.Winh)
        
        
    def reverseExcWeights(self):
        self.Wexc = np.copy(self.Wexc_last)
        
        
    def reverseInhWeights(self):
        self.Winh = np.copy(self.Winh_last)
        
        
    def updateWeights(self, nextCommand, stimuli):
        #stimuli -> Front, Left, Right, Ctx
        LEARNING_RATE = 0.000001#0.0007
        W_MAX = 20.0
        DECAY_CONST = 0.0000009#0.999999 #1/4.23
        
        LEARNING_RATE_INH = 0.0000004
        DECAY_CONST_INH = 0.0000009#0.999999
        
        # DECAY WEIGHTS (SLOWLY FORGETTING ON EVERY ITERATION)
        if np.in1d(1,self.decay_rows):
            for row in range(len(self.decay_rows)):
                if self.decay_rows[row] == 1:
                    for col in range(len(self.Wexc[0])):
                        iteration_num = self.decay_interations[row]
                        initial_val = self.decay_initial_vals[row,col]
                        decay_val = initial_val*math.exp(-DECAY_CONST*iteration_num)
                        self.Wexc[row,col] = decay_val
                    
                    self.decay_interations[row] += 1
                    
        if np.in1d(1,self.decay_rows_inh):
            for row in range(len(self.decay_rows_inh)):
                if self.decay_rows_inh[row] == 1:
                    for col in range(len(self.Winh[0])):
                        iteration_num = self.decay_interations_inh[row]
                        initial_val = self.decay_initial_vals_inh[row,col]
                        decay_val = initial_val*math.exp(-DECAY_CONST_INH*iteration_num)
                        self.Winh[row,col] = decay_val
                    
                    self.decay_interations_inh[row] += 1
                    
         # UPDATING WEIGHTS FOR CURRENT ITERATION       
        for col in range(len(self.Wexc[0])):
            w_delta = LEARNING_RATE*(W_MAX - self.Wexc[nextCommand,col])#LEARNING_RATE*(W_MAX - self.Wexc[nextCommand,col])
            self.Wexc[nextCommand,col] = self.Wexc[nextCommand,col] + w_delta
            
        for col in range(len(self.Winh[0])):
            w_delta = LEARNING_RATE_INH*(W_MAX - self.Winh[nextCommand,col])#LEARNING_RATE*(W_MAX - self.Wexc[nextCommand,col])
            self.Winh[nextCommand,col] = self.Winh[nextCommand,col] + w_delta
           
        # UPDATING DECAY DATA POST ITERATION    
        self.decay_rows[nextCommand] = 1
        self.decay_interations[nextCommand] = 1
        self.decay_initial_vals = self.Wexc
        
        self.decay_rows_inh[nextCommand] = 1
        self.decay_interations_inh[nextCommand] = 1
        self.decay_initial_vals_inh = self.Winh
    
            
        
