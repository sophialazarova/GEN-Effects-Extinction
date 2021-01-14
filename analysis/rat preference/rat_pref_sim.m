function rat_pref_sim(subj)
    ext_1 = subj.pick_trials(101:133);
    ext_2 = subj.pick_trials(134:166);
    ext_3 = subj.pick_trials(167:200);

    corr_ext1 = ext_1.filter_trials('response','1');
    incorr_ext1 = ext_1.filter_trials('response','-1');
    omi_ext1 = ext_1.filter_trials('response','0');


    corr_ext2 = ext_2.filter_trials('response','1');
    incorr_ext2 = ext_2.filter_trials('response','-1');
    omi_ext2 = ext_2.filter_trials('response','0');

    corr_ext3 = ext_3.filter_trials('response','1');
    incorr_ext3 = ext_3.filter_trials('response','-1');
    omi_ext3 = ext_3.filter_trials('response','0');

    corr1 = length(corr_ext1.trials)/33;
    corr2 = length(corr_ext2.trials)/33;
    corr3 = length(corr_ext3.trials)/34;

    incorr1 = length(incorr_ext1.trials)/33;
    incorr2 = length(incorr_ext2.trials)/33;
    incorr3 = length(incorr_ext3.trials)/34;

    omi1 = length(omi_ext1)/33;
    omi2 = length(omi_ext2)/33;
    omi3 = length(omi_ext3)/34;
    
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
    legend('Proportion of learned', 'Proportion of alternative', 'Proportion of omission');
    %txt = '**';
    %text(2.5,0.52,txt,'FontSize',15, 'HorizontalAlignment','center', 'Color', [0 0.4470 0.7410]);
end

