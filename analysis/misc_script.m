%% ====== Import data ======
% rat_01_sim = import_sdata('./data_json/real_01.json','sim_01');
% rat_02_sim = import_sdata('./data_json/real_02.json','sim_02');
% rat_03_sim = import_sdata('./data_json/real_03.json','sim_03');
% rat_04_sim = import_sdata('./data_json/real_04.json','sim_04');
% rat_05_sim = import_sdata('./data_json/real_05.json','sim_05');


%% ====== Sample level analysis ======
% rats = [rat_1, rat_11, rat_2, rat_4, rat_5, rat_12, rat_13, rat_15, rat_16, rat_17, rat_23, rat_26, rat_27, rat_28, rat_31, rat_32];

% for index=1:length(subjs_sim)
%     subplot(3,2,index);
%     rat_pref_sim(subjs_sim(index),titles_sim(index));
% end
% 
% title('Smooth transition')

% for index=1:length(red)
%     subplot(2,3,index);
%     cumsum_ext(red(index),'');
% end

% 
% figure
% subplot(2,2,1);
% choice_pref(rats);
% subplot(2,2,2);
% choice_pref_sim(subjs_sim);

% subplot(2,2,3);
% ext_pref(rats);
% subplot(2,2,4);
% ext_pref_sim(subjs_sim);

% sgtitle('Choice Preference');

%% ====== Smooth vs. abrupt trasitions (for Examples) ======
% rats_smooth = [rat_32, rat_31];
% rats_abrupt = [rat_27, rat_15];
% 
% titles_abrupt = {'rat 27', 'rat 15'};
% titles_smooth = {'rat 4', 'rat 31'};
% 
% counter = 0;
% 
% figure
% for index=1:length(rats_smooth)
%     subplot(2,2,index+counter);
%     cumsum_ext(rats_smooth(index),titles_smooth(index));
%     subplot(2,2,index+1+counter);
%     plot_cumsum(rats_smooth(index),titles_smooth(index))
%     counter = counter + 1;
% end
% 
% sgtitle('Smooth Transition');
% 
% figure
% 
% counter = 0;
% for index=1:length(rats_abrupt)
%     subplot(2,2,index+counter);
%     cumsum_ext(rats_abrupt(index),titles_abrupt(index));
%     subplot(2,2,index+1+counter);
%     plot_cumsum(rats_abrupt(index),titles_abrupt(index))
%     counter = counter + 1;
% end
% 
% sgtitle('Abrupt Transition');



%% ====== Average smooth & abrupt curves in rats (In the text this figure is combined with the examples)========

% rats_smooth = [rat_2, rat_4, rat_5, rat_12, rat_13, rat_23, rat_26, rat_27, rat_28, rat_32, rat_32, rat_31];
% rats_abrupt = [rat_1, rat_27, rat_15];
% 
% figure
% 
% for index=1:length(rats_abrupt)
%     plot_cumsum(rats_abrupt(index),[41 80],0);
%     hold on
% end
% avg_cumsum(rats_abrupt,[41 80]);
% title('Abrupt Transition');
% ext_line = xline(20,'--r',{'Extinction'});
% ren_line = xline(35,'--r',{'Renewal'});
% ext_line.LabelVerticalAlignment = 'bottom';
% ren_line.LabelVerticalAlignment = 'bottom';
% ylim([1;30]);
% xticks([]);
% xlabel('');
% 
% figure
% 
% for index=1:length(rats_smooth)
%     plot_cumsum(rats_smooth(index),[41 80],0);
%     hold on
% end
% avg_cumsum(rats_smooth,[41 80]);
% title('Smooth Transition');
% 
% ext_line = xline(20,'--r',{'Extinction'});
% ren_line = xline(35,'--r',{'Renewal'});
% ext_line.LabelVerticalAlignment = 'bottom';
% ren_line.LabelVerticalAlignment = 'bottom';
% ylim([1;30]);
% xticks([]);
% xlabel('');

%% ====== Average learning curves in rats vs simulated data ======

