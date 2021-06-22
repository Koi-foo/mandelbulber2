/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Formula invented by Benesi
 * @reference http://www.fractalforums.com/index.php?action=profile;u=1170

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_benesi.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 BenesiIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->DE *= 2.0f * aux->r;
	REAL4 zz = z * z;
	REAL r1 = zz.y + zz.z;
	REAL4 t = z;
	if (aux->const_c.x < 0.0f || z.x < sqrt(r1))
		t.x = zz.x - r1 + fractal->transformCommon.offset000.x;
	else
		t.x = -zz.x + r1 - fractal->transformCommon.offset000.x;
	r1 = -pow(r1, -0.5f) * 2.0f * fabs(z.x);
	t.y = r1 * (zz.y - zz.z) + fractal->transformCommon.offset000.y;
	t.z = r1 * 2.0f * z.y * z.z + fractal->transformCommon.offset000.z + 1e-016;
	z = t;

	return z;
}
