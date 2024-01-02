diary 'output';
diary on;

outFile = './data/genBill.xlsx';

if exist("outFile", 'file') ==2
  delete(outFile);
end

addpath(genpath('Configuration'));
init;
set_preferences; 