% figure
% subjs_sim = [rat_01_sim, rat_02_sim, rat_03_sim, rat_04_sim, rat_05_sim];
% 
% for index=1:length(subjs_sim)
%     plot_cumsum(subjs_sim(index),[],1);
%     hold on
% end
% 
% avg_cumsum(subjs_sim,[],1);
% title('Simulated subjects');
% 
% ext_line = xline(100,'--r',{'Extinction'});
% ren_line = xline(200,'--r',{'Renewal'});
% ext_line.LabelVerticalAlignment = 'bottom';
% ren_line.LabelVerticalAlignment = 'bottom';
% ylim([0;110]);
% xticks([1 100 200 250]);
% xticklabels({'1','100','200','250'});
% xlabel('Trial no');
% 
% figure
% subjs = [rat_2, rat_4, rat_5, rat_12, rat_13, rat_23, rat_26, rat_27, rat_28, rat_32, rat_32, rat_31, rat_1, rat_27, rat_15];
% 
% for index=1:length(subjs)
%     plot_cumsum(subjs(index),[],0);
%     hold on
% end
% 
% avg_cumsum(subjs,[],0);
% title('Rats');
% 
% ext_line = xline(60,'--r',{'Extinction'});
% ren_line = xline(75,'--r',{'Renewal'});
% ext_line.LabelVerticalAlignment = 'bottom';
% ren_line.LabelVerticalAlignment = 'bottom';
% ylim([0;80]);
% xticks([1 60 75 80]);
% xlim([1;80]);
% xticklabels({'1','60','75','80'});
% xlabel('Trial no');


%% ====== Alternative vs. Omission dominant ======

% figure

% subplot(1,2,1);
% plot_cumsum(rat_28,[61 75],0);
% subplot(1,2,2);
% rat_pref(rat_28,'rat-28')
% 
% 
% sgtitle('Alternative dominant behavior in rat-28');

% figure 
% 
% titles = {'sim-1', 'sim-2', 'sim-3', 'sim-4', 'sim-5'};
% 
% for index=1:length(subjs_sim)
%     subplot(2,5,index);
%     plot_cumsum(subjs_sim(index),[101 200],1);
%     title(titles(index));
%     ylim([0 55]);
%     set(gca,'XTick',1:50:length(subjs_sim(index).trials));
%     xticks([1 25 50 75 100]);
%     xticklabels({'1','25','50','75','100'});
%     yticks([1 25 55]);
%     yticklabels({'1','25','55'});
% end 
% 
% for index=1:length(subjs_sim)
%     subplot(2,5,index+5);
%     rat_pref_sim(subjs_sim(index));
%     title(titles(index));
% end



%% no extinction

% rat_sample = [rat_12, rat_23, rat_26];
% 
% figure 
% subplot(1,2,1);
% for index=1:length(rat_sample)
%     rat_pref(rat_sample(index));
%     hold on
% end
% 
% ylim([0.4 1.0]);
% title("Proportion of learned choices increases");

% subplot(1,2,2);
% for index=1:length(rat_sample)
%     plot_cumsum(rat_sample(index),[],0);
%     hold on
% end

% avg_cumsum(rat_sample,[],0);

% ext_line = xline(60,'--r',{'Extinction'});
% ren_line = xline(75,'--r',{'Renewal'});
% ext_line.LabelVerticalAlignment = 'bottom';
% ren_line.LabelVerticalAlignment = 'bottom';
% ylim([0;60]);
% xticks([]);
% xlim([1;80]);
% xlabel('');
% title("Cumulative curves: rat-12, rat-23, rat-26");
% 
% sgtitle('Rats not exhibiting extinction');


% figure
% subplot(1,2,1);
% rat_pref_sim(rat_05_sim);
% title("Proportion of learned choices increases");
% ylim([0.4 1.0]);
% 
% subplot(1,2,2);
% plot_cumsum(rat_05_sim,[],1);
% ext_line = xline(100,'--r',{'Extinction'});
% ren_line = xline(200,'--r',{'Renewal'});
% ext_line.LabelVerticalAlignment = 'bottom';
% ren_line.LabelVerticalAlignment = 'bottom';
% xlabel('');
% xticks([]);
% title("Cumulative curve");
% sgtitle('Sim-05 ');

%% learning curves all subjects

rats = [rat_1, rat_11, rat_2, rat_4, rat_5, rat_12, rat_13, rat_15, rat_16, rat_17, rat_23, rat_26, rat_27, rat_28, rat_31, rat_32];

rats_titles = {'rat-1', 'rat-11', 'rat-2','rat-4','rat-5','rat-12','rat-13','rat-15','rat-16','rat-17','rat-23','rat-26','rat-27','rat-28','rat-31','rat-32'};
sim_titles = {'sim-1', 'sim-2', 'sim-3', 'sim-4', 'sim-5'};
figure


for index=1:length(subjs_sim)
    subplot(3,2,index);
    plot_cumsum(subjs_sim(index),[],1);
    title(sim_titles(index));
    ext_line = xline(100,'--r',{'Extinction'});
    ren_line = xline(200,'--r',{'Renewal'});
    ext_line.LabelVerticalAlignment = 'bottom';
    ren_line.LabelVerticalAlignment = 'bottom';
    xlabel('Trial no');
    xticks([1 100 200 250]);
    yticks([1  30  60 90  120]);
    yticklabels({'1'  '30'  '60' '90'  '120'});
    ylim([1 115]);
    xticklabels({'1' '100' '200' '250'});
end
sgtitle('Learning curves (Simulated data)');