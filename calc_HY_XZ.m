function [HY_XZ] = calc_HY_XZ(PYXZ)
    PXZ = repmat(sum(PYXZ,1),[size(PYXZ,1),1,1]);
    HY_XZ = -PYXZ.*(log2(PYXZ) - log2(PXZ));
    HY_XZ(isnan(HY_XZ)) = 0;
    HY_XZ = sum(HY_XZ(:));
end