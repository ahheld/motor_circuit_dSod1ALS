%% This script analyzes folders with NMJ data files. It can recognize 1nA current induced RC curves, spontaneous activity, evoked activity, and paired pulse facilitation.
% To use this script, place the data folder (containing sample folders) into the same
% folder as this function. The function will recognize the file type, run
% the analysis, and place the data in an excel spreadsheet.

%% recognize file type and choose proper analysis subfunction

function see_excel_sheet = NMJ_multi_analysis(data_folder) %Data folder is currently named 'Data', so type: NMJ_multi_anlaysis('data')

larva = glob(strcat(data_folder,'\*')); %identify larva samples in data folder
spreadsheet_labels = {'Sample','Baseline','mEPSP amplitude','mEPSP frequency','EPSP amplitude','EPSP Tau','Wbpassed','pp ratio','Resistance','Tau','Capacitance','Rsquare'};
xlswrite('data_out',spreadsheet_labels,'Summary');

for n = 1:numel(larva)
    files = glob(strcat(larva{n},'*.abf')) %identify data files in larva sample folder
    xlswrite('data_out',{strcat(larva{n}(6:(end-1)))},'Summary',strcat('A',int2str(n+1)));
    for o =1:numel(files)
        filetype = identifier(files{o}) %run identifier function to identify file type
        if strcmp(filetype, 'mEPSP'); 
            [meanamp, frequency, amplitude, percentile, IEI]= mEPSP_analysis(files{o});
            xlswrite('data_out',[meanamp, frequency],'Summary',strcat('C',int2str(n+1),':D',int2str(n+1)));
        elseif strcmp(filetype, 'EPSP'); 
            [basemv, peakamp, EPSP_Tau, Wbpassed] = EPSP_analysis(files{o});
            xlswrite('data_out',basemv,'Summary',strcat('B',int2str(n+1)));
            xlswrite('data_out',[peakamp, EPSP_Tau, Wbpassed],'Summary',strcat('E',int2str(n+1),':G',int2str(n+1)));
        elseif strcmp(filetype, 'RC'); 
            [Resistance, Tau, Capacitance, Rsquare] = RC_analysis(files{o});
            xlswrite('data_out',[Resistance, Tau, Capacitance, Rsquare],'Summary',strcat('I',int2str(n+1),':L',int2str(n+1)));
        elseif strcmp(filetype, 'paired_pulse'); 
            [mean_ppratio] = paired_pulse_analysis(files{o});
            xlswrite('data_out',mean_ppratio,'Summary',strcat('H',int2str(n+1)));
        else disp('warning: unknown file type, could not analyze');
        end
    end
end


%% subfunction identifies file type
function filetype = identifier(file)
[d,si,h]= abfload(file,'info');
if si ~= 100
    disp('Warning: data not acquired at 10,00hz. Function will not work properly.');
end

if h.lActualEpisodes ==50; filetype = 'RC';
elseif h.lActualEpisodes == 15; filetype = 'EPSP';
elseif h.lActualEpisodes == 5; filetype = 'paired_pulse';
elseif h.lActualEpisodes == 0; filetype = 'mEPSP';
end
end %end of identifier


%% subfunction analyzes mEPSP files
function [meanamp, frequency, amplitude, percentile, IEI]= mEPSP_analysis(file_in)

trace = abfload(file_in);
trace = trace(:,1);

i=1;
j=1601;

peaks=[];
count=0;
total=0;
stdevs=[];
nopeaks = [];

while j<length(trace) %finds areas of baseline with no peaks
    baseline = mean(trace(i:j));
    [c,ind] = max(trace(i:j));
    dif = c - baseline;
    if dif > .25; %initial pass at finding peaks
        total = total+ind; %shifts roi for next interval
        total = total+400; %shifts roi + 100
        i = total;
    else;
        stdevs = [stdevs std(trace(i:j))];
        nopeaks = [nopeaks i];
        i = i+1600;
        total = total+1600;
    end;
    j = i +1600;
end;


i=1;
j=1601;

peaks=[];
count=0;
total=0;
stdev = mean(stdevs);
fpr = 4 * stdev %false positive rate is set to 4 stdevs (or ~1/15000 are false)

