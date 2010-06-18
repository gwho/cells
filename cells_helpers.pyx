cimport numpy


def get_small_view_fast(self, int x, int y):
    cdef numpy.ndarray[object, ndim=2] values = self.values
    cdef int width = self.width
    cdef int height = self.height
    cdef int dr
    cdef int dc
    cdef int adj_x
    cdef int adj_y


    assert self.values.dtype == object
    ret = []
    get = self.get

    for dr in xrange(-1,2):
        for dc in xrange(-1,2):
            if not dr and not dc:
                continue
            adj_x = x + dr
            if not 0 <= adj_x < width:
                continue
            adj_y = y + dc
            if not 0 <= adj_y < height:
                continue
            a = values[adj_x, adj_y]
            if a is not None:
                ret.append(a.get_view())
    return ret

def get_val(self, int x, int y):
    cdef numpy.ndarray values = self.values
    cdef int width = self.width
    cdef int height = self.height

    # is it inbounds?
    if (x < width and x >= 0) and (y < height and y >= 0):
        return values[x, y]
    else:
        return None

cdef sign(int n):
    if n < 0:
        return -1
    if n == 0:
        return 0
    if n > 0:
        return 1

def get_next_move_fast(int old_x, int old_y, int x, int y):
    cdef int dx
    cdef int dy

    dx = sign(x - old_x)
    dy = sign(y - old_y)

    return (old_x + dx, old_y + dy)
