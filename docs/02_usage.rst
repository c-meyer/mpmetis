Usage
=====

Currently, mpmetis wraps the function **METIS_PartMeshNodal** from the
`METIS <http://glaros.dtc.umn.edu/gkhome/metis/metis/overview>`_-library.
To call the function run::

    import mpmetis
    mpmetis.part_mesh_nodal(ne, nn, eptr, eind, vwgt, vsize, nparts, tpwgts,
                        options, objval, epart, npart)

The meaning of the arguments can be found in the :py:func:`mpmetis.part_mesh_nodal` reference.

A example is given here::

    import numpy as np
    from mpmetis import part_mesh_nodal, create_default_options, MetisOption, MetisStatus
    options = create_default_options()
    options[MetisOption.DBGLVL] = 1
    connectivity_data = np.array([0, 1, 2, 3, 1, 4, 5, 2], dtype=np.int32)
    connectivity_ptr = np.array([0, 4, 8], dtype=np.int32)
    nparts = 2
    objval = np.zeros(1, dtype=np.int32)
    epart = np.zeros(2, dtype=np.int32)
    npart = np.zeros(6, dtype=np.int32)
    status = part_mesh_nodal(2, 6, connectivity_ptr, connectivity_data, None, None, nparts, None, options, objval, epart, npart)
    if status == MetisStatus.OK:
        print(epart)
        print(npart)
