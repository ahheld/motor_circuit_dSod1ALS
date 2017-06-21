%% this is the script to loop through all the spike abfs and write them to an excel sheet
biocells = glob('*1b_*');
for n=1:numel(biocells)
    files = glob([biocells{n} '*.abf']); %find files
    data_array = cell(numel(files),1); %make array to save data
    for nn=1:numel(files)
        data_array{nn} = Spike_analysis3(files{nn}); %save data in array; array is current, spikenumber, first_spike_delay, isi, apd, isd
    end
    %processing to combine data from different traces? possibly do:
    % 1) write each cell to its own spreadsheet
    % 2) write combined data from each cell to summary spreadsheet
    % 3) use summary spreadsheet to identify problematic traces
    average_array = cell(19,1); %combine the data by current sweep
    for nn=1:numel(data_array) %for number of abf files
        for nnn=1:(numel(data_array{nn})/6) %for number of sweeps in abf file
            current_applied = data_array{nn}(nnn,1);
            obj = average_array{(current_applied/10)};
            obj = [obj; data_array{nn}(nnn,:)];
            average_array{(current_applied/10)}=obj;
        end
    end
    
    %make matrixes for extracting data by parameter
    spikenum_cell = cell(1,19);
    first_spike_delay_cell = cell(1,19);
    isi_cell = cell(1,19);
    apd_cell = cell(1,19);
    isd_cell = cell(1,19);
    
    %now average each matrix
    average_cell = cell(19,1);
    
    for nn=1:19
        obj = mean(average_array{nn},1);
        average_cell{nn} = obj; %averaged data
        %now separate data by parameter
        if numel(average_cell{nn})>1
            spikenum_cell{nn} = average_cell{nn}(1,2);
            first_spike_delay_cell{nn} = average_cell{nn}(1,3);
            isi_cell{nn} = average_cell{nn}(1,4);
            apd_cell{nn} = average_cell{nn}(1,5);
            isd_cell{nn} = average_cell{nn}(1,6);
        else
            spikenum_cell{nn} = [];
            first_spike_delay_cell{nn} = [];
            isi_cell{nn} = [];
            apd_cell{nn} = [];
            isd_cell{nn} = [];
        end
    end
            

    %now write averaged data to summary spreadsheets (current, spikenum,
    %first_spike_delay, isi, apd, isd)
    file = 'AP_parameters.xls'; %name the file
    biocell = biocells{n}(1:(end-1)); %name the cell
    
    %spikenumber
    sheet = 'spikenumber'; %name each sheet in turn
    xlswrite(file,{biocell},sheet,['a' int2str(n+1)]); %write cell name
    xlswrite(file,spikenum_cell,sheet,['b' int2str(n+1)]); %write parameter
    
    %first_spike_delay
    sheet = 'first_spike_delay'; %name each sheet in turn
    xlswrite(file,{biocell},sheet,['a' int2str(n+1)]); %write cell name
    xlswrite(file,first_spike_delay_cell,sheet,['b' int2str(n+1)]); %write parameter
    
    %isi
    sheet = 'interspike_interval'; %name each sheet in turn
    xlswrite(file,{biocell},sheet,['a' int2str(n+1)]); %write cell name
    xlswrite(file,isi_cell,sheet,['b' int2str(n+1)]); %write parameter
    
    %apd
    sheet = 'action_potential_duration'; %name each sheet in turn
    xlswrite(file,{biocell},sheet,['a' int2str(n+1)]); %write cell name
    xlswrite(file,apd_cell,sheet,['b' int2str(n+1)]); %write parameter
    
    %isd
    sheet = 'interspike_delay'; %name each sheet in turn
    xlswrite(file,{biocell},sheet,['a' int2str(n+1)]); %write cell name
    xlswrite(file,isd_cell,sheet,['b' int2str(n+1)]); %write parameter
    
    %write all data to each cell's own sheet
    sheet = biocell;
    merged = [];
    for nn = 1:numel(data_array)
        merged = [merged; data_array{nn}];
    end
    xlswrite(file,merged,sheet,'a2');
end
    