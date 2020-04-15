function [num_x, num_y, base_x, base_y] = parse_params(path)
    fileID = fopen(strcat(path, '/param.txt'),'r');
    fgetl(fileID);
    line = fgetl(fileID);
    num_x = str2num(char(extractBetween(line, 8, length(line))));
    line = fgetl(fileID);
    num_y = str2num(char(extractBetween(line, 8, length(line))));
    line = fgetl(fileID);
    base_x = str2double(char(extractBetween(line, 9, length(line))));
    line = fgetl(fileID);
    base_y = str2double(char(extractBetween(line, 9, length(line))));
end