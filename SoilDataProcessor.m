clear all

% Read in data files
CSCBFiles = dir('CSCB\*.dat');
CSCBTANKFiles = dir('CSCBTANK\*.dat');
CSWFFiles = dir('CSWF\*.dat');
CSWFTANKFiles = dir('CSWFTANK\*.dat');
GLCBFiles = dir('GLCB\*.dat');
GLTANKFiles = dir('GLTANK\*.dat');
GLWFFiles = dir('GLWF\*.dat');

%%
% Build arrays for each datalogger
CSCBTank = [];
for i = 1:length(CSCBTANKFiles)
    CSCBTank = cat(1,CSCBTank,dlmread(fullfile('CSCBTANK',CSCBTANKFiles(i).name)));
end
CSCBTank = sortrows(CSCBTank,[2,3,4]);

CSWFTank = [];
for i = 1:length(CSWFTANKFiles)
    CSWFTank = cat(1,CSWFTank,dlmread(fullfile('CSWFTANK',CSWFTANKFiles(i).name)));
end
CSWFTank = sortrows(CSWFTank,[2,3,4]);

GLTank = [];
for i = 1:length(GLTANKFiles)
    GLTank = cat(1,GLTank,dlmread(fullfile('GLTANK',GLTANKFiles(i).name)));
end
GLTank = sortrows(GLTank,[2,3,4]);

CSCB = [];
for i = 1:length(CSCBFiles)
    CSCB = cat(1,CSCB,cell2mat(readtext...
        (fullfile('CSCB',CSCBFiles(i).name),',','','','empty2NaN')));
end

CSWF = [];
for i = 1:length(CSWFFiles)
    CSWF = cat(1,CSWF,cell2mat(readtext...
        (fullfile('CSWF',CSWFFiles(i).name),',','','','empty2NaN')));
end

GLCB = [];
for i = 1:length(GLCBFiles)
    GLCB = cat(1,GLCB,cell2mat(readtext...
        (fullfile('GLCB',GLCBFiles(i).name),',','','','empty2NaN')));
end

GLWF = [];
for i = 1:length(GLWFFiles)
    GLWF = cat(1,GLWF,cell2mat(readtext...
        (fullfile('GLWF',GLWFFiles(i).name),',','','','empty2NaN')));
end

%%
% Sort big arrays
CSCB = CSCB';
[~,I] = sort(CSCB(1,:));
CSCB = CSCB(:,I);
CSCB = CSCB';

CSWF = CSWF';
[~,I] = sort(CSWF(1,:));
CSWF = CSWF(:,I);
CSWF = CSWF';

GLCB = GLCB';
[~,I] = sort(GLCB(1,:));
GLCB = GLCB(:,I);
GLCB = GLCB';

GLWF = GLWF';
[~,I] = sort(GLWF(1,:));
GLWF = GLWF(:,I);
GLWF = GLWF';

fprintf('Data successfully read and sorted\n');

save('CSCBTank.mat','CSCBTank');
save('CSCB.mat','CSCB');
save('CSWFTank.mat','CSWFTank');
save('CSWF.mat','CSWF');
save('GLCB.mat','GLCB');
save('GLTank.mat','GLTank');
save('GLWF.mat','GLWF');

%%
% Break up soil system arrays into smaller arrays based on treatment types
CSCBHousekeeping = [];
CSCBDry = [];
CSCBAmb = [];
CSCBWet = [];
CSCBNDVI = [];
for i = 1:length(CSCB(:,1))
    if CSCB(i,1) == 130
        CSCBHousekeeping = cat(1,CSCBHousekeeping,CSCB(i,:));
    elseif CSCB(i,1) == 151
        CSCBDry = cat(1,CSCBDry,CSCB(i,:));
    elseif CSCB(i,1) == 152
        CSCBAmb = cat(1,CSCBAmb,CSCB(i,:));
    elseif CSCB(i,1) == 153
        CSCBWet = cat(1,CSCBWet,CSCB(i,:));
    elseif CSCB(i,1) == 154
        CSCBNDVI = cat(1,CSCBNDVI,CSCB(i,:));
    else
        fprintf('Mistake in CSCB');
    end
end
CSCBHousekeeping = sortrows(CSCBHousekeeping,[2,3,4]);
CSCBDry = sortrows(CSCBDry,[2,3,4]);
CSCBAmb = sortrows(CSCBAmb,[2,3,4]);
CSCBWet = sortrows(CSCBWet,[2,3,4]);
CSCBNDVI = sortrows(CSCBNDVI,[2,3,4]);

fprintf('CSCB sorted successfully\n');

CSWFHousekeeping = [];
CSWFDry = [];
CSWFAmb = [];
CSWFWet = [];
CSWFNDVI = [];
for i = 1:length(CSWF(:,1))
    if CSWF(i,1) == 130
        CSWFHousekeeping = cat(1,CSWFHousekeeping,CSWF(i,:));
    elseif CSWF(i,1) == 141
        CSWFDry = cat(1,CSWFDry,CSWF(i,:));
    elseif CSWF(i,1) == 142
        CSWFAmb = cat(1,CSWFAmb,CSWF(i,:));
    elseif CSWF(i,1) == 143
        CSWFWet = cat(1,CSWFWet,CSWF(i,:));
    elseif CSWF(i,1) == 144
        CSWFNDVI = cat(1,CSWFNDVI,CSWF(i,:));
    else
        fprintf('Mistake in CSWF');
    end
end
CSWFHousekeeping = sortrows(CSWFHousekeeping,[2,3,4]);
CSWFDry = sortrows(CSWFDry,[2,3,4]);
CSWFAmb = sortrows(CSWFAmb,[2,3,4]);
CSWFWet = sortrows(CSWFWet,[2,3,4]);
CSWFNDVI = sortrows(CSWFNDVI,[2,3,4]);

fprintf('CSWF sorted successfully\n');

GLCBHousekeeping = [];
GLCBDry = [];
GLCBAmb = [];
GLCBWet = [];
GLCBNDVI = [];
for i = 1:length(GLCB(:,1))
    if GLCB(i,1) == 130
        GLCBHousekeeping = cat(1,GLCBHousekeeping,GLCB(i,:));
    elseif GLCB(i,1) == 131
        GLCBDry = cat(1,GLCBDry,GLCB(i,:));
    elseif GLCB(i,1) == 132
        GLCBAmb = cat(1,GLCBAmb,GLCB(i,:));
    elseif GLCB(i,1) == 133
        GLCBWet = cat(1,GLCBWet,GLCB(i,:));
    elseif GLCB(i,1) == 134
        GLCBNDVI = cat(1,GLCBNDVI,GLCB(i,:));
    else
        fprintf('Mistake in GLCB');
    end
