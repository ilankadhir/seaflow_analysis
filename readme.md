# Classification of Ocean Microbes

## SeaFlow Environmental Flow Cytometry

_This exercise is a part of UW Data Science Specialization assignment__

A flow cytometer delivers a flow of particles through capilliary. By shining lasers of different wavelengths and measuring the absorption and refraction patterns, you can determine how large the particle is and some information about its color and other properties, allowing you to detect it.

The technology was developed for medical applciations, where the particles were potential pathogens in, say, serum, and the goal was to give a diagnosis. But the technology was adapted for use in environmental science to understand microbial population profiles.

The SeaFlow instrument, developed by the Armbrust Lab at the University of Washington, is unique in that it is deployed on research vessels and takes continuous measurements of population profiles in the open ocean.

The scale of the data can be quite large, and is expected to grow significantly: A two-week cruise from one vessel can generate hundreds of gigabytes per day, and the vision is to deploy one of these instruments on not only research vessels but the commercial shipping fleet as well.

While there are a number of challenging analytics tasks associated with this data, a central task is classification of particles. Based on the optical measurements of the particle, it can be identified as one of several populations.

**Dataset seaflow_21min.csv**
The dataset 'seaflow\_21min.csv' represents a 21 minute sample from the vessel. This sample has been pre-processed to remove the calibration "beads" that are passed through the system for monitoring, as well as some other particle types.

The columns of this dataset are as follows:
> file\_id, time, cell\_id, d1, d2, fsc\_small, fsc\_perp, fsc\_big, pe, chl\_small, chl\_big, pop

* file_id: The data arrives in files, where each file represents a three-minute window; this field represents which file the data came from. The number is ordered by time, but is otherwise not significant.

* time: This is an integer representing the time the particle passed through the instrument. Many particles may arrive at the same time; time is not a key for this relation.

* cell_id: A unique identifier for each cell WITHIN a file. (file_id, cell_id) is a key for this relation.

* d1, d2: Intensity of light at the two main sensors, oriented perpendicularly. These sensors are primarily used to determine whether the particles are properly centered in the stream. Used primarily in preprocesssing; they are unlikely to be useful for classification.

* fsc_small, fsc_perp, fsc_big: Forward scatter small, perpendicular, and big. These values help distingish different sizes of particles.

* pe: A measurement of phycoerythrin fluorescence, which is related to the wavelength associated with an orange color in microorganisms

* chl_small, chl_big: Measurements related to the wavelength of light corresponding to chlorophyll.

* pop: This is the class label assigned by the clustering mechanism used in the production system. It can be considered "ground truth" for the purposes of the assignment, but note that there are particles that cannot be unambiguously classified, so you should not aim for 100% accuracy. The values in this column are crypto, nano, pico, synecho, and ultra
