
function  []= csv2gpx(csv_path,fromfile,tofile)
% This function in ment to get a CSV file from individuals trajectories and return a
% gpx file for each of the inidvidual 
% Copyright 2016 Bahar Zarin
count = 0;
data=csv2cell(csv_path,fromfile);

uniqueid=unique(data(:,1));

for i = 1:size(uniqueid,1);
    index = find(ismember(data(:,1),uniqueid(i)));
    if size(index)<4
        continue;
    end
    thistrip= data(index,:);
    
    docNode = com.mathworks.xml.XMLUtils.createDocument('gpx');
    toc = docNode.getDocumentElement;
    toc.setAttribute('version','1.1');
    toc.setAttribute('creator','GPS Visualizer http://www.gpsvisualizer.com/');
    toc.setAttribute('xmlns','http://www.topografix.com/GPX/1/1');
    toc.setAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    toc.setAttribute('xsi:schemaLocation','http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd');
    for j = 1:size(thistrip,1);
        product = docNode.createElement('trkpt');
        product.setAttribute('lat',thistrip(j,4));
        product.setAttribute('lon',thistrip(j,5));
        toc.appendChild(product)
        
        product2 = docNode.createElement('time');
        product2.appendChild(docNode.createTextNode(thistrip(j,3)));
        product.appendChild(product2);
        
        product3 = docNode.createElement('name');
        product3.appendChild(docNode.createTextNode(thistrip(j,3)));
        product.appendChild(product3);
    end
    xmlwrite(fullfile(tofile,[uniqueid{i},'.gpx']),docNode);
    type('info.xml');
    count = count+1;
    disp([num2str(count) ' '])
end
end
