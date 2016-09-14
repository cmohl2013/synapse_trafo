function [channel channelname] = ImarisChannelSelectorGui(aDataSet)


% input channel
cNames = getImarisChannelNames(aDataSet);
channel = listdlg('PromptString','Select channel','ListString',cNames,'SelectionMode','single')-1;
channelname = cNames{channel+1};