end
GLCBHousekeeping = sortrows(GLCBHousekeeping,[2,3,4]);
GLCBDry = sortrows(GLCBDry,[2,3,4]);
GLCBAmb = sortrows(GLCBAmb,[2,3,4]);
GLCBWet = sortrows(GLCBWet,[2,3,4]);
GLCBNDVI = sortrows(GLCBNDVI,[2,3,4]);

fprintf('GLCB sorted successfully\n');

GLWFHousekeeping = [];
GLWFDry = [];
GLWFAmb = [];
GLWFWet = [];
GLWFNDVI = [];
for i = 1:length(GLWF(:,1))
    if GLWF(i,1) == 130
        GLWFHousekeeping = cat(1,GLWFHousekeeping,GLWF(i,:));
    elseif GLWF(i,1) == 121
        GLWFDry = cat(1,GLWFDry,GLWF(i,:));
    elseif GLWF(i,1) == 122
        GLWFAmb = cat(1,GLWFAmb,GLWF(i,:));
    elseif GLWF(i,1) == 123
        GLWFWet = cat(1,GLWFWet,GLWF(i,:));
    elseif GLWF(i,1) == 124
        GLWFNDVI = cat(1,GLWFNDVI,GLWF(i,:));
    else
        fprintf('Mistake in GLWF');
    end
end
GLWFHousekeeping = sortrows(GLWFHousekeeping,[2,3,4]);
GLWFDry = sortrows(GLWFDry,[2,3,4]);
GLWFAmb = sortrows(GLWFAmb,[2,3,4]);
GLWFWet = sortrows(GLWFWet,[2,3,4]);
GLWFNDVI = sortrows(GLWFNDVI,[2,3,4]);

fprintf('GLWF sorted successfully\n');

CSCBHousekeeping = CSCBHousekeeping(:,1:9);
CSWFHousekeeping = CSWFHousekeeping(:,1:9);
GLCBHousekeeping = GLCBHousekeeping(:,1:9);
GLWFHousekeeping = GLWFHousekeeping(:,1:9);
CSCBNDVI = CSCBNDVI(:,1:28);
CSWFNDVI = CSWFNDVI(:,1:28);
GLCBNDVI = GLCBNDVI(:,1:28);
GLWFNDVI = GLWFNDVI(:,1:28);

%%
% Calculate NDVI and matric potential
run MatricPotentialCalibrationData;

% These three arrays contain column headers for the different arrays
SoilSystemVars = {'ArrayID' 'Year' 'Day' 'HHMM' 'TairAvg' 'RHAvg' ...
    'PARAvg' 'PARMax' 'SM1' 'SM2' 'SM3' 'SM4' 'SM5' 'SM6' 'SM7' 'SM8' ...
    'FM1' 'FM2' 'LWS1' 'LWS2' 'ST1' 'ST2' 'ST3' 'ST4' 'TBox' 'Red_in' ...
    'NIR_in' 'Red1_out' 'NIR1_out' 'Red2_out' 'NIR2_out' 'DMP1i' 'DMP2i' ...
    'DMP3i' 'DMP4i' 'DMP5i' 'DMP6i' 'DMP1_1s' 'DMP2_1s' 'DMP3_1s' ...
    'DMP4_1s' 'DMP5_1s' 'DMP6_1s' 'DMP1_30s' 'DMP2_30s' 'DMP3_30s' ...
    'DMP4_30s' 'DMP5_30s' 'DMP6_30s' 'D_Del_1' 'D_Del_2' 'D_Del_3' ...
    'D_Del_4' 'D_Del_5' 'D_Del_6' 'NDVI_1' 'NDVI_2' 'MP1' 'MP2' 'MP3' ...
    'MP4' 'MP5' 'MP6' '-MP1' '-MP2' '-MP3' '-MP4' '-MP5' '-MP6'; '1' ...
    '2' '3' '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' ...
    '17' '18' '19' '20' '21' '22' '23' '24' '25' '26' '27' '28' '29' ...
    '30' '31' '32' '33' '34' '35' '36' '37' '38' '39' '40' '41' '42' ...
    '43' '44' '45' '46' '47' '48' '49' '50' '51' '52' '53' '54' '55' ...
    '56' '57' '58' '59' '60' '61' '62' '63' '64' '65' '66' '67' '68' '69'}';

SoilSystemNDVIVars = {'Array ID' 'Year' 'Day' 'HHMM' 'Dry_Red_in' ...
    'Dry_NIR_in' 'Dry_Red_out_1' 'Dry_Red_out_2' 'Dry_NIR_out_1' ...
    'Dry_NIR_out_2' 'Amb_Red_in' 'Amb_NIR_in' 'Amb_Red_out_1' ...
    'Amb_Red_out_2' 'Amb_NIR_out_1' 'Amb_NIR_out_2' 'Wet_Red_in' ...
    'Wet_NIR_in' 'Wet_Red_out_1' 'Wet_Red_out_2' 'Wet_NIR_out_1' ...
    'Wet_NIR_out_2' 'Dry_NDVI_1' 'Dry_NDVI_2' 'Amb_NDVI_1' 'Amb_NDVI_2' ...
    'Wet_NDVI_1' 'Wet_NDVI_2'; '1' '2' '3' '4' '5' '6' '7' '8' '9' '10' ...
    '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' ...
    '24' '25' '26' '27' '28'}';

SoilSystemHousekeepingVars = {'Array ID' 'Year' 'Day' 'HHMM' 'Tref' ...
    'V_batt' 'Watchdog' 'Overruns' 'LowVolt'; '1' '2' '3' '4' '5' '6' ...
    '7' '8' '9'}';

