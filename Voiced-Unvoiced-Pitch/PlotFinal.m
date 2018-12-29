function PlotFinal(speech, fs, start_speech_index_arr, end_speech_index_arr, sign_arr, clusters_num, pitch, pitch_loc)

%%% signs
voiced='c';%c-cyan
unvoiced='k';%k-black

%%% set signs for plot
s = blanks(clusters_num);
for i=1:clusters_num % fill array with signs: 1-voiced, 0-unvoiced
    if sign_arr(i)==1
        s(i)=voiced;
    else
        s(i)=unvoiced;
    end  
end

%%% plot
for i=1:clusters_num
    % get part speech
    part_speech=[];
    part_speech = CopyToArrFromIndex(speech, start_speech_index_arr(i), end_speech_index_arr(i));
    % get part speech time axis
    time_axis=[];
    start_time=start_speech_index_arr(i)/fs;
    end_time=end_speech_index_arr(i)/fs;
    time_axis=start_time:1/fs:end_time;
    
    plot(time_axis,part_speech,s(i));
    hold on;  
end

%%% plot legend
hold on
l1 = plot([NaN,NaN], 'c');
l2 = plot([NaN,NaN], 'k');
legend([l1, l2], {'Voiced', 'Unvoiced'});
xlabel('Time[sec]');
ylabel('Amplitude');

%%% print pitch
for i=1:clusters_num
    if pitch(i)~=0 
        str=sprintf('%0.2f',pitch(i));
        str=strcat('pitch=',str);
        dx=pitch_loc(1,i);
        dy=pitch_loc(2,i);
        text(dx,-dy,str,'Color','red','FontSize',16,'fontweight','bold') 
    end
end

end