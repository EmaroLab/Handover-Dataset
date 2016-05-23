# A multi-sensor public dataset of human-human handover

This folder contains the data composing the dataset and some useful matlab functions.

## How to start

If you want to work with the kinematic data, the first function that you have to use is the loader function that allows you to load some of all the dataset data in
the matlab workspace, for further information about this and the other functions use the matlab help command.

Otherwise if you want to work with the questionnaire you have to use the Qloader function.

## Folder Description   

- **sensor_data**: contains the main part of the dataset, it is organized in subfolders that group the experiments data
	      of one or a couple of volunteers. For every experiment there is an excel file containing tagged data.

- **video**: contains the video recorded while performing the experiments. The structure is the same as for the excel_files folder.

- **lib**: contains some matlab functions used by the main ones.

- **html**: containts reference page for the matlab functions in the html format

- **questionnaires**: contains questionnaire answers plus volunteers data and annotation on the experiment execution (there was some technical problem for this reason there are not the file for volunteer 3,4,7 and 8)

- **inertiaplotter.m**: matlab function that plots inertial data

- **kinectplotter.m**: matlab function that plots the kinect skeleton

- **loader.m**: matlab function that loads data contained in excel_files folder

- **mocaplotter.m**: matlab function that plot mocap data

- **play.m**: matlab function that plays the video record of one experiment

- **Qloader.m**: matlab function that loads data contained in questionnaire folder

- **Qplotter.m**: matlab function that plots questionnaire results

## Licensing

This dataset is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, including the implied warranty of MERCHANTABILITY or 
FITNESS FOR A PARTICULAR PURPOSE. The authors allow the users of the Data Set to use and modify it for their own research. 
Any commercial application, redistribution, etc... has to be arranged between users and authors individually.

For further license information, please contact the authors.

## Authors contacts

If you want to be informed about dataset updates and new code releases, obtain further information about the provided dataset,
or contribute to its development please write to:

- Alessandro Carfì, dept. DIBRIS Università degli Studi di Genova (Italy) carfi.alessandro@gmail.com
- Francesco Foglino, dept. DIBRIS Università degli Studi di Genova (Italy) foglino1992@yahoo.it
- Barbara Bruno, dept. DIBRIS Università degli Studi di Genova (Italy) barbara.bruno@unige.it
- Fulvio Mastrogiovanni, dept. DIBRIS Università degli Studi di Genova (Italy) fulvio.mastrogiovanni@unige.it
