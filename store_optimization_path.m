function stop = store_optimization_path(x,optimValues,state)
%STORE_OPTIMIZATION_PATH outfun used by fmincon to store the optimization 
%path in the global variable HISTORY
    global HISTORY;
    switch state
        case 'iter'
            %HISTORY.fval = [HISTORY.fval, optimValues.fval];
            %HISTORY.x = [HISTORY.x, x];
    end
    stop = false;
end
