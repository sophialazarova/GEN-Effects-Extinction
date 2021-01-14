function choice_pref(subjs)

acq_2 = [];
ext_2 = [];
ren = [];

acq_inc = [];
ext_inc = [];
ren_inc = [];

acq_count = 0;
ext_count = 0;
ren_count = 0;

acq_count_i = 0;
ext_count_i = 0;
ren_count_i = 0;

    for index=1:length(subjs)
        current_subj = subjs(index);
        acq_trials_2 = current_subj.pick_trials(51:100);
        ext_trials_2 = current_subj.pick_trials(151:200);
        ren_trials = current_subj.pick_trials(201:210);
        
        corr_acq_2 = acq_trials_2.filter_trials('response','1');
        incorr_acq_2 = acq_trials_2.filter_trials('response','-1');
        
        corr_ext_2 = ext_trials_2.filter_trials('response','1');
        incorr_ext_2 = ext_trials_2.filter_trials('response','-1');
        
        corr_ren = ren_trials.filter_trials('response','1');
        incorr_ren = ren_trials.filter_trials('response','-1');
        
        acq_2 = [acq_2 length(corr_acq_2.trials)/50];
        ext_2 = [ext_2 length(corr_ext_2.trials)/50];
        ren = [ren length(corr_ren.trials)/10];
        
        acq_count = acq_count + length(corr_acq_2.trials);
        ext_count = ext_count + length(corr_ext_2.trials);
        ren_count = ren_count + length(corr_ren.trials);
        
        acq_inc = [acq_inc length(incorr_acq_2.trials)/50];
        ext_inc = [ext_inc length(incorr_ext_2.trials)/50];
        ren_inc = [ren_inc length(incorr_ren.trials)/10];
        
        acq_count_i = acq_count_i + length(incorr_acq_2.trials);
        ext_count_i = ext_count_i + length(incorr_ext_2.trials);
        ren_count_i = ren_count_i + length(incorr_ren.trials);
    end
    
    
    err_acq_corr = std(acq_2)/sqrt(length(acq_2));
    err_ext_corr = std(ext_2)/sqrt(length(ext_2));
    err_ren_corr = std(ren)/sqrt(length(ren));
    
    acq_prop_corr = sum(acq_2)/length(acq_2);
    ext_prop_corr = sum(ext_2)/length(ext_2);
    ren_prop_corr = sum(ren)/length(ren);
    
    err_acq_inc = std(acq_inc)/sqrt(length(acq_inc));
    err_ext_inc = std(ext_inc)/sqrt(length(ext_inc));
    err_ren_inc = std(ren_inc)/sqrt(length(ren_inc));
    
    acq_prop_inc = sum(acq_inc)/length(acq_inc);
    ext_prop_inc = sum(ext_inc)/length(ext_inc);
    ren_prop_inc = sum(ren_inc)/length(ren_inc);
     
    
    data_corr = [acq_prop_corr,ext_prop_corr,ren_prop_corr];
    data_inc = [acq_prop_inc,ext_prop_inc,ren_prop_inc];
    
    error_corr = [err_acq_corr,err_ext_corr,err_ren_corr];
    error_inc = [err_acq_inc,err_ext_inc,err_ren_inc];
    
    %figure
    errorbar(data_corr,error_corr);
    hold on
    errorbar(data_inc,error_inc);
    
    
    ylim([0.0; 1.0]);
    yticks([0 0.2 0.4 0.6 0.8 1]);
    xlim([0.5;3.5]);
    xticks([1 2 3]);
    xticklabels({'Acquisition', 'Extinction', 'Renewal'});
    ylabel('Proportion');
    title('Across Phases (simulation)');
    legend('Preference for learned choice', 'Preference for alternative choice');
    
    txt = '*';
    txt_2 = '***';
    text(1.6,0.64,txt,'FontSize',15, 'HorizontalAlignment','center', 'Color', [0 0.4470 0.7410]);
    text(1.5,0.29,txt_2,'FontSize',15, 'HorizontalAlignment','center', 'Color', [0.8500 0.3250 0.0980]);
    a=4;
end

