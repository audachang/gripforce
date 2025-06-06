# Import the Suit package
import SUITPy.flatmap as flatmap
import matplotlib.pyplot as plt
import os

gpdir = '../out/afni/subject_results/group_results'
anamode = 'test.CSPLINzero.3dMEMA_N=254.R-L.results'
fn = os.path.join(gpdir, anamode, 'R-L_CSPLIN+tlrc_t.nii')



funcdata = flatmap.vol_to_surf(fn)
print('Output is a np.array of size:',funcdata.shape)

plt.figure()
flatmap.plot(data=funcdata, cmap='jet', 
	threshold=[0, 0.1], 
	new_figure=True, colorbar=True)
plt.show()
