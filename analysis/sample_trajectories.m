function sample_trajectories(rat,rat_sim)

    figure
    trials_ind = [1,4,67,6,79,75,1,7,92,2,8,18];
    titles = {'Correct', 'Incorrect', 'Omission','Correct','Incorrect', 'Omission', 'Correct', 'Incorrect', 'Omission','Correct','Incorrect','Omission'};
    for index=1:6
        
        subplot(4,3,index)
        arm_entry = find_event(3,rat.trials(trials_ind(index)),rat.metadata,0);
        sliced = rat.trials(trials_ind(index)).trajectory.time_slice([0 arm_entry+2]);
        if(isnan(arm_entry))
            %house_reentry = find_event(6,rat.trials(trials_rat(index)),rat.metadata,0);
            %sliced = rat.trials(trials_rat(index)).trajectory.time_slice([0 house_reentry]);
            plot(rat.trials(trials_ind(index)).trajectory.x,rat.trials(trials_ind(index)).trajectory.y,'*');
        else
            plot(sliced.x,sliced.y,'*');
        end
        
        xlim([50 350]);
        ylim([15 400]);
        xticks([]);
        yticks([]);
        title(titles(index));
    end
    
    for index=7:12
        subplot(4,3,index)
        plot(rat_sim.trials(trials_ind(index)).trajectory.x,rat_sim.trials(trials_ind(index)).trajectory.y,'*', 'Color', [0.8500 0.3250 0.0980]);
        
        xlim([-5 5]);
        ylim([-7 8]);
        xticks([]);
        yticks([]);
        title(titles(index));
    end
    
    sgtitle('Examples of Trial Trajectories');
end

