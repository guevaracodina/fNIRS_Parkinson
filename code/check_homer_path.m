function check_homer_path
% Checks if Homer3 (v1.54.0) is in MATLAB path
Folder = 'C:\Edgar\Homer3'; % (v1.54.0)
if ~ismember(Folder, strsplit(path, pathsep))
    % Set Paths for Homer3 (v1.54.0)
    currDir = pwd;
    cd(Folder)
    setpaths
    cd(currDir);
    % Homer3
end
end

