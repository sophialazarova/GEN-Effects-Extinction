function rat_pref(subj)
    ext_1 = subj.pick_trials(61:65);
    ext_2 = subj.pick_trials(66:70);
    ext_3 = subj.pick_trials(71:75);

    corr_ext1 = ext_1.filter_trials('response',1);
    incorr_ext1 = ext_1.filter_trials('response',-1);
    omi_ext1 = ext_1.filter_trials('response',0);
    return_ext1 = ext_1.filter_trials('response',-2);
    omi1_trials = [omi_ext1.trials return_ext1.trials]; 

    corr_ext2 = ext_2.filter_trials('response',1);
    incorr_ext2 = ext_2.filter_trials('response',-1);
    omi_ext2 = ext_2.filter_trials('response',0);
    return_ext2 = ext_2.filter_trials('response',-2);
    omi2_trials = [omi_ext2.trials, return_ext2.trials]; 

    corr_ext3 = ext_3.filter_trials('response',1);
    incorr_ext3 = ext_3.filter_trials('response',-1);
    omi_ext3 = ext_3.filter_trials('response',0);
    return_ext3 = ext_3.filter_trials('response',-2);
    omi3_trials = [omi_ext3.trials return_ext3.trials]; 

    corr1 = length(corr_ext1.trials)/5;
    corr2 = length(corr_ext2.trials)/5;
    corr3 = length(corr_ext3.trials)/5;

    incorr1 = length(incorr_ext1.trials)/5;
    incorr2 = length(incorr_ext2.trials)/5;
    incorr3 = length(incorr_ext3.trials)/5;

    omi1 = length(omi1_trials)/5;
    omi2 = length(omi2_trials)/5;
    omi3 = length(omi3_trials)/5;
    
    corr_data = [corr1 corr2 corr3];
    incorr_data = [incorr1 incorr2 incorr3];
    omi_data = [omi1 omi2 omi3];
    
    plot(corr_data,'-*');
    hold on
    plot(incorr_data, '-*');
    hold on;
    plot(omi_data, '-*');
    
    ylim([0.0; 1.0]);
    yticks([0 0.2 0.4 0.6 0.8 1]);
    xlim([0.5;3.5]);
    xticks([1 2 3]);
    xticklabels({'Onset', 'Mid', 'End'});
    xlabel('Extinction Progress');
    ylabel('Proportion','Interpreter','none');
    title('Choice proportion');
    legend('Proportion of learned', 'Proportion of alternative', 'Proportion of omission');
    %txt = '**';
    %text(2.5,0.52,txt,'FontSize',15, 'HorizontalAlignment','center', 'Color', [0 0.4470 0.7410]);
end

