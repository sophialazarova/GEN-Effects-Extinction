function srat = parse_srat(srat_raw, subj_name)
%PARSE_SRAT Logic for parsing a json decoded rat object produced by the
%Blender simulation.
%INPUT:
%srat_raw, obj - raw rat data
%OUT:
%srat, type DataBlock - parsed rat object
    trials = [];
    for index=1:length(srat_raw.subj_data)
        data_patch = srat_raw.subj_data(index);
        current_trial = Trial([]);
        current_trial.index = index;
        
        current_trial.label = subj_name;
        current_trial.annotations = {'reward', 'response', 'time'};
        current_trial.values = {data_patch.reward, data_patch.response, data_patch.time};
        current_trial.t_onsets = {0,0,0};
        
        xpos = [];
        ypos = [];
        
        %fieldname = strcat('trial', num2str(index));
        for datapoint=1:length(data_patch.trajectory)
            xpos = [xpos data_patch.trajectory.y];
            ypos = [ypos data_patch.trajectory.x];
        end
        
        xpos = -1*xpos;
        pos = [xpos' ypos'];
        theta = 180; % to rotate 90 counterclockwise
        R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];

        for row=1:length(pos)
            point = [pos(row, 1) pos(row, 2)];
            rotPoint = point*R;
           pos(row, 1) = rotPoint(1);
           pos(row, 2) = rotPoint(2);
        end
        
        current_trial.trajectory = Trajectory(pos(:,1), pos(:,2), [], [], [], 'blender units', 1, '');
        
        
        trials = [trials current_trial];
    end

    srat = DataBlock();
    srat.description = 'Simulated T-maze Rat Data';
    srat.trials = trials;
    srat.metadata = MetaData();
    srat.metadata.annotations = {'subj_id'};
    srat.metadata.values = {subj_name};
end

