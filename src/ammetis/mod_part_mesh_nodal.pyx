from enum import IntEnum

from mod_part_mesh_nodal cimport METIS_PartMeshNodal as c_METIS_PartMeshNodal
from mod_part_mesh_nodal cimport METIS_SetDefaultOptions as \
    c_METIS_SetDefaultOptions


def set_default_options(int[:] options):
    c_METIS_SetDefaultOptions(&options[0])


def part_mesh_nodal(int ne, int nn, int[:] eptr, int[:] eind,
                    int[:] vwgt, int[:] vsize, int nparts, double[:] tpwgts,
                    int[:] options, int objval, int[:] epart, int[:] npart):
    """Partitions a mesh

    Parameters
    ----------
    ne : int
        Number of elements in the mesh.
    nn : int
        Number of nodes in the mesh.
    eptr : array_like
        Array of dtype int that contains connectivity information such that
        the connectivity of the i-th element (zero based indexing) is in
        eind[eptr[i]:eptr[i+1]].
    eind : array_like
        Array of dtype int that contains the connectivity of the nodes in the
        mesh as described in eptr parameter doc above.
    vwgt : array_like
        Array of size nn to specify weights of the nodes. If nn is None,
        no weights will be used.
    vsize : array_like
        Array of size nn to specify the size of the nodes that is used
        to compute the total communication volume (c.f. original METIS
        documentation).
    nparts : int
        The number of parts to partition the mesh.
    tpwgts : array_like
        Array of size nparts of dtype double
        to specify desired weight for each partition.
    options :
        Array of options.
    objval :
        Variable to store edgecut or total communication volume upon
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
        Status
    """
    cdef int status
#    c_METIS_PartMeshNodal(&ne[0], &nn[0], &eptr[0], &eind[0],
#                          &vwgt[0], &vsize[0], &nparts[0], &tpwgts[0],
#                          &options[0], &objval[0], &epart[0], &npart[0])
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
