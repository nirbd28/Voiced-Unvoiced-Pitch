function [start_speech_index_arr, end_speech_index_arr, sign_arr, clusters_num]=Voiced_Unvoiced(speech, fs, frame_time, frame_lap, zcr_trsh, slide)

%%% split to frames
frames = FramesWithOverLap(speech, fs, frame_time, frame_lap);
[m,n]=size(frames);% n- number of frames

%%% calculate ZCR
for i=1:n
    zcr(i)= CalcZCR(frames(:,i));
end

%%% frame class
frame_class=[];
for i=1:n
    if zcr(i) <=zcr_trsh
       frame_class(i)=1; %voiced
    else
        frame_class(i)=0; %unvoiced   
    end
end

%%% slide
frame_class_slide = Slide(frame_class, slide);

%%% get frames start 
[start_frame_arr, sign_arr, clusters_num]=FramesGetStart(frame_class_slide);



%%% convert to time
for i=1:clusters_num
   start_time_arr(i)=FrameToTime_OverLap(start_frame_arr(i), frame_time, frame_lap);     
end

%%% convert to speech index
for i=1:clusters_num
   start_speech_index_arr(i)= TimeToIndex(start_time_arr(i), fs);     
end

%%% get speech index end 
for i=1:clusters_num-1
   end_speech_index_arr(i)= start_speech_index_arr(i+1) -1 ;     
end
end_speech_index_arr(clusters_num) = length(speech);


end