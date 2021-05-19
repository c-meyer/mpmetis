from enum import IntEnum
import numpy as np

from mpmetis.mod_part_mesh_nodal import part_mesh_nodal, set_default_options


__all__ = ['part_mesh_nodal',
           'set_default_options',
           'create_default_options',
           'MetisOption',
           'MetisStatus',
           ]


metis_noptions = 40


class MetisOption(IntEnum):
    """
    MetisOption

    This enumeration gives information about the meaning of the flags in the Options Array.

    The following flags are available:
    * PTYPE
    * OBJTYPE
    * CTYPE
    * IPTYPE
    * RTYPE
    * DBGLVL
    * NITER
    * NCUTS
    * SEED
    * NO2HOP
    * MINCONN
    * CONTIG
    * COMPRESS
    * CCORDER
    * PFACTOR
    * NSEPS
    * UFACTOR
    * NUMBERING

    """
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


class MetisStatus(IntEnum):
    """
    This enumeration gives information about the returned status of the part_mesh_nodal algorithm

    The enumeration defines the following flags:
    * OK
    * ERROR_INPUT
    * ERROR_MEMORY
    * ERROR

    Examples
    --------
    >>> if status == MetisStatus.OK
    >>>     print('The algorithm was successfull')
    >>> else:
    >>>     print('An error occurred')
    """
    OK = 1
    ERROR_INPUT = -2
    ERROR_MEMORY = -3
    ERROR = -4


def create_default_options():
    """
    create_default_options()

    Returns
    -------
    options : array_like
        Option Array that can be passed to the part_mesh_nodal algorithm
    """
    options = np.zeros(metis_noptions, dtype=np.int32)
    set_default_options(options)
    return options
