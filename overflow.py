import random

INT_BITS = 32
MAX_INT = (1 << INT_BITS)
PRECISION_BITS = 30
PRECISION_INT = (1 << PRECISION_BITS)


def to_fixed(f: float):
    return int(f * PRECISION_INT) % MAX_INT


def to_float(i: int):
    return float(i) / PRECISION_INT


def mult(i1: int, i2: int):
    m = int(i1 * i2)
    if m >= MAX_INT:
        print("Warning, overflow", m)
    return (m/PRECISION_INT) % MAX_INT


# f1 = 1
# i1 = to_fixed(f1)
# f1r = to_float(i1)
# e1 = f1r-f1

# print("f1:", f1, "i1:", i1, "f1r:", f1r, "e1", e1)

for i in range(10):
    x = random.random()

    res = x*x
    out = to_float(mult(to_fixed(x), to_fixed(x)))
    print("res:", res, "out:", out)
