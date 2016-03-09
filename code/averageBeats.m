function beat = averageBeats(data, peaks, debug)
    beats = zeros(200, size(data, 2));
    beatCount = 0;
    for peak = peaks'
        if peak >= 100 && peak + 100 <= size(data, 1)
            beatCount = beatCount + 1;
            beats = beats + data(peak - 100 + 1 : peak + 100, :);
        end
    end
    beat = beats / beatCount;
    
    if nargin == 3 && debug
        plot(beat);
    end
end