while j<length(trace) %finds areas of baseline with no peaks
        baseline = mean(trace(i:j));
        [c,ind] = max(trace(i:j));
        dif = c - baseline;
        if dif > fpr;
            total = total+ind;
            peaks = [peaks total];
            total = total+400;
            i = total;
        else;
            i = i+1600;
            total = total+1600;
        end;
        j = i +1600;
end;

%deletes peak1 if can't get good baseline
if peaks(1)<1600;
    peaks(1)=[];
end;

if peaks(1)<1600;
    peaks(1)=[];
end;

if peaks(1)<1600;
    peaks(1)=[];
end;

if peaks(1)<1600;
    peaks(1)=[];
end;

%fixes bug where some peaks were recognized twice
i=1;
while i<numel(peaks);
        if trace(peaks(i)-200)>trace(peaks(i));
            peaks(i)=[];
            i=i-1;
        end;
        i=i+1;
end;

%fixes bug where some peaks were underestimated
i=1;
while i<numel(peaks);
        if max(trace(peaks(i):(peaks(i)+800)))>trace(peaks(i));
            [c,ind]= max(trace(peaks(i):(peaks(i)+800)));
            peaks(i) = peaks(i)+ind;
        end;
        i=i+1;
end;
%fixes bug where some peaks were double labeled
i = 1;
j = numel(peaks);
try;
    for p= 1:j;
        if (peaks(i+1)-peaks(i))<400;
            if trace(peaks(i+1))<trace(peaks(i));
                peaks(i+1) = [];
            else;
                peaks(i) = [];
            end;
        end;
        i=i+1;
    end;
end;

i = 1;
j = numel(peaks);
try;
    for p=1:j;
        if trace(peaks(i)-400)>trace(peaks(i));
            peaks(i) = [];
            i=i-1;
        end;
        i=i+1;
    end;
end;


amplitude = [];
baseline = [];
i=1;
baseloc = [];
for p= 1:(numel(peaks));
        [c, ind]= min(trace((peaks(i)-1600):peaks(i)));
        baseline= [baseline c];
        baseloc = [baseloc (peaks(i)-1600+ind)];
        i=i+1;
end;

amplitude= trace(peaks)-baseline';

orderamp= sort(amplitude,'ascend');
interval = numel(amplitude)/100;
percentile = [];
if numel(amplitude)>100
    i=1;
    for p=1:100;
        percentile = [percentile orderamp(floor(interval*i))];
        i=i+1;
    end;
else percentile = 0
end;
percentile= percentile';

%new section added to find inter-event interval (IEI)
IEI = [];
for p=1:(numel(peaks)-1)
    IEI= [IEI; peaks(p+1)-peaks(p)];
end
IEI = IEI /10000;

figure;
set(subplot(3,1,1),'position', [.05,.66,.4,.3]);
hist(amplitude,100);
set(subplot(3,1,2),'position', [.55,.66,.4,.3]);
plot(percentile);
view(90,-90);
set(subplot(3,1,3),'position', [.05,.05,.95,.55]);
plot(trace);
hold on
scatter(peaks, trace(peaks),'green');
hold on
scatter(baseloc, trace(baseloc),'red')
hold on
scatter(nopeaks, trace(nopeaks),'blue')
hold off

saveas(gcf, strcat(larva{n},file_in((end-11):(end-4)),'_mEPSP.tif'))

%export data
meanamp= mean(amplitude);
frequency = numel(amplitude)/(length(trace)/10000); %10000 hz sampling, events/sec

end

%% subfunction anlayzes EPSP files
function [baseline, peakamp, EPSP_Tau, Wbpassed] = EPSP_analysis(file_in)
    
trace = abfload(file_in);

%identify outliers/weird traces
baselines = [];
peaks =[];
for p=1:numel(trace(1,1:end))
    baselines = [baselines mean(trace(1:1000,p))];
    peaks = [peaks abs(baselines(p)-max(trace(1150:2000,p)))];
end

% I need to flag events that are only 1 stimulated axon
indicies = (max(peaks)-peaks)> 7; %should identify most events
baselines(indicies)=[]; %deletes baseline values
peaks(indicies)=[]; %deletes peak values
trace(:,indicies)=[]; %deletes traces

%editing changes array dimension, which is accounted for by this loop
if sum(indicies)>0 %ie, if edited
    avgtrace = mean(trace,2); %averages along 2nd dimension of array
