%% Detection results: movieInfo
%
%For a movie with N frames, movieInfo is a structure array with N entries.
%Every entry has the fields xCoord, yCoord, zCoord (if 3D) and amp.
%If there are M features in frame i, each one of these fields in
%moveiInfo(i) will be an Mx2 array, where the first column is the value
%(e.g. x-coordinate in xCoord and amplitude in amp) and the second column
%is the standard deviation. If the uncertainty is unknown, make the second
%column all zero.
%
%This is the automatic output of detectSubResFeatures2D_StandAlone, which
%is called via the accompanying "scriptDetectGeneral"
%This file is part of u-track.
%
%    u-track is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%    u-track is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with u-track.  If not, see <http://www.gnu.org/licenses/>.
%
%Copyright Jaqaman 01/08
%--------------------------------------------------------------------------
function tracksFinal = get_track(data, movieInfo, varargin)
display(sprintf('Cell Name : %s',data.cell_name));

parameter = {'load_file', 'save_file'};
default = {1, 0};
[load_file save_file]= parse_parameter(parameter, default, varargin);

file_name = strcat(data.path, 'output/track.mat');

if exist(file_name, 'file') && load_file,
    result = load(file_name);
    tracksFinal = result.tracksFinal;
    return;
else

%% Cost functions

%Frame-to-frame linking
costMatrices(1).funcName = 'costMatLinearMotionLink';

%Gap closing, merging and splitting
costMatrices(2).funcName = 'costMatLinearMotionCloseGaps';

%--------------------------------------------------------------------------

%% Kalman filter functions

%Memory reservation
kalmanFunctions.reserveMem = 'kalmanResMemLM';

%Filter initialization
kalmanFunctions.initialize = 'kalmanInitLinearMotion';

%Gain calculation based on linking history
kalmanFunctions.calcGain = 'kalmanGainLinearMotion';

%Time reversal for second and third rounds of linking
kalmanFunctions.timeReverse = 'kalmanReverseLinearMotion';

%--------------------------------------------------------------------------

%% General tracking parameters

%Gap closing time window
gapCloseParam.timeWindow = 3; %10;

%Flag for merging and splitting
gapCloseParam.mergeSplit = 1;

%Minimum track segment length used in the gap closing, merging and
%splitting step
gapCloseParam.minTrackLen = 2;

%--------------------------------------------------------------------------

%% Cost function specific parameters: Frame-to-frame linking

%Flag for linear motion
parameters.linearMotion = 1;

%Search radius lower limit
parameters.minSearchRadius = 2;

%Search radius upper limit
if isfield(data,'track_max_search_radius'),
    parameters.maxSearchRadius = data.track_max_search_radius;
else
    parameters.maxSearchRadius = 20; % 2 %20;
end;

%Standard deviation multiplication factor
parameters.brownStdMult = 3;

%Flag for using local density in search radius estimation
parameters.useLocalDensity = 1;

%Number of past frames used in nearest neighbor calculation
parameters.nnWindow = gapCloseParam.timeWindow;

%Store parameters for function call
costMatrices(1).parameters = parameters;
clear parameters

%--------------------------------------------------------------------------

%% Cost cunction specific parameters: Gap closing, merging and splitting

%Same parameters as for the frame-to-frame linking cost function
parameters.linearMotion = costMatrices(1).parameters.linearMotion;
parameters.useLocalDensity = costMatrices(1).parameters.useLocalDensity;
parameters.maxSearchRadius = costMatrices(1).parameters.maxSearchRadius;
parameters.minSearchRadius = costMatrices(1).parameters.minSearchRadius;
parameters.brownStdMult = costMatrices(1).parameters.brownStdMult*ones(gapCloseParam.timeWindow,1);
parameters.nnWindow = costMatrices(1).parameters.nnWindow;

%Gap length (frames) at which f(gap) (in search radius definition) reaches its
%plateau
parameters.timeReachConfB = 2;

%Amplitude ratio lower and upper limits
parameters.ampRatioLimit = [0.5 4];% [0.1 10]; %

%Minimum length (frames) for track segment analysis
parameters.lenForClassify = 5;

%Standard deviation multiplication factor along preferred direction of
%motion
parameters.linStdMult = 3*ones(gapCloseParam.timeWindow,1);

%Gap length (frames) at which f'(gap) (in definition of search radius
%parallel to preferred direction of motion) reaches its plateau
parameters.timeReachConfL = gapCloseParam.timeWindow;

%Maximum angle between the directions of motion of two linear track
%segments that are allowed to get linked
parameters.maxAngleVV = 45;

%Store parameters for function call
costMatrices(2).parameters = parameters;
clear parameters

%--------------------------------------------------------------------------

%% additional input

%saveResults
% saveResults.dir = 'C:\sylu\copy_07_19_2009-xxx\sof\fluocell_2.1\contrib\u-track\example\'; %directory where to save input and output
% saveResults.filename = 'testTracking.mat'; %name of file where input and output are saved
saveResults = 0; %don't save results

%verbose
verbose = 1;

%problem dimension
probDim = 2;

%--------------------------------------------------------------------------

%% tracking function call

[tracksFinal,kalmanInfoLink,errFlag] = trackCloseGapsKalman(movieInfo,...
    costMatrices,gapCloseParam,kalmanFunctions,probDim,saveResults,verbose);

%--------------------------------------------------------------------------

%% Output variables
if save_file,
    save(file_name, 'tracksFinal');
end;
%The important output variable is tracksFinal, which contains the tracks

%It is a structure array where each element corresponds to a compound
%track. Each element contains the following fields:
%           .ConnectMatrix: Connectivity matrix of features between
%                              frames, after gap closing. Number of rows
%                              = number of track segments in compound
%                              track. Number of columns = number of frames
%                              the compound track spans. Zeros indicate
%                              frames where track segments do not exist
%                              (either because those frames are before the
%                              segment starts or after it ends, or because
%                              of losing parts of a segment.
%           .CoordAmp: The positions and amplitudes of the tracked
%                              features, after gap closing. Number of rows
%                              = number of track segments in compound
%                              track. Number of columns = 8 * number of
%                              frames the compound track spans. Each row
%                              consists of
%                              [x1 y1 z1 a1 dx1 dy1 dz1 da1 x2 y2 z2 a2 dx2 dy2 dz2 da2 ...]
%                              NaN indicates frames where track segments do
%                              not exist, like the zeros above.
%           .seqOfEvents     : Matrix with number of rows equal to number
%                              of events happening in a track and 4
%                              columns:
%                              1st: Frame where event happens;
%                              2nd: 1 - start of track, 2 - end of track;
%                              3rd: Index of track segment that ends or starts;
%                              4th: NaN - start is a birth and end is a death,
%                                   number - start is due to a split, end
%                                   is due to a merge, number is the index
%                                   of track segment for the merge/split.
end; % if ~exist file_name
return;
