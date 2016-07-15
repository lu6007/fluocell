function [ bwOut ] = detect_watershed( im, bwIn, varargin )
parameter_name = {'segment_method'};
default_value = {0};
[segment_method] = parse_parameter(parameter_name, default_value, varargin);

switch segment_method
    case 0
        bwOut = bwIn;
    case 1
        I = im.*uint16(bwIn); %Original image with bw 'mask' applied.

        D = -bwdist(~I); %Turns maximums into miminums
        mask = imextendedmin(D,2); %Finds minimums
        D2 = imimposemin(D, mask); 
        Ld = watershed(D2);
        bwIn(Ld == 0) = 0;
        bwOut = bwareaopen(bwIn, 10);
%         bwOut = bwlabel(I2);
%         figure; imshow(label2rgb(bwOut))
        
    case 2
        I = im.*uint16(bwIn); %Original image with bw 'mask' applied.

        %sobel filter to show edges in image. i.e. where gradient is maximal
        hy = fspecial('sobel'); %creating sobel filter
        hx = hy'; %sobel filter emphasizes edges
        Iy = imfilter(double(I), hy, 'replicate');%applying sobel filter
        Ix = imfilter(double(I), hx, 'replicate');
        gradmag = sqrt(Ix.^2 + Iy.^2);
        % figure; imshow(gradmag,[]), title('Gradient magnitude (gradmag)')

        %Example testing watershed of gradmag. Oversegments by a lot.
        L = watershed(gradmag);
        Lrgb = label2rgb(L);
        % figure; imshow(Lrgb), title('Watershed of gradmag (Lrgb)')

        %------------Creating marker elements for each cell----------------
        %The disk size determines the smallest size that a 'cell' can be.
        %Anything smaller than the radius is effectively ignored.
        se = strel('disk', 10);
        Io = imopen(I, se);
        % figure; imshow(label2rgb(Io)), title('imopen(im,se),(Io); se:structural element from strel')

        Ie = imerode(I, se); %Erosion of marker elements
        % figure; imshow(label2rgb(Ie)), title('imerode(im,se),(Ie)')
       
        Iobr = imreconstruct(Ie, I); %Reconstruction of marker elements
        % figure; imshow(label2rgb(Iobr)), title('imreconstruct(Ie,im),(Iobr)')

        Ioc = imclose(Io, se);
        % figure; imshow(label2rgb(Ioc)), title('imclose(Io,se),(Ioc)')

        Iobrd = imdilate(Iobr, se);
        % figure; imshow(label2rgb(Iobrd)), title('imdilate(Iobr,se),(Iobrd)')
        Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
        Iobrcbr = imcomplement(Iobrcbr);
        % figure; imshow(label2rgb(Iobrcbr)), title('imreconstruct & stuff (Iobrcbr)')

        fgm = imregionalmax(Iobrcbr); %Regional maximas as a BW image
        % figure; imshow(fgm), title('imregionalmax(Iobrcbr),(fgm)')

        %Showing regional maximas and how they are being cleaned up.
        I2 = I;
        I2(fgm) = 255;
        % figure; imshow(label2rgb(I2)), title('Regional maxima superimposed on original image (I2)')
        %Edge cleanup of regional maximas
        se2 = strel(ones(5,5));
        % se2 = strel('disk',5);
        fgm2 = imclose(fgm, se2);
            I2 = I; I2(fgm2) = 255; 
        %     figure; imshow(label2rgb(I2)), title('imclose(fgm,se2),(fgm2)')
        fgm3 = imerode(fgm2, se2);
            I2 = I; I2(fgm3) = 255; 
        %     figure; imshow(label2rgb(I2)), title('imerode(fgm2,se2),(fgm3)')
        fgm4 = bwareaopen(fgm3, 50); %Removes small connected objects.
        I3 = I;
        I3(fgm4) = 255;
        % figure; imshow(label2rgb(I3)), title('Modified regional maxima superimposed on original image (fgm4)')

        D = -bwdist(~I); %Turned the maximas into 'minimas'
        extmin = imextendedmin(D,2);
        mask = merger(extmin,fgm4,I); %Merged the two methods for marking maximas.
        D2 = imimposemin(D,mask);%removes all minima except for the marked maximas

        Ld = watershed(D2); %Shows watershed lines
        % figure; imshow(label2rgb(Ld));
        %Shows comparison of watershed lines to original image.
        % figure; imshowpair(label2rgb(I),Ld,'diff');

        bwIn = merger(bwIn,mask,I);
        bwIn(Ld == 0) = 0; %Labels watershed lines as background.
        bwOut = bwIn;
        
end

end

