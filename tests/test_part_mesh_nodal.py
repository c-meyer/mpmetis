import numpy as np
from numpy.testing import assert_array_equal

from mpmetis import part_mesh_nodal, create_default_options, MetisOption, MetisStatus


def test_part_mesh_nodal():
    metis_array = create_default_options()
    metis_array[MetisOption.DBGLVL] = 1
    connectivity_data = np.array([0, 1, 2, 3, 1, 4, 5, 2], dtype=np.intc)
    connectivity_ptr = np.array([0, 4, 8], dtype=np.intc)
    nparts = 2
    objval = np.zeros(1, dtype=np.intc)
    epart = np.zeros(2, dtype=np.intc)
    npart = np.zeros(6, dtype=np.intc)
    status = part_mesh_nodal(2, 6, connectivity_ptr, connectivity_data,
                    None, None, nparts, None, metis_array, objval, epart, npart)
    print('Status {}'.format(status))
    print('epart {}'.format(epart))
    print('npart {}'.format(npart))
    print('objval {}'.format(objval))
    assert status == MetisStatus.OK
    epart_desired = np.array([0, 1], dtype=np.intc)
    npart_desired = np.array([0, 0, 1, 0, 1, 1], dtype=np.intc)
    assert_array_equal(epart, epart_desired)
    assert_array_equal(npart, npart_desired)
