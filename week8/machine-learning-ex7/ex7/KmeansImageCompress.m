% Copyright (C) 2020 Thomas Joseph
% 
% This program is free software: you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see
% <https://www.gnu.org/licenses/>.

% -*- texinfo -*- 
% @deftypefn {} {@var{retval} =} KmeansImageCompress (@var{input1}, @var{input2})
%
% @seealso{}
% @end deftypefn

% Author: Thomas Joseph <Thomas Joseph@DESKTOP-77GTTL0>
% Created: 2020-08-14

function compressedImage = KmeansImageCompress (Image, K)
  uncompressed = double(imread(Image));
  uncompressed = uncompressed/  255;
  im_size = size(uncompressed);
  red = uncompressed(:,:,1);
  green = uncompressed(:,:,2);
  blue = uncompressed(:,:,3);
  red_reduced = red(:)';
  green_reduced = green';
  blue_reduced = blue';
  [Ured,SUred] = pca(red_reduced);
  [Ugreen,Sgreen] = pca(green_reduced);
  [Ublue,Sblue] = pca(blue_reduced);
  %uncompressed = [red(:);green(:);blue(:)];
  %X = uncompressed';
  %[X_norm,mu,sigma] = featureNormalize(X);
  NumComponents = 1000;
  %[U,S] = pca(X_norm);
  Z = projectData(X_norm,U,NumComponents);
  [idx,centroids] = kmeans(Z,K);
  centroids = recoverData(centroids,U,NumComponents);
  %centroids = centroids*    sigma+  mu;
  compressedImage = centroids(idx,:);
  compressedImage = reshape(compressedImage,im_size(1),im_size(2),3);
end
