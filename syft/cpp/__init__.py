from torch.utils.cpp_extension import load
lltm_cpp = load(name="lltm_cpp", sources=["/Users/atrask/PycharmProjects/PySyft/syft/cpp/lltm.cpp"], verbose=True)