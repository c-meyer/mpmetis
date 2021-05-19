from mod_part_mesh_nodal cimport METIS_PartMeshNodal as c_METIS_PartMeshNodal
from mod_part_mesh_nodal cimport METIS_SetDefaultOptions as \
    c_METIS_SetDefaultOptions


def set_default_options(int[:] options):
    """
    set_default_options(options)

    Sets default options for the part_mesh_nodal algorithm into the options array

    Parameters
    ----------
    options : array_like
        Array of dtype int32 and length metis_noptions

    Returns
    -------

    """
    c_METIS_SetDefaultOptions(&options[0])


def part_mesh_nodal(int ne, int nn, int[:] eptr, int[:] eind,
                    int[:] vwgt, int[:] vsize, int nparts, double[:] tpwgts,
                    int[:] options, int objval, int[:] epart, int[:] npart):
    """
    part_mesh_nodal(ne, nn, eptr, eind, vwgt, vsize, nparts, tpwgts, options, objval, epart, npart)

    Partitions a mesh into npart partitions.

    Parameters
    ----------
    ne : int
        Number of elements in the mesh.
    nn : int
        Number of nodes in the mesh.
    eptr : array_like
        Array of dtype int32 that contains connectivity information such that
        the connectivity of the i-th element (zero based indexing) is in
        eind[eptr[i]:eptr[i+1]].
    eind : array_like
        Array of dtype int32 that contains the connectivity of the nodes in the
        mesh as described in eptr parameter doc above.
    vwgt : array_like
        Array of size nn, dtype int32 to specify weights of the nodes. If nn is None,
        no weights will be used.
    vsize : array_like
        Array of size nn, dtype int32 to specify the size of the nodes that is used
        to compute the total communication volume (c.f. original METIS
        documentation).
    nparts : int
        The number of parts to partition the mesh.
    tpwgts : array_like
        Array of size nparts of dtype double
        to specify desired weight for each partition.
    options : array_like
        Array of options, dtype=int32. You can create an option array with create_default_options
    objval : array_like
        Array of size 1 dtype int32 Variable to store edgecut or total communication volume upon
        successful compeltion
    epart : array_like
        Vector of size ne that stores the partition vector for the elements
        of the mesh. The numbering starts from either 0 or 1, depending on the
        value of options[METIS_OPTION_NUMBERING]
    npart : array_like
        Vector fo size nn that stores the partition vector for the nodes of
        the mesh. The nmbering starts from either 0 or 1, depending on the
        value of options[METIS_OPTION_NUMBERING]

    Returns
    -------
    status : int
        Status of the Algorithm


    Examples
    --------
    >>> import numpy as np
    >>> from mpmetis import part_mesh_nodal, create_default_options, MetisOption, MetisStatus
    >>> options = create_default_options()
    >>> options[MetisOption.DBGLVL] = 1
    >>> connectivity_data = np.array([0, 1, 2, 3, 1, 4, 5, 2], dtype=np.int32)
    >>> connectivity_ptr = np.array([0, 4, 8], dtype=np.int32)
    >>> nparts = 2
    >>> objval = np.zeros(1, dtype=np.int32)
    >>> epart = np.zeros(2, dtype=np.int32)
    >>> npart = np.zeros(6, dtype=np.int32)
    >>> status = part_mesh_nodal(2, 6, connectivity_ptr, connectivity_data, None, None, nparts, None, options, objval, epart, npart)
    >>> if status == MetisStatus.OK:
    >>>     print(epart)
    >>>     print(npart)


    """
    cdef int status
    cdef int* vwgtptr
    cdef int* vsizeptr
    cdef double* tpwgtsptr
    cdef int* optionsptr

    if vwgt is None:
        vwgtptr = NULL
    else:
        vwgtptr = &vwgt[0]
    if vsize is None:
        vsizeptr = NULL
    else:
        vsizeptr = &vsize[0]
    if tpwgts is None:
        tpwgtsptr = NULL
    else:
        tpwgtsptr = &tpwgts[0]
    if options is None:
        optionsptr = NULL
    else:
        optionsptr = &options[0]

    status = c_METIS_PartMeshNodal(&ne, &nn, &eptr[0], &eind[0],
                          vwgtptr, vsizeptr, &nparts, tpwgtsptr,
                          optionsptr, &objval, &epart[0], &npart[0])
    return status
