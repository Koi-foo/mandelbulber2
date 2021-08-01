/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_hexprism.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSHexprismV2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledAFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}
	z += fractal->transformCommon.offset000;

	// polyfold
	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP1)
	{
		z.y = fabs(z.y);
		REAL psi = M_PI_F / fractal->transformCommon.int6;
		psi = fabs(fmod(atan2(z.y, z.x) + psi, 2.0f * psi) - psi);
		REAL len = native_sqrt(z.x * z.x + z.y * z.y);
		z.x = native_cos(psi) * len;
		z.y = native_sin(psi) * len;
	}

	if (fractal->transformCommon.rotationEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR1)
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	REAL lenX = fractal->transformCommon.offset1;

	REAL4 zc = fabs(z);
	REAL4 k = (REAL4){-SQRT_3_4_F, 0.5f, SQRT_1_3_F, 0.0f};
	REAL tp = 2.0f * min(k.x * zc.x + k.y * zc.y, 0.0f);
	zc.x -= tp * k.x;
	zc.y -= tp * k.y;

	REAL dx = zc.x - clamp(zc.x, -k.z * lenX, k.z * lenX);
	REAL dy = zc.y - lenX;

	tp = native_sqrt(dx * dx + dy * dy);
	dx = tp * sign(dy);
	dy = zc.z - fractal->transformCommon.offsetA1;

	k.x = 0.0f;
	k.y = 0.0f;
	if (fractal->transformCommon.functionEnabledCFalse)
	{
		if (fractal->transformCommon.functionEnabledMFalse
				&& aux->i >= fractal->transformCommon.startIterationsM
				&& aux->i < fractal->transformCommon.stopIterationsM)
					zc.z = z.z;

		// abs sqrd
		if (fractal->transformCommon.functionEnabledTFalse
				&& aux->i >= fractal->transformCommon.startIterationsT
				&& aux->i < fractal->transformCommon.stopIterationsT)
					zc.z *= zc.z;

		if (aux->i >= fractal->transformCommon.startIterationsJ
				&& aux->i < fractal->transformCommon.stopIterationsJ)
					dx += fractal->transformCommon.scaleA1 * zc.z;

		if (aux->i >= fractal->transformCommon.startIterationsN
				&& aux->i < fractal->transformCommon.stopIterationsN)
					k.x = fractal->transformCommon.offsetR0;

		if (aux->i >= fractal->transformCommon.startIterationsO
				&& aux->i < fractal->transformCommon.stopIterationsO)
					k.y = fractal->transformCommon.offsetF0;
	}

	if (fractal->transformCommon.functionEnabledDFalse)
		dx = fabs(dx) - fractal->transformCommon.offset0;

	REAL maxdx = max(dx, k.x);
	REAL maxdy = max(dy, k.y);

	tp = native_sqrt(maxdx * maxdx + maxdy * maxdy);
	aux->DE0 = min(max(dx, dy), 0.0f) + tp;
	aux->dist = min(aux->dist, aux->DE0 / (aux->DE + 1.0f));

	if (fractal->transformCommon.functionEnabledZcFalse
			&& aux->i >= fractal->transformCommon.startIterationsZc
			&& aux->i < fractal->transformCommon.stopIterationsZc)
				z = zc;

	return z;
}
