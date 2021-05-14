cdef extern from "metis.h":
    # cpdef enum rstatus_et:
    #     METIS_OK              = 1
    #     METIS_ERROR_INPUT     = -2
    #     METIS_ERROR_MEMORY    = -3
    #     METIS_ERROR           = -4
    #
    # cpdef enum moptions_et:
    #     METIS_OPTION_PTYPE
    #     METIS_OPTION_OBJTYPE
    #     METIS_OPTION_CTYPE
    #     METIS_OPTION_IPTYPE
    #     METIS_OPTION_RTYPE
    #     METIS_OPTION_DBGLVL
    #     METIS_OPTION_NITER
    #     METIS_OPTION_NCUTS
    #     METIS_OPTION_SEED
    #     METIS_OPTION_NO2HOP
    #     METIS_OPTION_MINCONN
    #     METIS_OPTION_CONTIG
    #     METIS_OPTION_COMPRESS
    #     METIS_OPTION_CCORDER
    #     METIS_OPTION_PFACTOR
    #     METIS_OPTION_NSEPS
    #     METS_OPTION_UFACTOR
    #     METIS_OPTION_NUMBERING

    # int should be 32 bit if not changed in source #define IDXTYPEWIDTH 32
    # in metis.h
    # float should be 32 bit if not changed in source #define REALTYPEWIDTH 32
    # in metis.h but we changed to double
    void METIS_SetDefaultOptions(int *options)

    int METIS_PartMeshNodal(int *ne, int *nn, int *eptr, int *eind,
                            int *vwgt, int *vsize, int *nparts, double *tpwgts,
                            int *options, int *objval, int *epart, int *npart)