% Calculate NDVI: 
% ((NIRout/NIRin)-(Redout/(33*Redin)))/((NIRout/NIRin)+(Redout/(33*Redin)))
A = (CSCBAmb(:,29)./CSCBAmb(:,27));
B = (CSCBAmb(:,28)./(33*(CSCBAmb(:,26))));
C = (CSCBAmb(:,31)./CSCBAmb(:,27));
D = (CSCBAmb(:,30)./(33*(CSCBAmb(:,26))));
for i = 1:length(CSCBAmb(:,1))
    CSCBAmb(i,56) = (A(i) - B(i))/(A(i) + B(i));
    CSCBAmb(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (CSCBDry(:,29)./CSCBDry(:,27));
B = (CSCBDry(:,28)./(33*(CSCBDry(:,26))));
C = (CSCBDry(:,31)./CSCBDry(:,27));
D = (CSCBDry(:,30)./(33*(CSCBDry(:,26))));
for i = 1:length(CSCBDry(:,1))
    CSCBDry(i,56) = (A(i) - B(i))/(A(i) + B(i));
    CSCBDry(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (CSCBWet(:,29)./CSCBWet(:,27));
B = (CSCBWet(:,28)./(33*(CSCBWet(:,26))));
C = (CSCBWet(:,31)./CSCBWet(:,27));
D = (CSCBWet(:,30)./(33*(CSCBWet(:,26))));
for i = 1:length(CSCBWet(:,1))
    CSCBWet(i,56) = (A(i) - B(i))/(A(i) + B(i));
    CSCBWet(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (CSCBNDVI(:,9)./CSCBNDVI(:,6));
B = (CSCBNDVI(:,7)./(33*(CSCBNDVI(:,5))));
C = (CSCBNDVI(:,10)./CSCBNDVI(:,6));
D = (CSCBNDVI(:,8)./(33*(CSCBNDVI(:,5))));
E = (CSCBNDVI(:,15)./CSCBNDVI(:,12));
F = (CSCBNDVI(:,13)./(33*(CSCBNDVI(:,11))));
G = (CSCBNDVI(:,16)./CSCBNDVI(:,6));
H = (CSCBNDVI(:,14)./(33*(CSCBNDVI(:,5))));
J = (CSCBNDVI(:,21)./CSCBNDVI(:,18));
K = (CSCBNDVI(:,19)./(33*(CSCBNDVI(:,17))));
L = (CSCBNDVI(:,22)./CSCBNDVI(:,18));
M = (CSCBNDVI(:,20)./(33*(CSCBNDVI(:,17))));
for i = 1:length(CSCBNDVI(:,1))
    CSCBNDVI(i,23) = (A(i) - B(i))/(A(i) + B(i));
    CSCBNDVI(i,24) = (C(i) - D(i))/(C(i) + D(i));
    CSCBNDVI(i,25) = (E(i) - F(i))/(E(i) + F(i));
    CSCBNDVI(i,26) = (G(i) - H(i))/(G(i) + H(i));
    CSCBNDVI(i,27) = (J(i) - K(i))/(J(i) + K(i));
    CSCBNDVI(i,28) = (L(i) - M(i))/(L(i) + M(i));
end
clear A B C D E F G H J K L M;

fprintf('CSCB NDVI calculated\n');

% Calculate matric potential:
% (((delTmaxadj - D_Del)/(delTmaxadj - WetCalibAvg))^(-1/m) - 1)^(1/n)
% If you can't figure out -matric potential, consider a career change
for i = 1:length(CSCBAmb(:,1))
    CSCBAmb(i,58) = MPo * (((CSCBAmbdelTmaxadj(1) - CSCBAmb(i,50))/...
        (CSCBAmbdelTmaxadj(1) - CSCBAmbWetCalibVals(1,9)))^(1/m)-1);
    CSCBAmb(i,59) = MPo * (((CSCBAmbdelTmaxadj(2) - CSCBAmb(i,51))/...
        (CSCBAmbdelTmaxadj(2) - CSCBAmbWetCalibVals(2,9)))^(1/m)-1);
    CSCBAmb(i,60) = MPo * (((CSCBAmbdelTmaxadj(3) - CSCBAmb(i,52))/...
        (CSCBAmbdelTmaxadj(3) - CSCBAmbWetCalibVals(3,9)))^(1/m)-1);
    CSCBAmb(i,61) = MPo * (((CSCBAmbdelTmaxadj(4) - CSCBAmb(i,53))/...
        (CSCBAmbdelTmaxadj(4) - CSCBAmbWetCalibVals(4,9)))^(1/m)-1);
    CSCBAmb(i,62) = MPo * (((CSCBAmbdelTmaxadj(5) - CSCBAmb(i,54))/...
        (CSCBAmbdelTmaxadj(5) - CSCBAmbWetCalibVals(5,9)))^(1/m)-1);
    CSCBAmb(i,63) = MPo * (((CSCBAmbdelTmaxadj(6) - CSCBAmb(i,55))/...
        (CSCBAmbdelTmaxadj(6) - CSCBAmbWetCalibVals(6,9)))^(1/m)-1);
    CSCBAmb(i,64) = -CSCBAmb(i,58);
    CSCBAmb(i,65) = -CSCBAmb(i,59);
    CSCBAmb(i,66) = -CSCBAmb(i,60);
    CSCBAmb(i,67) = -CSCBAmb(i,61);
    CSCBAmb(i,68) = -CSCBAmb(i,62);
    CSCBAmb(i,69) = -CSCBAmb(i,63);
end

fprintf('CSCB ambient matric potentials calculated\n');

for i = 1:length(CSCBDry(:,1))
    CSCBDry(i,58) = MPo * (((CSCBDrydelTmaxadj(1) - CSCBDry(i,50))/...
        (CSCBDrydelTmaxadj(1) - CSCBDryWetCalibVals(1,9)))^(1/m)-1);
    CSCBDry(i,59) = MPo * (((CSCBDrydelTmaxadj(2) - CSCBDry(i,51))/...
        (CSCBDrydelTmaxadj(2) - CSCBDryWetCalibVals(2,9)))^(1/m)-1);
    CSCBDry(i,60) = MPo * (((CSCBDrydelTmaxadj(3) - CSCBDry(i,52))/...
        (CSCBDrydelTmaxadj(3) - CSCBDryWetCalibVals(3,9)))^(1/m)-1);
    CSCBDry(i,61) = MPo * (((CSCBDrydelTmaxadj(4) - CSCBDry(i,53))/...
        (CSCBDrydelTmaxadj(4) - CSCBDryWetCalibVals(4,9)))^(1/m)-1);
    CSCBDry(i,62) = MPo * (((CSCBDrydelTmaxadj(5) - CSCBDry(i,54))/...
        (CSCBDrydelTmaxadj(5) - CSCBDryWetCalibVals(5,9)))^(1/m)-1);
    CSCBDry(i,63) = MPo * (((CSCBDrydelTmaxadj(6) - CSCBDry(i,55))/...
        (CSCBDrydelTmaxadj(6) - CSCBDryWetCalibVals(6,9)))^(1/m)-1);
    CSCBDry(i,64) = -CSCBDry(i,58);
    CSCBDry(i,65) = -CSCBDry(i,59);
    CSCBDry(i,66) = -CSCBDry(i,60);
    CSCBDry(i,67) = -CSCBDry(i,61);
    CSCBDry(i,68) = -CSCBDry(i,62);
    CSCBDry(i,69) = -CSCBDry(i,63);
end

fprintf('CSCB dry matric potentials calculated\n');

for i = 1:length(CSCBWet(:,1))
    CSCBWet(i,58) = MPo * (((CSCBWetdelTmaxadj(1) - CSCBWet(i,50))/...
        (CSCBWetdelTmaxadj(1) - CSCBWetWetCalibVals(1,9)))^(1/m)-1);
    CSCBWet(i,59) = MPo * (((CSCBWetdelTmaxadj(2) - CSCBWet(i,51))/...
        (CSCBWetdelTmaxadj(2) - CSCBWetWetCalibVals(2,9)))^(1/m)-1);
    CSCBWet(i,60) = MPo * (((CSCBWetdelTmaxadj(3) - CSCBWet(i,52))/...
        (CSCBWetdelTmaxadj(3) - CSCBWetWetCalibVals(3,9)))^(1/m)-1);
    CSCBWet(i,61) = MPo * (((CSCBWetdelTmaxadj(4) - CSCBWet(i,53))/...
        (CSCBWetdelTmaxadj(4) - CSCBWetWetCalibVals(4,9)))^(1/m)-1);
    CSCBWet(i,62) = MPo * (((CSCBWetdelTmaxadj(5) - CSCBWet(i,54))/...
        (CSCBWetdelTmaxadj(5) - CSCBWetWetCalibVals(5,9)))^(1/m)-1);
    CSCBWet(i,63) = MPo * (((CSCBWetdelTmaxadj(6) - CSCBWet(i,55))/...
        (CSCBWetdelTmaxadj(6) - CSCBWetWetCalibVals(6,9)))^(1/m)-1);
    CSCBWet(i,64) = -CSCBWet(i,58);
    CSCBWet(i,65) = -CSCBWet(i,59);
    CSCBWet(i,66) = -CSCBWet(i,60);
    CSCBWet(i,67) = -CSCBWet(i,61);
    CSCBWet(i,68) = -CSCBWet(i,62);
    CSCBWet(i,69) = -CSCBWet(i,63);
end

fprintf('CSCB wet matric potentials calculated\n');

A = (CSWFAmb(:,29)./CSWFAmb(:,27));
B = (CSWFAmb(:,28)./(33*(CSWFAmb(:,26))));
C = (CSWFAmb(:,31)./CSWFAmb(:,27));
D = (CSWFAmb(:,30)./(33*(CSWFAmb(:,26))));
for i = 1:length(CSWFAmb(:,1))
    CSWFAmb(i,56) = (A(i) - B(i))/(A(i) + B(i));
    CSWFAmb(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (CSWFDry(:,29)./CSWFDry(:,27));
B = (CSWFDry(:,28)./(33*(CSWFDry(:,26))));
C = (CSWFDry(:,31)./CSWFDry(:,27));
D = (CSWFDry(:,30)./(33*(CSWFDry(:,26))));
for i = 1:length(CSWFDry(:,1))
    CSWFDry(i,56) = (A(i) - B(i))/(A(i) + B(i));
    CSWFDry(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (CSWFWet(:,29)./CSWFWet(:,27));
B = (CSWFWet(:,28)./(33*(CSWFWet(:,26))));
C = (CSWFWet(:,31)./CSWFWet(:,27));
D = (CSWFWet(:,30)./(33*(CSWFWet(:,26))));
for i = 1:length(CSWFWet(:,1))
    CSWFWet(i,56) = (A(i) - B(i))/(A(i) + B(i));
    CSWFWet(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (CSWFNDVI(:,9)./CSWFNDVI(:,6));
B = (CSWFNDVI(:,7)./(33*(CSWFNDVI(:,5))));
C = (CSWFNDVI(:,10)./CSWFNDVI(:,6));
D = (CSWFNDVI(:,8)./(33*(CSWFNDVI(:,5))));
E = (CSWFNDVI(:,15)./CSWFNDVI(:,12));
F = (CSWFNDVI(:,13)./(33*(CSWFNDVI(:,11))));
G = (CSWFNDVI(:,16)./CSWFNDVI(:,6));
H = (CSWFNDVI(:,14)./(33*(CSWFNDVI(:,5))));
J = (CSWFNDVI(:,21)./CSWFNDVI(:,18));
K = (CSWFNDVI(:,19)./(33*(CSWFNDVI(:,17))));
L = (CSWFNDVI(:,22)./CSWFNDVI(:,18));
M = (CSWFNDVI(:,20)./(33*(CSWFNDVI(:,17))));
for i = 1:length(CSWFNDVI(:,1))
    CSWFNDVI(i,23) = (A(i) - B(i))/(A(i) + B(i));
    CSWFNDVI(i,24) = (C(i) - D(i))/(C(i) + D(i));
    CSWFNDVI(i,25) = (E(i) - F(i))/(E(i) + F(i));
    CSWFNDVI(i,26) = (G(i) - H(i))/(G(i) + H(i));
    CSWFNDVI(i,27) = (J(i) - K(i))/(J(i) + K(i));
    CSWFNDVI(i,28) = (L(i) - M(i))/(L(i) + M(i));
end
clear A B C D E F G H J K L M;

fprintf('CSWF NDVI calculated\n');

for i = 1:length(CSWFAmb(:,1))
    CSWFAmb(i,58) = MPo * (((CSWFAmbdelTmaxadj(1) - CSWFAmb(i,50))/...
        (CSWFAmbdelTmaxadj(1) - CSWFAmbWetCalibVals(1,9)))^(1/m)-1);
    CSWFAmb(i,59) = MPo * (((CSWFAmbdelTmaxadj(2) - CSWFAmb(i,51))/...
        (CSWFAmbdelTmaxadj(2) - CSWFAmbWetCalibVals(2,9)))^(1/m)-1);
    CSWFAmb(i,60) = MPo * (((CSWFAmbdelTmaxadj(3) - CSWFAmb(i,52))/...
        (CSWFAmbdelTmaxadj(3) - CSWFAmbWetCalibVals(3,9)))^(1/m)-1);
    CSWFAmb(i,61) = MPo * (((CSWFAmbdelTmaxadj(4) - CSWFAmb(i,53))/...
        (CSWFAmbdelTmaxadj(4) - CSWFAmbWetCalibVals(4,9)))^(1/m)-1);
    CSWFAmb(i,62) = MPo * (((CSWFAmbdelTmaxadj(5) - CSWFAmb(i,54))/...
        (CSWFAmbdelTmaxadj(5) - CSWFAmbWetCalibVals(5,9)))^(1/m)-1);
    CSWFAmb(i,63) = MPo * (((CSWFAmbdelTmaxadj(6) - CSWFAmb(i,55))/...
        (CSWFAmbdelTmaxadj(6) - CSWFAmbWetCalibVals(6,9)))^(1/m)-1);
    CSWFAmb(i,64) = -CSWFAmb(i,58);
    CSWFAmb(i,65) = -CSWFAmb(i,59);
    CSWFAmb(i,66) = -CSWFAmb(i,60);
    CSWFAmb(i,67) = -CSWFAmb(i,61);
    CSWFAmb(i,68) = -CSWFAmb(i,62);
    CSWFAmb(i,69) = -CSWFAmb(i,63);
end

fprintf('CSWF ambient matric potentials calculated\n');

for i = 1:length(CSWFDry(:,1))
    CSWFDry(i,58) = MPo * (((CSWFDrydelTmaxadj(1) - CSWFDry(i,50))/...
        (CSWFDrydelTmaxadj(1) - CSWFDryWetCalibVals(1,9)))^(1/m)-1);
    CSWFDry(i,59) = MPo * (((CSWFDrydelTmaxadj(2) - CSWFDry(i,51))/...
        (CSWFDrydelTmaxadj(2) - CSWFDryWetCalibVals(2,9)))^(1/m)-1);
    CSWFDry(i,60) = MPo * (((CSWFDrydelTmaxadj(3) - CSWFDry(i,52))/...
        (CSWFDrydelTmaxadj(3) - CSWFDryWetCalibVals(3,9)))^(1/m)-1);
    CSWFDry(i,61) = MPo * (((CSWFDrydelTmaxadj(4) - CSWFDry(i,53))/...
        (CSWFDrydelTmaxadj(4) - CSWFDryWetCalibVals(4,9)))^(1/m)-1);
    CSWFDry(i,62) = MPo * (((CSWFDrydelTmaxadj(5) - CSWFDry(i,54))/...
        (CSWFDrydelTmaxadj(5) - CSWFDryWetCalibVals(5,9)))^(1/m)-1);
    CSWFDry(i,63) = MPo * (((CSWFDrydelTmaxadj(6) - CSWFDry(i,55))/...
        (CSWFDrydelTmaxadj(6) - CSWFDryWetCalibVals(6,9)))^(1/m)-1);
    CSWFDry(i,64) = -CSWFDry(i,58);
    CSWFDry(i,65) = -CSWFDry(i,59);
    CSWFDry(i,66) = -CSWFDry(i,60);
    CSWFDry(i,67) = -CSWFDry(i,61);
    CSWFDry(i,68) = -CSWFDry(i,62);
    CSWFDry(i,69) = -CSWFDry(i,63);
end

fprintf('CSWF dry matric potentials calculated\n');

for i = 1:length(CSWFWet(:,1))
    CSWFWet(i,58) = MPo * (((CSWFWetdelTmaxadj(1) - CSWFWet(i,50))/...
        (CSWFWetdelTmaxadj(1) - CSWFWetWetCalibVals(1,9)))^(1/m)-1);
    CSWFWet(i,59) = MPo * (((CSWFWetdelTmaxadj(2) - CSWFWet(i,51))/...
        (CSWFWetdelTmaxadj(2) - CSWFWetWetCalibVals(2,9)))^(1/m)-1);
    CSWFWet(i,60) = MPo * (((CSWFWetdelTmaxadj(3) - CSWFWet(i,52))/...
        (CSWFWetdelTmaxadj(3) - CSWFWetWetCalibVals(3,9)))^(1/m)-1);
    CSWFWet(i,61) = MPo * (((CSWFWetdelTmaxadj(4) - CSWFWet(i,53))/...
        (CSWFWetdelTmaxadj(4) - CSWFWetWetCalibVals(4,9)))^(1/m)-1);
    CSWFWet(i,62) = MPo * (((CSWFWetdelTmaxadj(5) - CSWFWet(i,54))/...
        (CSWFWetdelTmaxadj(5) - CSWFWetWetCalibVals(5,9)))^(1/m)-1);
    CSWFWet(i,63) = MPo * (((CSWFWetdelTmaxadj(6) - CSWFWet(i,55))/...
        (CSWFWetdelTmaxadj(6) - CSWFWetWetCalibVals(6,9)))^(1/m)-1);
    CSWFWet(i,64) = -CSWFWet(i,58);
    CSWFWet(i,65) = -CSWFWet(i,59);
    CSWFWet(i,66) = -CSWFWet(i,60);
    CSWFWet(i,67) = -CSWFWet(i,61);
    CSWFWet(i,68) = -CSWFWet(i,62);
    CSWFWet(i,69) = -CSWFWet(i,63);
end

fprintf('CSWF wet matric potentials calculated\n');

A = (GLCBAmb(:,29)./GLCBAmb(:,27));
B = (GLCBAmb(:,28)./(33*(GLCBAmb(:,26))));
C = (GLCBAmb(:,31)./GLCBAmb(:,27));
D = (GLCBAmb(:,30)./(33*(GLCBAmb(:,26))));
for i = 1:length(GLCBAmb(:,1))
    GLCBAmb(i,56) = (A(i) - B(i))/(A(i) + B(i));
    GLCBAmb(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (GLCBDry(:,29)./GLCBDry(:,27));
B = (GLCBDry(:,28)./(33*(GLCBDry(:,26))));
C = (GLCBDry(:,31)./GLCBDry(:,27));
D = (GLCBDry(:,30)./(33*(GLCBDry(:,26))));
for i = 1:length(GLCBDry(:,1))
    GLCBDry(i,56) = (A(i) - B(i))/(A(i) + B(i));
    GLCBDry(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (GLCBWet(:,29)./GLCBWet(:,27));
B = (GLCBWet(:,28)./(33*(GLCBWet(:,26))));
C = (GLCBWet(:,31)./GLCBWet(:,27));
D = (GLCBWet(:,30)./(33*(GLCBWet(:,26))));
for i = 1:length(GLCBWet(:,1))
    GLCBWet(i,56) = (A(i) - B(i))/(A(i) + B(i));
    GLCBWet(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (GLCBNDVI(:,9)./GLCBNDVI(:,6));
B = (GLCBNDVI(:,7)./(33*(GLCBNDVI(:,5))));
C = (GLCBNDVI(:,10)./GLCBNDVI(:,6));
D = (GLCBNDVI(:,8)./(33*(GLCBNDVI(:,5))));
E = (GLCBNDVI(:,15)./GLCBNDVI(:,12));
F = (GLCBNDVI(:,13)./(33*(GLCBNDVI(:,11))));
G = (GLCBNDVI(:,16)./GLCBNDVI(:,6));
H = (GLCBNDVI(:,14)./(33*(GLCBNDVI(:,5))));
J = (GLCBNDVI(:,21)./GLCBNDVI(:,18));
K = (GLCBNDVI(:,19)./(33*(GLCBNDVI(:,17))));
L = (GLCBNDVI(:,22)./GLCBNDVI(:,18));
M = (GLCBNDVI(:,20)./(33*(GLCBNDVI(:,17))));
for i = 1:length(GLCBNDVI(:,1))
    GLCBNDVI(i,23) = (A(i) - B(i))/(A(i) + B(i));
    GLCBNDVI(i,24) = (C(i) - D(i))/(C(i) + D(i));
    GLCBNDVI(i,25) = (E(i) - F(i))/(E(i) + F(i));
    GLCBNDVI(i,26) = (G(i) - H(i))/(G(i) + H(i));
    GLCBNDVI(i,27) = (J(i) - K(i))/(J(i) + K(i));
    GLCBNDVI(i,28) = (L(i) - M(i))/(L(i) + M(i));
end
clear A B C D E F G H J K L M;

fprintf('GLCB NDVI calculated\n');

for i = 1:length(GLCBAmb(:,1))
    GLCBAmb(i,58) = MPo * (((GLCBAmbdelTmaxadj(1) - GLCBAmb(i,50))/...
        (GLCBAmbdelTmaxadj(1) - GLCBAmbWetCalibVals(1,9)))^(1/m)-1);
    GLCBAmb(i,59) = MPo * (((GLCBAmbdelTmaxadj(2) - GLCBAmb(i,51))/...
        (GLCBAmbdelTmaxadj(2) - GLCBAmbWetCalibVals(2,9)))^(1/m)-1);
    GLCBAmb(i,60) = MPo * (((GLCBAmbdelTmaxadj(3) - GLCBAmb(i,52))/...
        (GLCBAmbdelTmaxadj(3) - GLCBAmbWetCalibVals(3,9)))^(1/m)-1);
    GLCBAmb(i,61) = MPo * (((GLCBAmbdelTmaxadj(4) - GLCBAmb(i,53))/...
        (GLCBAmbdelTmaxadj(4) - GLCBAmbWetCalibVals(4,9)))^(1/m)-1);
    GLCBAmb(i,62) = MPo * (((GLCBAmbdelTmaxadj(5) - GLCBAmb(i,54))/...
        (GLCBAmbdelTmaxadj(5) - GLCBAmbWetCalibVals(5,9)))^(1/m)-1);
    GLCBAmb(i,63) = MPo * (((GLCBAmbdelTmaxadj(6) - GLCBAmb(i,55))/...
        (GLCBAmbdelTmaxadj(6) - GLCBAmbWetCalibVals(6,9)))^(1/m)-1);
    GLCBAmb(i,64) = -GLCBAmb(i,58);
    GLCBAmb(i,65) = -GLCBAmb(i,59);
    GLCBAmb(i,66) = -GLCBAmb(i,60);
    GLCBAmb(i,67) = -GLCBAmb(i,61);
    GLCBAmb(i,68) = -GLCBAmb(i,62);
    GLCBAmb(i,69) = -GLCBAmb(i,63);
end

fprintf('GLCB ambient matric potentials calculated\n');

for i = 1:length(GLCBDry(:,1))
    GLCBDry(i,58) = MPo * (((GLCBDrydelTmaxadj(1) - GLCBDry(i,50))/...
        (GLCBDrydelTmaxadj(1) - GLCBDryWetCalibVals(1,9)))^(1/m)-1);
    GLCBDry(i,59) = MPo * (((GLCBDrydelTmaxadj(2) - GLCBDry(i,51))/...
        (GLCBDrydelTmaxadj(2) - GLCBDryWetCalibVals(2,9)))^(1/m)-1);
    GLCBDry(i,60) = MPo * (((GLCBDrydelTmaxadj(3) - GLCBDry(i,52))/...
        (GLCBDrydelTmaxadj(3) - GLCBDryWetCalibVals(3,9)))^(1/m)-1);
    GLCBDry(i,61) = MPo * (((GLCBDrydelTmaxadj(4) - GLCBDry(i,53))/...
        (GLCBDrydelTmaxadj(4) - GLCBDryWetCalibVals(4,9)))^(1/m)-1);
    GLCBDry(i,62) = MPo * (((GLCBDrydelTmaxadj(5) - GLCBDry(i,54))/...
        (GLCBDrydelTmaxadj(5) - GLCBDryWetCalibVals(5,9)))^(1/m)-1);
    GLCBDry(i,63) = MPo * (((GLCBDrydelTmaxadj(6) - GLCBDry(i,55))/...
        (GLCBDrydelTmaxadj(6) - GLCBDryWetCalibVals(6,9)))^(1/m)-1);
    GLCBDry(i,64) = -GLCBDry(i,58);
    GLCBDry(i,65) = -GLCBDry(i,59);
    GLCBDry(i,66) = -GLCBDry(i,60);
    GLCBDry(i,67) = -GLCBDry(i,61);
    GLCBDry(i,68) = -GLCBDry(i,62);
    GLCBDry(i,69) = -GLCBDry(i,63);
end

fprintf('GLCB dry matric potentials calculated\n');

for i = 1:length(GLCBWet(:,1))
    GLCBWet(i,58) = MPo * (((GLCBWetdelTmaxadj(1) - GLCBWet(i,50))/...
        (GLCBWetdelTmaxadj(1) - GLCBWetWetCalibVals(1,9)))^(1/m)-1);
    GLCBWet(i,59) = MPo * (((GLCBWetdelTmaxadj(2) - GLCBWet(i,51))/...
        (GLCBWetdelTmaxadj(2) - GLCBWetWetCalibVals(2,9)))^(1/m)-1);
    GLCBWet(i,60) = MPo * (((GLCBWetdelTmaxadj(3) - GLCBWet(i,52))/...
        (GLCBWetdelTmaxadj(3) - GLCBWetWetCalibVals(3,9)))^(1/m)-1);
    GLCBWet(i,61) = MPo * (((GLCBWetdelTmaxadj(4) - GLCBWet(i,53))/...
        (GLCBWetdelTmaxadj(4) - GLCBWetWetCalibVals(4,9)))^(1/m)-1);
    GLCBWet(i,62) = MPo * (((GLCBWetdelTmaxadj(5) - GLCBWet(i,54))/...
        (GLCBWetdelTmaxadj(5) - GLCBWetWetCalibVals(5,9)))^(1/m)-1);
    GLCBWet(i,63) = MPo * (((GLCBWetdelTmaxadj(6) - GLCBWet(i,55))/...
        (GLCBWetdelTmaxadj(6) - GLCBWetWetCalibVals(6,9)))^(1/m)-1);
    GLCBWet(i,64) = -GLCBWet(i,58);
    GLCBWet(i,65) = -GLCBWet(i,59);
    GLCBWet(i,66) = -GLCBWet(i,60);
    GLCBWet(i,67) = -GLCBWet(i,61);
    GLCBWet(i,68) = -GLCBWet(i,62);
    GLCBWet(i,69) = -GLCBWet(i,63);
end

fprintf('GLCB wet matric potentials calculated\n');

A = (GLWFAmb(:,29)./GLWFAmb(:,27));
B = (GLWFAmb(:,28)./(33*(GLWFAmb(:,26))));
C = (GLWFAmb(:,31)./GLWFAmb(:,27));
D = (GLWFAmb(:,30)./(33*(GLWFAmb(:,26))));
for i = 1:length(GLWFAmb(:,1))
    GLWFAmb(i,56) = (A(i) - B(i))/(A(i) + B(i));
    GLWFAmb(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (GLWFDry(:,29)./GLWFDry(:,27));
B = (GLWFDry(:,28)./(33*(GLWFDry(:,26))));
C = (GLWFDry(:,31)./GLWFDry(:,27));
D = (GLWFDry(:,30)./(33*(GLWFDry(:,26))));
for i = 1:length(GLWFDry(:,1))
    GLWFDry(i,56) = (A(i) - B(i))/(A(i) + B(i));
    GLWFry(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (GLWFWet(:,29)./GLWFWet(:,27));
B = (GLWFWet(:,28)./(33*(GLWFWet(:,26))));
C = (GLWFWet(:,31)./GLWFWet(:,27));
D = (GLWFWet(:,30)./(33*(GLWFWet(:,26))));
for i = 1:length(GLWFWet(:,1))
    GLWFWet(i,56) = (A(i) - B(i))/(A(i) + B(i));
    GLWFWet(i,57) = (C(i) - D(i))/(C(i) + D(i));
end
clear A B C D;

A = (GLWFNDVI(:,9)./GLWFNDVI(:,6));
B = (GLWFNDVI(:,7)./(33*(GLWFNDVI(:,5))));
C = (GLWFNDVI(:,10)./GLWFNDVI(:,6));
D = (GLWFNDVI(:,8)./(33*(GLWFNDVI(:,5))));
E = (GLWFNDVI(:,15)./GLWFNDVI(:,12));
F = (GLWFNDVI(:,13)./(33*(GLWFNDVI(:,11))));
G = (GLWFNDVI(:,16)./GLWFNDVI(:,6));
H = (GLWFNDVI(:,14)./(33*(GLWFNDVI(:,5))));
J = (GLWFNDVI(:,21)./GLWFNDVI(:,18));
K = (GLWFNDVI(:,19)./(33*(GLWFNDVI(:,17))));
L = (GLWFNDVI(:,22)./GLWFNDVI(:,18));
M = (GLWFNDVI(:,20)./(33*(GLWFNDVI(:,17))));
for i = 1:length(GLWFNDVI(:,1))
    GLWFNDVI(i,23) = (A(i) - B(i))/(A(i) + B(i));
    GLWFNDVI(i,24) = (C(i) - D(i))/(C(i) + D(i));
    GLWFNDVI(i,25) = (E(i) - F(i))/(E(i) + F(i));
    GLWFNDVI(i,26) = (G(i) - H(i))/(G(i) + H(i));
    GLWFNDVI(i,27) = (J(i) - K(i))/(J(i) + K(i));
    GLWFNDVI(i,28) = (L(i) - M(i))/(L(i) + M(i));
end
clear A B C D E F G H J K L M;

fprintf('GLWF NDVI calculated\n');

for i = 1:length(GLWFAmb(:,1))
    GLWFAmb(i,58) = MPo * (((GLWFAmbdelTmaxadj(1) - GLWFAmb(i,50))/...
        (GLWFAmbdelTmaxadj(1) - GLWFAmbWetCalibVals(1,9)))^(1/m)-1);
    GLWFAmb(i,59) = MPo * (((GLWFAmbdelTmaxadj(2) - GLWFAmb(i,51))/...
        (GLWFAmbdelTmaxadj(2) - GLWFAmbWetCalibVals(2,9)))^(1/m)-1);
    GLWFAmb(i,60) = MPo * (((GLWFAmbdelTmaxadj(3) - GLWFAmb(i,52))/...
        (GLWFAmbdelTmaxadj(3) - GLWFAmbWetCalibVals(3,9)))^(1/m)-1);
    GLWFAmb(i,61) = MPo * (((GLWFAmbdelTmaxadj(4) - GLWFAmb(i,53))/...
        (GLWFAmbdelTmaxadj(4) - GLWFAmbWetCalibVals(4,9)))^(1/m)-1);
    GLWFAmb(i,62) = MPo * (((GLWFAmbdelTmaxadj(5) - GLWFAmb(i,54))/...
        (GLWFAmbdelTmaxadj(5) - GLWFAmbWetCalibVals(5,9)))^(1/m)-1);
    GLWFAmb(i,63) = MPo * (((GLWFAmbdelTmaxadj(6) - GLWFAmb(i,55))/...
        (GLWFAmbdelTmaxadj(6) - GLWFAmbWetCalibVals(6,9)))^(1/m)-1);
    GLWFAmb(i,64) = -GLWFAmb(i,58);
    GLWFAmb(i,65) = -GLWFAmb(i,59);
    GLWFAmb(i,66) = -GLWFAmb(i,60);
    GLWFAmb(i,67) = -GLWFAmb(i,61);
    GLWFAmb(i,68) = -GLWFAmb(i,62);
    GLWFAmb(i,69) = -GLWFAmb(i,63);
end

fprintf('GLWF ambient matric potentials calculated\n');

for i = 1:length(GLWFDry(:,1))
    GLWFDry(i,58) = MPo * (((GLWFDrydelTmaxadj(1) - GLWFDry(i,50))/...
        (GLWFDrydelTmaxadj(1) - GLWFDryWetCalibVals(1,9)))^(1/m)-1);
    GLWFDry(i,59) = MPo * (((GLWFDrydelTmaxadj(2) - GLWFDry(i,51))/...
        (GLWFDrydelTmaxadj(2) - GLWFDryWetCalibVals(2,9)))^(1/m)-1);
    GLWFDry(i,60) = MPo * (((GLWFDrydelTmaxadj(3) - GLWFDry(i,52))/...
        (GLWFDrydelTmaxadj(3) - GLWFDryWetCalibVals(3,9)))^(1/m)-1);
    GLWFDry(i,61) = MPo * (((GLWFDrydelTmaxadj(4) - GLWFDry(i,53))/...
        (GLWFDrydelTmaxadj(4) - GLWFDryWetCalibVals(4,9)))^(1/m)-1);
    GLWFDry(i,62) = MPo * (((GLWFDrydelTmaxadj(5) - GLWFDry(i,54))/...
        (GLWFDrydelTmaxadj(5) - GLWFDryWetCalibVals(5,9)))^(1/m)-1);
    GLWFDry(i,63) = MPo * (((GLWFDrydelTmaxadj(6) - GLWFDry(i,55))/...
        (GLWFDrydelTmaxadj(6) - GLWFDryWetCalibVals(6,9)))^(1/m)-1);
    GLWFDry(i,64) = -GLWFDry(i,58);
    GLWFDry(i,65) = -GLWFDry(i,59);
    GLWFDry(i,66) = -GLWFDry(i,60);
    GLWFDry(i,67) = -GLWFDry(i,61);
    GLWFDry(i,68) = -GLWFDry(i,62);
    GLWFDry(i,69) = -GLWFDry(i,63);
end

fprintf('GLWF dry matric potentials calculated\n');

for i = 1:length(GLWFWet(:,1))
    GLWFWet(i,58) = MPo * (((GLWFWetdelTmaxadj(1) - GLWFWet(i,50))/...
        (GLWFWetdelTmaxadj(1) - GLWFWetWetCalibVals(1,9)))^(1/m)-1);
    GLWFWet(i,59) = MPo * (((GLWFWetdelTmaxadj(2) - GLWFWet(i,51))/...
        (GLWFWetdelTmaxadj(2) - GLWFWetWetCalibVals(2,9)))^(1/m)-1);
    GLWFWet(i,60) = MPo * (((GLWFWetdelTmaxadj(3) - GLWFWet(i,52))/...
        (GLWFWetdelTmaxadj(3) - GLWFWetWetCalibVals(3,9)))^(1/m)-1);
    GLWFWet(i,61) = MPo * (((GLWFWetdelTmaxadj(4) - GLWFWet(i,53))/...
        (GLWFWetdelTmaxadj(4) - GLWFWetWetCalibVals(4,9)))^(1/m)-1);
    GLWFWet(i,62) = MPo * (((GLWFWetdelTmaxadj(5) - GLWFWet(i,54))/...
        (GLWFWetdelTmaxadj(5) - GLWFWetWetCalibVals(5,9)))^(1/m)-1);
    GLWFWet(i,63) = MPo * (((GLWFWetdelTmaxadj(6) - GLWFWet(i,55))/...
        (GLWFWetdelTmaxadj(6) - GLWFWetWetCalibVals(6,9)))^(1/m)-1);
    GLWFWet(i,64) = -GLWFWet(i,58);
    GLWFWet(i,65) = -GLWFWet(i,59);
    GLWFWet(i,66) = -GLWFWet(i,60);
    GLWFWet(i,67) = -GLWFWet(i,61);
    GLWFWet(i,68) = -GLWFWet(i,62);
    GLWFWet(i,69) = -GLWFWet(i,63);
end

fprintf('GLWF wet matric potentials calculated\n');


%%
% Save everything
save('CSCBAmb.mat','CSCBAmb');
save('CSCBDry.mat','CSCBDry');
save('CSCBWet.mat','CSCBWet');
save('CSCBNDVI.mat','CSCBNDVI');
save('CSCBHousekeeping.mat','CSCBHousekeeping');
save('CSWFAmb.mat','CSWFAmb');
save('CSWFDry.mat','CSWFDry');
save('CSWFWet.mat','CSWFWet');
save('CSWFNDVI.mat','CSWFNDVI');
save('CSWFHousekeeping.mat','CSWFHousekeeping');
save('GLCBAmb.mat','GLCBAmb');
save('GLCBDry.mat','GLCBDry');
save('GLCBWet.mat','GLCBWet');
save('GLCBNDVI.mat','GLCBNDVI');
save('GLCBHousekeeping.mat','GLCBHousekeeping');
save('GLWFAmb.mat','GLWFAmb');
save('GLWFDry.mat','GLWFDry');
save('GLWFWet.mat','GLWFWet');
save('GLWFNDVI.mat','GLWFNDVI');
save('GLWFHousekeeping.mat','GLWFHousekeeping');

fprintf('Files successfully saved\n');