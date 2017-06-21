files = glob('EPSCs\*');

for n=1:numel(files)
    file = files{n};
    [analysis_results,amplitude] = EPSC_analysis(file);
    xlswrite('EPSC_data',amplitude','Amplitude',strcat('b',int2str(n+1),':',num2let(numel(amplitude)+1),int2str(n+1))); %had to modify num2let to convert properly
    xlswrite('EPSC_data',{file(7:end)},'Amplitude',strcat('A',int2str(n+1))); %adds filename;
    xlswrite('EPSC_data',analysis_results,'Summary',strcat('B',int2str(n+1),':E',int2str(n+1)));
    xlswrite('EPSC_data',{file(7:end)},'Summary',strcat('A',int2str(n+1))); %adds filename
    saveas(gcf,file(7:end-4));
    close all;
end

categories = {'Mean Amplitude' 'Number of Events' 'Recording duration (s)' 'Events/min'};
xlswrite('EPSC_data',categories,'Summary','B1:E1');