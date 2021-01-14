function avg_cumsum(rats, target_trials, sim)
    db = [];
    vals = zeros(1,80);
    
    if(sim)
        vals = zeros(1,250);
    end
    
    if(~isempty(target_trials))
        vals = zeros(1,target_trials(2)-target_trials(1)+1);
    end
    
    for rat_index=1:length(rats)
        subj = rats(rat_index);
        if(isempty(target_trials))
            db = subj;
            if(~(sim))
                db = subj.pick_trials(1:80);
            end
        else
            db = subj.pick_trials(target_trials(1):target_trials(2));
        end
        
        for trials_index=1:length(db.trials)
            if(isempty(db.trials(trials_index).values))
                vals(trials_index) = vals(trials_index);
            else            
                if(sim)
                    val = db.trials(trials_index).values{2};
                    vals(trials_index) = vals(trials_index)+str2num(val);

                else
                    val = db.trials(trials_index).values{6};
                    if(val == -2)
                        val = 0;
                    end

                    vals(trials_index) = vals(trials_index)+val;
                end    
            end
        end
    end
    
    vals = vals/length(rats);
    
    csum = cumsum(vals);
    plot(csum, '-', 'Color', 'r','LineWidth',6);
end

