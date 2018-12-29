function pitch = CalcPitchByCor(speech, fs) % calculate pitch by auto-correlation

[cor] = xcorr(speech, speech); % auto-correlation function
first_peak_loc = length(speech) + 1; % max peak index
cor2 = GetCorWithoutFirstPeak(cor, first_peak_loc);

% %%%% plot
% figure;
% plot(speech);
% figure;
% plot(cor,'rx');
% hold on
% plot(cor2,'k')

[~, second_peak_loc] = Get_MaxAndIndex(cor2); % second peak index
period_in_samples = abs(second_peak_loc - first_peak_loc);
period = period_in_samples/fs;
pitch = 1/period;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cor2 = GetCorWithoutFirstPeak(cor, first_peak_loc) % get correlation function without the first peak
n=length(cor);

% get low and high indexes of the first peak
for i=first_peak_loc:-1:1
    if cor(i)<=0
       index_low=i;
       break;
    end
end
for i=first_peak_loc:n
    if cor(i)<=0
       index_high=i;
       break;
    end
end

% put cor in cor2 until index low
index=1;
for i=1:index_low
    cor2(index)=cor(i);
    index=index+1;
end

% put zeros in cor2 until index high - eliminate first peak
for i=index_low:index_high
    cor2(index)=0;
    index=index+1;
end

end
