cdef extern from "metis.h":
    # int should be 32 bit if not changed in source #define IDXTYPEWIDTH 32
    # in metis.h
    # float should be 32 bit if not changed in source #define REALTYPEWIDTH 32
    # in metis.h but we changed to double
    void METIS_SetDefaultOptions(int *options)

    int METIS_PartMeshNodal(int *ne, int *nn, int *eptr, int *eind,
                            int *vwgt, int *vsize, int *nparts, double *tpwgts,
                            int *options, int *objval, int *epart, int *npart)
