%% EPSC analysis
function [analysis_results, amplitude] = EPSC_analysis(file)
trace = abfload(file);
a=2501; %first window is .25s after start to allow for refining of peak
b=a+10000; %takes 1 second chunks
current= trace(:,1);
duration = length(current)/10000;
peaks = [];
base = [];
while b<(numel(current)-5000) %first pass at finding peaks
    if max(current(a:b))-min(current(a:b))>300 & current(b)<current(a) %identifies places where the current changes by more than -100pA
        [peak loc]= min(current(a:b));
        [base baseloc]=max(current(a:b));
        while min(current(b:(b+500)))<(base-100) & b<(numel(current)-5000) %refine EPSC area in 100 point steps, cannot exceed end of trace
            b=b+100;
        end
        [peak loc]= min(current(a:b)); %identifies the peak within the specified range
        peaks = [peaks; peak (loc+a)]; %peak height and location are 1st and 2nd values
        a=b+1;
    else
        base = [base a:b];
        a=a+2500;
    end
    b=a+5000;
end

if numel(peaks)>0
    peaks = [peaks (peaks(:,2))-4000]; %adds a range of points to find a baseline, set to .25s before peak. 3rd value is baseline range
    values = [];

    for n=1:numel(peaks(:,1))
        [c,ind]=max(trace(peaks(n,3):peaks(n,2)));
        values = [values; c ind];
    end

    peaks = [peaks values(:,1), (peaks(:,3)+values(:,2))]; %adds baseline value to 4th column, and baseline location to 5th column
    
    amplitude = peaks(:,4)-peaks(:,1); %calculates amplitude from baseline and peak
    amplitude(amplitude>7000)=[]; %deletes peaks where VC failed
    amplitude(amplitude<300)=[]; %deletes peaks under threshold of 300pA, can be set to higher than 300
    average_amplitude = mean(amplitude);
    event_number = numel(amplitude);
    frequency = event_number/duration*60; %events/min

    analysis_results = [average_amplitude event_number duration frequency];
    
    %plots to make sure peaks are recognized
    figure;
    plot(current);
    hold on
    scatter(peaks(:,2),current(peaks(:,2)),'g') %plots peaks in green
    scatter(peaks(:,5),current(peaks(:,5)),'r') %plots baseline in red
    axis([0,1800000,-6000,0]);
    hold off
    
    
else
    amplitude = {'no EPSCs'};
    analysis_results = [0 0 duration 0];
    plot(current);
end

end