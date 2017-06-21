function [data_matrix] = Spike_analysis3(filename)
%this script is meant to read abf files in a folder, analyze the traces,
%and output the data as a data matrix and a figure

%% this section loads the data and gets rid of traces with EPSPs influencing the IV

data = abfload(filename); %data set: all points in (: in 1st) voltage(#1 in 2nd) and sweeps (3rd)
sweeps = numel(data(1,1,:));
current = -20:10:((sweeps-3)*10); %current values
marked = [zeros(sweeps,1)]; %mark traces for deletion
for n=1:sweeps
    trace = data(:,1,n); %this is the sweep being worked with
    if trace(2600)>-50 || trace(2600)<-70; marked(n)= 1;end %if RMP is not within 10mV of -60, before pulse, mark trace for deletion
    if trace(8100)>-30; marked(n)=1;end %mark the trace for deletion if RMP does not return to <-30mV after pulse (EPSP)
    %look for places where there are large oscilations of membrane
    %potential during current injection (events affected by EPSPs)
    filtered = [];
    for nn=3000:100:7400
        filtered = [filtered; mean(trace(nn:nn+100))]; %the purpose is to average across regions of trace to minimize the effect of quick AP oscillations
    end
    if max(filtered)-min(filtered)>20; marked(n)=1;end
    %this next bit uses the slope of the AP to identify traces with APs
    slope = [];
    for nn=2670:7700
        slope = [slope; (trace(nn+1)-trace(nn))]; %find the slope for all points in the trace
    end
    if max(slope)<1.3; marked(n)=1;end %if slope is not sufficient, mark for deletion
end

% delete marked traces
n=1;
while sum(marked)>0 %while some traces are still marked for deletion
   if marked(n)==0; n=n+1;
   else data(:,:,n)=[]; marked(n)=[]; current(n)=[];
   end
end

%% this section looks for spikes
data_matrix = []; %store all data from loop in data matrix
sweeps = numel(data(1,1,:));
for n=1:sweeps
    trace = data(2670:7850,1,n);
    slope = [];
    for nn=1:5130
        slope = [slope; (trace(nn+1)-trace(nn))]; %find the slope for all points in the trace
    end
    
    %this section parses through the slope file to identify points where
    %rise slope is >1mv/point
    prelim_spikes = []; %matrix for spikes
    nn=1;
    while nn<4980 %parse through the trace by region to identify spikes
        region = slope(nn:nn+40); %region of interest being searched
        [val loc] = max(region); %find max in region
        if val>1 
            region = slope(nn:nn+50); %widen range a little bit to ensure catching the top of the slope
            [val loc] = max(region); %find the max in the new region
            prelim_spikes = [prelim_spikes; nn+loc-1];
            nn=nn+50;
        else nn=nn+40;
        end
    end
    %now analyze the last fragment for an additional spike and tag onto
    %prelim_spikes
    region = slope((nn):5030);
    [val loc] = max(region); %find max in region
    if val>1  %widen range a little bit to ensure catching the top of the slope
        prelim_spikes = [prelim_spikes; nn+loc-41];
    end
    
    % this next section refines the prelim_spikes to get rid of artifacts
    % that kind of look like spikes (done by looking for neg slope after
    % spike)
    marked = [zeros(numel(prelim_spikes),1)]; %mark spikes for deletion
    for nn=1:numel(prelim_spikes);
        val = min(slope(prelim_spikes(nn):(prelim_spikes(nn)+20)));
        if val>-.5
            marked(nn)=1;
        end
    end
    
    nn=1;
    while sum(marked)>0 %while some traces are still marked for deletion
        if marked(nn)==0; nn=nn+1;
        else marked(nn)=[]; prelim_spikes(nn)=[];
        end
    end
   
    %this next section identifies where the AP starts, the top of the AP,
    %and the bottom of the AP
    
    %make parameter matrixes for loop
    start_matrix = [];
    top_matrix = [];
    bottom_matrix = [];
    for nn=1: numel(prelim_spikes)
        %find values
        start = find(slope((prelim_spikes(nn)-10):prelim_spikes(nn))>.5,1);
        start = start-11+prelim_spikes(nn);
        [top, toploc] = max(trace(start:start+20));
        toploc = toploc+start-1;
        [bottom, bottomloc] = min(trace(start:start+90));
        bottomloc = bottomloc+start-1;
        if bottomloc>5030; bottomloc = []; end %if bottom of AP cannot be found because current injection ends, delete bottom
        %load matrixes
        start_matrix = [start_matrix; start];
        bottom_matrix = [bottom_matrix; bottomloc];
        top_matrix = [top_matrix; toploc];
    end
    
    AP_duration = [];
    for nn=1:numel(bottom_matrix)
        AP_duration = [AP_duration; bottom_matrix(nn)-start_matrix(nn)];
    end
    
    %analyze number of spikes, delay to first spike and (if applicable)
    %interspike interval
    spikenum = numel(start_matrix);
    first_spike_delay = 7+start_matrix(1);
    inter_spike_interval = []; %time between peaks
    inter_spike_duration = []; %time from trough to rheobase between spikes
    if spikenum>1
        for nn=1:(spikenum-1)
            inter_spike_interval = [inter_spike_interval; top_matrix(nn+1)-top_matrix(nn)];
        end
        for nn=1:numel(bottom_matrix)-1
            inter_spike_duration = [inter_spike_duration; start_matrix(nn+1)-bottom_matrix(nn)];
        end
    end
            
    %write a section to export loop data (need to think about how)
    isi = mean(inter_spike_interval);
    isd = mean(inter_spike_duration);
    apd = mean(AP_duration);
    
    data_matrix = [data_matrix; current(n), spikenum, first_spike_delay, isi, apd, isd]; 
    
    %write a figure showing measurements
    figure;
    plot(trace);
    hold on
    scatter(start_matrix,trace(start_matrix),'g');
    scatter(top_matrix,trace(top_matrix),'k');
    scatter(bottom_matrix,trace(bottom_matrix),'r');
    ylim([-80 10]);
    
    txt1 = strrep(filename,'\','');
    txt1 = strrep(txt1,'_','');
    text(3000,-60,txt1);
    txt4 = {['current:' int2str(current(n))]};
    text(3000,-65,txt4);
    txt2 = {['spikes:' int2str(spikenum)]};
    text(3000,-70,txt2);
    txt3 = {['delay:' int2str(first_spike_delay)]};
    text(3000,-75,txt3);
    hold off
    saveas(gcf,[filename(1:(end-4)), '_', int2str(current(n)), '.fig']);
    close;
end

