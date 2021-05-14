from enum import IntEnum

from ammetis.mod_part_mesh_nodal import part_mesh_nodal, \
    create_part_mesh_nodal_options

metis_noptions = 40

class MetisOption(IntEnum):
    PTYPE = 0
    OBJTYPE = 1
    CTYPE = 2
    IPTYPE = 3
    RTYPE = 4
    DBGLVL = 5
    NITER = 6
    NCUTS = 7
    SEED = 8
    NO2HOP = 9
    MINCONN = 10
    CONTIG = 11
    COMPRESS = 12
    CCORDER = 13
    PFACTOR = 14
    NSEPS = 15
    UFACTOR = 16
    NUMBERING = 17