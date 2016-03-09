function peaks = findPeaks(data, debug)
    windowSize = 50;
    stepSize = 5;
    heightThreshold = (max(max(data)) - min(min(data))) / 2;
    widthThreshold = 100;
    peaks = [];
    for windowStart = 1 : stepSize : size(data, 1) - windowSize
        high = max(max(data(windowStart : windowStart + windowSize, :)));
        low = min(min(data(windowStart : windowStart + windowSize, :)));
        if high - low > heightThreshold && (size(peaks, 1) == 0 || windowStart - peaks(end) > widthThreshold)
            peaks = [peaks; windowStart + windowSize];
        end
    end
    
    if nargin == 2 && debug
        plot(data);
        hold on;
        stem(peaks, 3 * ones(size(peaks, 1), 1), '--r', 'fill');
    end
end

