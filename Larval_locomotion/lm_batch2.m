function alldistances = lm_batch2(genotype,rep) %needs genotype and loop number

columna = rep*2-1;
columna = num2let(columna);
columnb = rep*2;
columnb = num2let(columnb);

alldistances = [];
filenumber = [];

for n=1:numel(glob(strcat(genotype,'*.avi')))
    larval_movement(strcat(genotype,int2str(n),'.avi'));
    alldistances = [alldistances ans]
    filenumber = [filenumber n*ones(1,numel(ans))];
    saveas(gcf,strcat(genotype,'_movement',int2str(n)));
end

Genotype = {genotype};

alldistances = alldistances';
filenumber = filenumber';

xlswrite('Larval Movement',Genotype,'Total Distance',strcat(columna,'1'))
xlswrite('Larval Movement',Genotype,'Total Distance',strcat(columnb,'1'))
xlswrite('Larval Movement',alldistances, 'Total Distance',strcat(columna,'2:',columna,int2str(1+numel(alldistances(:,1)))))
xlswrite('Larval Movement',filenumber, 'Total Distance',strcat(columnb,'2:',columnb,int2str(1+numel(alldistances(:,1)))))