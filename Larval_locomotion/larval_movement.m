function distout = larval_movement(video)

%finds optimal threshold for analyzing video
threshoptions = [];
for threshold=.2:.05:.65; %the optimal threshold will depend on camera settings (higher for brighter videos)
    frame_analy(video,1,threshold);
    objects = 0;
    i=1;
    while i<= numel(ans)/2
        if sqrt((320-ans(i,1))^2+(240-ans(i,2))^2)<160
            objects = objects +1;
        end;
        i=i+1;
    end
    threshoptions = [threshoptions; objects threshold];
end

n=1;
while n<= numel(threshoptions(:,1));
    if threshoptions(n,1)>5
        threshoptions(n,:)=[];
        n= n-1;
    end
    n=n+1;
end

objects = max(threshoptions(:,1));
bestthresh = [];
i=1;
while i<=numel(threshoptions)/2
    if threshoptions(i,1) == objects;
        bestthresh = [bestthresh threshoptions(i,2)];
    end
    i=i+1;
end

threshold = mean(bestthresh)-.1
%threshold = .1 %set threshold low when doing mids

vid_analy(video,threshold);
larvae = ans;

distout = [];
interval = 5;
for n=1:numel(larvae)
    distanceintervals = [];
    i=1;
    while i<=(numel(larvae{n})/2)-interval
        distanceintervals = [distanceintervals distance(larvae{n}(i,1),larvae{n}(i,2),larvae{n}((i+interval),1),larvae{n}((i+interval),2))];
        i=i+interval;
    end
    distout = [distout sum(distanceintervals)];
end

while numel(distout)>objects %this part deletes objects that were unintentionally identified as larvae (can be distinguished because they're not moving)
    [v,p]=min(distout);
    distout(p) = [];
end
    
assignin('base','distout',distout)

%this can be used to view larvae tracings
figure;
framenumber=1;
obj = VideoReader(video);
vidFrame = read(obj,framenumber);
BW = im2bw(vidFrame,threshold); %this seems to be approximately the right threshold for recognizing larvae
B= bwboundaries(BW,'noholes');
imshow(BW);
hold on;
for i=1:numel(larvae)
    scatter(larvae{i}(:,1),larvae{i}(:,2),1)
end

end


function larvae = vid_analy(video,threshold)
%puts all maxtrices (corresponding to each frame)into a cell array called "allcentroids" 
for framenumber=1:450;
    frame_analy(video,framenumber,threshold);
    allcentroids{framenumber} = ans;
end;

%deletes objects outside the center area where larvae are located
i=1;
while i<= numel(allcentroids{1})/2
    if distance(320,240,allcentroids{1}(i,1),allcentroids{1}(i,2))>160
        allcentroids{1}(i,:) = [];
    else
        i=i+1;
    end
end

%allocate each object from allcentroids{1} into a separate cell array
%called "larvae"
for n=1:numel(allcentroids{1})/2
    larvae{n} = allcentroids{1}(n,:);
end


%figuring out why larvae are disappearing
%scatter(larvae{1}(:,1),larvae{1}(:,2))


%match larvae with next frame (L is larva, a is frame#, b objects within
%frame that need to be matched)
L=1; % L is for larvae number
while L<=numel(larvae) %loop through larvae
    a=2; % a is frame number for allcentroids, use the previous frame (a-1) in larvae to match
    while a <=300 %look through all frames (dictates length of time analyzed, set to 90sec)
        b=1; %b is object number in allcentroids
        options = []; %set of all possible matches
        while b<=numel(allcentroids{a})/2 %number of all objects in a frame
            options = [options distance(larvae{L}(end,1),larvae{L}(end,2),allcentroids{a}(b,1),allcentroids{a}(b,2))]; %all possible matches in next frame, using a to indicate frame number
            b=b+1; %advance to next object
        end
        [x,y]=min(options); %finds closest match
        if x < 5; %if there is a close match
            larvae{L}= [larvae{L}; allcentroids{a}(y,:)]; %places coordinates of closest match into the respective larvae matrix
        end
        a=a+1; %advance to next frame
    end
    L=L+1; %advance to next larva
end

a=1; %deletes small data sets
while a<=numel(larvae)
    if numel(larvae{a})<500 %less than 400 frames (double frame number since it contains x and y coordinates
        larvae(a) = [];
        a=1;
    end
    a=a+1;
end

%deletes larvae that collide (large intersect)
a=1;
while a<numel(larvae) 
    b=a+1; %now proofreads for collisions
    while b<=numel(larvae)
        [c] = intersect(larvae{a},larvae{b},'rows');
        if numel(c) >20;
            larvae(b) = []; %larvae b needs to be deleted first because it changes the size of the cell array
            larvae(a) = []; 
            a=1; %the loop needs to be reset
        end
        b=b+1;
    end
    a=a+1;
end

%this can be used to view larvae tracings
%vid='1.avi'
%framenumber=1
%threshold=.525
%obj = VideoReader(vid);
%vidFrame = read(obj,framenumber);
%BW = im2bw(vidFrame,threshold); %this seems to be approximately the right threshold for recognizing larvae
%B= bwboundaries(BW,'noholes');
%imshow(BW);
%hold on;
%for i=1:5
%    scatter(larvae{i}(:,1),larvae{i}(:,2),1)
%end
end

function centroids = frame_analy(vid,framenumber,threshold) %inputs are video number, frame number, and respective threshold for identifying larvae
%this is to look at a single frame
%movie = '1.avi'
obj = VideoReader(vid);
vidFrame = read(obj,framenumber);
BW = im2bw(vidFrame,threshold); %this seems to be approximately the right threshold for recognizing larvae
B= bwboundaries(BW,'noholes');

k=1;
while k <= length(B); %deletes objects that are too large or too small
    if length(B{k}) > 30; %identifies large objects
         B(k) = [];
    elseif length (B{k}) <5; %identifies small objects, normally set to 10, but block when doing small larvae
         B(k) = [];
    else;
        k=k+1;
    end;
end;

centroids = []; %these are the centers of objects
for k=1:length(B);
    boundary = B{k};
    centroids = [centroids; mean(boundary(:,2)) mean(boundary(:,1))];
end

%this can be used to show individual frames and test for thresholds
%imshow(BW)
%hold on
%scatter(320,240,200,'b') %320,240 is middle
%for k=1:length(B)
%    boundary = B{k}
%    plot(boundary(:,2), boundary(:,1),'g','LineWidth',.2)
%    scatter(centroids(:,1),centroids(:,2),'r','LineWidth',.01)
%end
end

function ans = distance(x1,y1,x2,y2)
ans = ((x2-x1)^2+(y2-y1)^2)^.5;
end