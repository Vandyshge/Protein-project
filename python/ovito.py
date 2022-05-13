from ovito.io import import_file
#from ovito.modifiers import md
import ovito.vis as vis
import numpy as np
import sys

T = sys.argv[1]
file = f'/home/common/studtscm06/peptide/data/dump/dump.peptide_{T}'
pipeline = import_file(file)
pipeline.add_to_scene()

data = pipeline.compute()

wall_x = data.cell[0][0]
wall_y = data.cell[1][1]
wall_z = data.cell[2][2]

vp = vis.Viewport()
vp.type = vis.Viewport.Type.Perspective

fi = 60 
center = np.array([wall_x/2, wall_y/2, wall_z/2])
radius = (wall_x/2+wall_y/2*3**0.5)*1.1
phi = np.pi * fi / 180
direction = np.array([np.cos(phi), np.sin(phi), 0])

vp.camera_pos = tuple(center+direction*radius)
vp.camera_dir = tuple(-direction)
vp.fov = np.radians(60.0)
vp.render_image(size=(400,400), filename=f'/home/common/studtscm06/peptide/data/figure/fig_{T}.png',
                renderer=vis.TachyonRenderer())