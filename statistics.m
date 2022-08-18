function [] = statistics(time, log, const, plot_stat_hist)
    pctl = @(v,p) interp1(linspace(0.5/length(v), 1-0.5/length(v), length(v))', sort(v), p*0.01, 'spline');
    
    fprintf('min. dist OPT: mean = %1.4f s, std = %1.4f s, p50 = %1.4f s, p99 = %1.4f s, freq = %4.1f Hz\n', ...
        mean(mean(log.t_opt(:,1:const.N))), std(log.t_opt(1:size(log.t_opt,1)*const.N)), ...
        pctl(log.t_opt(1:size(log.t_opt,1)*const.N), 50), pctl(log.t_opt(1:size(log.t_opt,1)*const.N), 99), ...
        1/mean(mean(log.t_opt(:,1:const.N))));
    
    fprintf('control OPT  : mean = %1.4f s, std = %1.4f s, p50 = %1.4f s, p99 = %1.4f s, freq = %4.1f Hz\n', ...
        mean(log.t_opt(:,const.N+1)), std(log.t_opt(:,const.N+1)), ...
        pctl(log.t_opt(:,const.N+1), 50), pctl(log.t_opt(:,const.N+1), 99), ...
        1/mean(log.t_opt(:,const.N+1)));
    
    fprintf('total        : mean = %1.4f s, std = %1.4f s, p50 = %1.4f s, p99 = %1.4f s, freq = %4.1f Hz\n\n', ...
        mean(time), std(time), pctl(time, 50), pctl(time, 99), 1/mean(time));
    
    fprintf('min. distance = %3.4f m\n', min(min(log.h)));
    
    if plot_stat_hist
    	histogram(time);
    end
end
