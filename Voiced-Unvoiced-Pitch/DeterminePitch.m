function [pitch, pitch_loc] = DeterminePitch(speech, fs, start_speech_index_arr, end_speech_index_arr, clusters_num, sign_arr, frame_time_pitch, frame_lap_pitch)
% get pitch of voiced section and locations

for i=1:clusters_num
    arr_voiced=[]; % specific cluster
    if sign_arr(i)==1 % only if cluster is voiced
        start_speech_index=start_speech_index_arr(i); 
        end_speech_index=end_speech_index_arr(i); 
        arr_voiced = CopyToArrFromIndex(speech, start_speech_index, end_speech_index ); % get section
   
        %%% divide section to frames
        frames = FramesWithOverLap(arr_voiced, fs, frame_time_pitch, frame_lap_pitch);
        [m,n] = size(frames);
        
        %%% calculate pitch for each frame
        for j=1:n
            arr_frame=frames(:,j);
            %arr_frame=transpose(arr_frame);
            arr_pitch(j)=CalcPitchByCor(arr_frame, fs);   
        end
        arr_pitch = RemovePitchErr(arr_pitch);
        pitch(i) = mean(arr_pitch); % get mean value of frames pitch
        
        %%% get location for print
        pitch_loc(1,i)=start_speech_index/fs;
        pitch_loc(2,i)=Get_MaxAndIndex(arr_voiced);
        
    else % unvoiced 
        pitch(i)=0;
        pitch_loc(1,i)=0;
        pitch_loc(2,i)=0;
    end
end


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function arr_pitch_out = RemovePitchErr(arr_pitch)

n = length(arr_pitch);
max_pitch = 300;
min_pitch = 50;

index=1;
for i=1:n
    if arr_pitch(i)<= max_pitch && arr_pitch(i)>= min_pitch
       arr_pitch_out(index)=arr_pitch(i);
       index=index+1;
    end
end

end
