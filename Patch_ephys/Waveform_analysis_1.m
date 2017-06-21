%% This is a script to analyze additional AP properties

s = [] %make structure
%% Load data into structure. I am picking the trace with the fewest action potentials and saving the trace to the structure along with the file name and the sweep number.
% first trace
a=1
b=2
c=8

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};

trace = abfload(files{b});

string = files{b}(1:end-4);
string = strrep(string,'\','_');

s.LoxP1 = {string,c,trace(:,1,c)}

% second trace
a=2 %this is the cell
b=2 %this is the repetition
c=7 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};

trace = abfload(files{b});

string = files{b}(1:end-4);
string = strrep(string,'\','_');

s.LoxP2 = {string,c,trace(:,1,c)}

% third trace
a=3 %this is the cell
b=2 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP3 = {string,c,trace(:,1,c)}

% fourth trace
a=4 %this is the cell
b=1 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R1 = {string,c,trace(:,1,c)}

% fifth trace
a=5 %this is the cell
b=1 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R2 = {string,c,trace(:,1,c)}

% sixth trace
a=6 %this is the cell
b=3 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP4 = {string,c,trace(:,1,c)}

% seventh trace
a=7 %this is the cell
b=1 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP5 = {string,c,trace(:,1,c)}

% eighth trace
a=8 %this is the cell
b=4 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP6 = {string,c,trace(:,1,c)}

% ninth trace
a=9 %this is the cell
b=3 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R3 = {string,c,trace(:,1,c)}

% tenth trace
a=10 %this is the cell
b=1 %this is the repetition
c=9 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R4 = {string,c,trace(:,1,c)}

% eleventh trace
a=11 %this is the cell
b=2 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R5 = {string,c,trace(:,1,c)}

% twelfth trace
a=12 %this is the cell
b=1 %this is the repetition
c=8 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R6 = {string,c,trace(:,1,c)}

% thirteenth trace (skipping Gbb Rescues)
a=18 %this is the cell
b=3 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP7 = {string,c,trace(:,1,c)}

% fourteenth trace (skipping Gbb Rescues)
a=19 %this is the cell
b=1 %this is the repetition
c=4 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP8 = {string,c,trace(:,1,c)}

% fifteenth trace (skipping Gbb Rescues)
a=20 %this is the cell
b=3 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP9 = {string,c,trace(:,1,c)}

% sixteenth trace (skipping Gbb Rescues)
a=21 %this is the cell
b=2 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP10 = {string,c,trace(:,1,c)}

% seventeenth trace (skipping Gbb Rescues)
a=22 %this is the cell
b=2 %this is the repetition
c=7 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP11 = {string,c,trace(:,1,c)}

% eighteenth trace
a=26 %this is the cell
b=3 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP12 = {string,c,trace(:,1,c)}

% nineteenth trace
a=27 %this is the cell
b=2 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.LoxP13 = {string,c,trace(:,1,c)}

% twentieth trace
a=28 %this is the cell
b=4 %this is the repetition
c=9 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R7 = {string,c,trace(:,1,c)}

% twentyfirst trace
a=29 %this is the cell
b=1 %this is the repetition
c=6 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R8 = {string,c,trace(:,1,c)}

% twentysecond trace
a=30 %this is the cell
b=2 %this is the repetition
c=5 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R9 = {string,c,trace(:,1,c)}

% twentythird trace
a=31 %this is the cell
b=3 %this is the repetition
c=8 % this is the sweep

biocells = glob('*1b_*');
files = glob([biocells{a} '*.abf']);
file = files{b};
trace = abfload(files{b});

string = files{b}(1:end-4)
string = strrep(string,'\','_')

s.G85R10 = {string,c,trace(:,1,c)}

%% plots of waveforms
% plot all traces
for n = 1:13
    a = ['LoxP' int2str(n)]
    plot(s.(a){3})
    hold on
    text(10000,-30,a)
    hold off
    ylim([-80 10])
    saveas(gcf,[a '.eps'])
end

for n = 1:10
    a = ['G85R' int2str(n)]
    plot(s.(a){3})
    hold on
    text(10000,-30,a)
    hold off
    ylim([-80 10])
    saveas(gcf,[a '.eps'])
end
    
%% analysis of AP waveform
% go through each file, find the peak, and pull parameters
parameter_matrix = [];
name_matrix = {};

for n = 1:13
    a = ['LoxP' int2str(n)];
    trace = s.(a){3};
    slope = [];
    for nn=1:(numel(trace)-1)
        slope = [slope; (trace(nn+1)-trace(nn))];
    end
    AP = find(slope > 1.35,1); %find the first action potential
    slopetrig = find(slope(AP-49:AP)>.5,1); %revise starting point to first time slope >.5mV/point
    AP = (AP-50+slopetrig);
    trigger = trace(AP)
    maxpositiveslope = max(slope(AP:(AP+100)));
    maxnegativeslope = min(slope(AP:(AP+100)));
    [maximum maxloc] = max(trace(AP:AP+100)); %top of AP
    [minimum minloc] = min(trace(AP:AP+100)); %bottom of AP
    max_to_min = minloc-maxloc;
    %find vhalf values
    vhalf = (trigger+maximum)/2;
    %rise face- find points near vhalf and make a line. then find intercept
    %between line and vhalf
    vhalfover = AP+find(trace(AP:AP+maxloc)>vhalf,1)-1; %find point over vhalf
    vhalfunder = vhalfover-1; %find point under vhalf
    riseslope = (trace(vhalfover)-trace(vhalfunder)) %find slope between points
    riseintercept = trace(vhalfover)-(vhalfover*riseslope) %find y intercept
    vhalf_rise_x = (vhalf-riseintercept)/riseslope %determine x value equal to vhalf
    %decay face- find points near vhalf and make line. then find intercept
    vhalfover2 = AP+ maxloc -1 + find(trace(AP+maxloc:AP+minloc)<vhalf,1); %first value under vhalf
    vhalfunder2 = vhalfover2-1;
    decayslope = (trace(vhalfover2)-trace(vhalfunder2));
    decayintercept = trace(vhalfover2)-(vhalfover2*decayslope);
    vhalf_decay_x = (vhalf-decayintercept)/decayslope;
    half_width = vhalf_decay_x-vhalf_rise_x;
    rise_time = maxloc;
    
    %write values to matrix
    parameter_matrix = [parameter_matrix; trigger, maximum, minimum, maxpositiveslope, maxnegativeslope, half_width, maxloc, max_to_min, s.(a){2}];
    name_matrix{n} = {a};
    
    plot(s.(a){3})
    hold on
    scatter(AP,trace(AP),'r')
    scatter(AP+maxloc,trace(AP+maxloc-1),'g')
    scatter(AP+minloc,trace(AP+minloc-1),'k')
    line([vhalf_decay_x,vhalf_rise_x],[vhalf,vhalf],'color','r')
    text(10000,-30,a)
    hold off
    ylim([-80 10])
    saveas(gcf,[a '_analyzed.eps'])
end

xlswrite('AP_waveform2',parameter_matrix)

%G85R analysis
parameter_matrix = [];
name_matrix = {};

for n = 1:10
    a = ['G85R' int2str(n)];
    trace = s.(a){3};
    slope = [];
    for nn=1:(numel(trace)-1)
        slope = [slope; (trace(nn+1)-trace(nn))];
    end
    AP = find(slope > 1.35,1); %find the first action potential
    slopetrig = find(slope(AP-49:AP)>.5,1); %revise starting point to first time slope >.5mV/point
    AP = (AP-50+slopetrig);
    trigger = trace(AP)
    maxpositiveslope = max(slope(AP:(AP+100)));
    maxnegativeslope = min(slope(AP:(AP+100)));
    [maximum maxloc] = max(trace(AP:AP+100)); %top of AP
    [minimum minloc] = min(trace(AP:AP+100)); %bottom of AP
    max_to_min = minloc-maxloc;
    %find vhalf values
    vhalf = (trigger+maximum)/2;
    %rise face- find points near vhalf and make a line. then find intercept
    %between line and vhalf
    vhalfover = AP+find(trace(AP:AP+maxloc)>vhalf,1)-1; %find point over vhalf
    vhalfunder = vhalfover-1; %find point under vhalf
    riseslope = (trace(vhalfover)-trace(vhalfunder)) %find slope between points
    riseintercept = trace(vhalfover)-(vhalfover*riseslope) %find y intercept
    vhalf_rise_x = (vhalf-riseintercept)/riseslope %determine x value equal to vhalf
    %decay face- find points near vhalf and make line. then find intercept
    vhalfover2 = AP+ maxloc -1 + find(trace(AP+maxloc:AP+minloc)<vhalf,1); %first value under vhalf
    vhalfunder2 = vhalfover2-1;
    decayslope = (trace(vhalfover2)-trace(vhalfunder2));
    decayintercept = trace(vhalfover2)-(vhalfover2*decayslope);
    vhalf_decay_x = (vhalf-decayintercept)/decayslope;
    half_width = vhalf_decay_x-vhalf_rise_x;
    rise_time = maxloc;
    
    %write values to matrix
    parameter_matrix = [parameter_matrix; trigger, maximum, minimum, maxpositiveslope, maxnegativeslope, half_width, maxloc, max_to_min, s.(a){2}];
    name_matrix{n} = {a};
    
    plot(s.(a){3})
    hold on
    scatter(AP,trace(AP),'r')
    scatter(AP+maxloc,trace(AP+maxloc-1),'g')
    scatter(AP+minloc,trace(AP+minloc-1),'k')
    line([vhalf_decay_x,vhalf_rise_x],[vhalf,vhalf],'color','r')
    text(10000,-30,a)
    hold off
    ylim([-80 10])
    saveas(gcf,[a '_analyzed.eps'])
end

xlswrite('AP_waveform2',parameter_matrix)


plot(trace(:,1,c),'r')
hold on
plot(trace(:,1,c+1),'g')
plot(trace(:,1,c+2),'b')
hold off

%% figures for parameters
file = 'AP_waveform.xls';
sheet = 'Sheet1';

%plot rheobase
LoxP_rheobase = xlsread(file,sheet,'B2:b14')
G85R_rheobase = xlsread(file,sheet,'b16:b25')

data = {LoxP_rheobase,G85R_rheobase}
bin = 1
lim = [-50 0]
points = [-50, -25, 0]
pointlabels = {'-50', '-25', '0'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP peak
LoxP_peak = xlsread(file,sheet,'c2:c14');
G85R_peak = xlsread(file,sheet,'c16:c25');

data = {LoxP_peak,G85R_peak}
bin = 1
lim = [-30 0]
points = [-30, -15, 0]
pointlabels = {'-30', '-15', '0'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP trough
LoxP_trough = xlsread(file,sheet,'d2:d14');
G85R_trough = xlsread(file,sheet,'d16:d25');

data = {LoxP_trough,G85R_trough}
bin = 1
lim = [-60 0]
points = [-60, -30, 0]
pointlabels = {'-60', '-30', '0'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP height (rheobase to peak)
LoxP_height = xlsread(file,sheet,'e2:e14');
G85R_height = xlsread(file,sheet,'e16:e25');

data = {LoxP_height,G85R_height}
bin = 1
lim = [0 30]
points = [0, 15, 30]
pointlabels = {'0', '15', '30'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP depth
LoxP_depth = xlsread(file,sheet,'f2:f14')*-1;
G85R_depth = xlsread(file,sheet,'f16:f25')*-1;

data = {LoxP_depth,G85R_depth}
bin = 1
lim = [-30 0]
points = [-30, -15, 0]
pointlabels = {'-30', '-15', '0'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP max rise slope
LoxP_rise = xlsread(file,sheet,'g2:g14');
G85R_rise = xlsread(file,sheet,'g16:g25');

data = {LoxP_rise,G85R_rise}
bin = .2
lim = [0 6]
points = [0, 3, 6]
pointlabels = {'0', '3', '6'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP decay slope
LoxP_decay = xlsread(file,sheet,'h2:h14');
G85R_decay = xlsread(file,sheet,'h16:h25');

data = {LoxP_decay,G85R_decay}
bin = .2
lim = [-4 0]
points = [-4, -2, 0]
pointlabels = {'-4', '-2', '0'}

beestingbar3(data,bin,lim,points,pointlabels)

%plot AP half-width
LoxP_width = xlsread(file,sheet,'i2:i14');
G85R_width = xlsread(file,sheet,'i16:i25');

data = {LoxP_width,G85R_width}
bin = 1
lim = [0 15]
points = [0, 5, 10, 15]
pointlabels = {'0', '5', '10', '15'}

beestingbar3(data,bin,lim,points,pointlabels)

%current applied
LoxP_current_applied = xlsread(file,sheet,'j2:j14');
G85R_current_applied = xlsread(file,sheet,'j16:j25');

data = {LoxP_current_applied,G85R_current_applied}
bin = 1
lim = [0 100]
points = [0, 50, 100]
pointlabels = {'0', '50', '100'}

beestingbar3(data,bin,lim,points,pointlabels)