else
    avgtrace = mean(trace,3);
end

%baseline and amplitude calculations for average trace
baseline = mean(avgtrace(1:1000));
[peak, peakind] = max(avgtrace(1150:2000));
peakind = peakind + 1150; %peak index needs to be corrected
peakamp = abs(baseline-peak);

%Calculate tau using 95% decay
decaythresh = peak - (.95*peakamp);
intersect = peakind+min(find(avgtrace(peakind:end)<decaythresh)); % finds the point where EPSP is 95% decayed
y= avgtrace(peakind:intersect); %points between peak and decaythresh
x= (1:length(y))'; %xvalues for modeling
h = fittype('a*(1-exp(-x/b))+c'); %RC charging equation
[FO,G] = fit(x,y,h,'Start', [-25,900,-25]); %finding the best fit, approximate best starting place
EPSP_Tau = FO.b*.05; %FO.b is Tau in points. Converts to Tau in ms: Tau in points * ms/points (sampling is 50us or .05ms/point)
EPSP_Rsquare = G.rsquare;

%Calculate integral from 95% to 95%
start = find(avgtrace(1:peakind)<decaythresh,1,'last');
Wbpassed = sum(baseline*-1 + avgtrace(start:intersect))*.05; %Webers (mV*ms passed from 95% to 95%)


%graphs
figure;
subplot(1,2,1)
for p=1:numel(trace(1,1:end))
    plot(trace(:,p),'color',[.8,.8,.8])
    hold on
    plot(avgtrace(:),'r','linewidth',2)
end
hold on
scatter(peakind,avgtrace(peakind),'g')
plot([1:7000],decaythresh,'k')
scatter(intersect, avgtrace(intersect),'k')
scatter(start, avgtrace(start),'k')
%legend('traces','average') %adds a lot of processing time for some reason
hold off
subplot(1,2,2)
plot(avgtrace(peakind:intersect),'k')
hold on
plot(FO,'r')
hold off

saveas(gcf, strcat(larva{n},file_in((end-11):(end-4)),'_EPSP.tif'))
    
    
end

%% subfunction analyzes RC files
function [Resistance, Tau, Capacitance, Rsquare] = RC_analysis(file_in)
trace = abfload(file_in);
sumtraces = trace(:,1,1);

i=1;
while i<=numel(trace(1,1,:))
    sumtraces = sumtraces + trace(:,1,i);
    i=i+1;
end

meantrace = sumtraces/numel(trace(1,1,:));

y= meantrace(1400:3800);
x=1:2401;
x=x';

%all these values assume response to 1nA current
h = fittype('a*exp(-x/b)+c');
[FO,G] = fit(x,y,h,'Start',[-3,40,-55]);
Tau = FO.b*.05; %FO.b is Tau in points. Converts to Tau in ms: Tau in points * ms/points (sampling is 50us or .05ms/point)
Resistance = FO.c- mean(meantrace(1:1300)); %Resistance in M(ohms)
Capacitance = Tau/Resistance; %Capacitance in nanofarads (nF) (10^-3s/10^6ohms) (cells are 2uF/cm^2)
Rsquare= G.rsquare; %rsquare

figure('Visible','off')
plot(FO,'r')
hold on
plot(y,'b')
hold off

saveas(gcf, strcat(larva{n},file_in((end-11):(end-4)),'_RC.tif'))

end

%% subfunction analyzes paired pulse files
function mean_ppratio = paired_pulse_analysis(file_in)
trace = abfload(file_in);

ppratio = [];
for p = 1:5
    base = mean(trace(1:1150,1,p));
    peak1 = max(trace(1175:2000,1,p))-base;
    peak2 = max(trace(2200:2800,1,p))-base;
    ppratio = [ppratio; peak2/peak1];
end

%this next bit eliminates outliers
SEM = std(ppratio)/sqrt(5);
nulls = ppratio<(mean(ppratio)-2*(SEM));
ppratio(nulls)=[];
nulls = ppratio>(mean(ppratio)+2*(SEM));
ppratio(nulls)=[];

mean_ppratio = mean(ppratio);

figure
for p = 1:5
plot(trace(:,1,p))
hold on
end

saveas(gcf, strcat(larva{n},file_in((end-11):(end-4)),'_pp.tif'))
    
    
    
end




end