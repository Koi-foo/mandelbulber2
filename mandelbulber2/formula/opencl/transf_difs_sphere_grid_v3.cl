/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * TransfDIFSSphereGridV3

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_sphere_grid_v3.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSSphereGridV3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// tranform z
	// z = fabs(z);
	if (fractal->transformCommon.functionEnabledCx
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		z.y = fabs(z.y);
		REAL psi = M_PI_F / fractal->transformCommon.int32;
		psi = fabs(fmod(atan2(z.y, z.x) + psi, 2.0f * psi) - psi);
		REAL len = native_sqrt(z.x * z.x + z.y * z.y);
		z.x = native_cos(psi) * len;
		z.y = native_sin(psi) * len;
	}

	if (fractal->transformCommon.functionEnabledCyFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		z.z = fabs(z.z);
		REAL psi = M_PI_F / fractal->transformCommon.int8Y;
		psi = fabs(fmod(atan2(z.z, z.y) + psi, 2.0f * psi) - psi);
		REAL len = native_sqrt(z.y * z.y + z.z * z.z);
		z.y = native_cos(psi) * len;
		z.z = native_sin(psi) * len;
	}

	if (fractal->transformCommon.functionEnabledCzFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		z.x = fabs(z.x);
		REAL psi = M_PI_F / fractal->transformCommon.int8Z;
		psi = fabs(fmod(atan2(z.x, z.z) + psi, 2.0f * psi) - psi);
		REAL len = native_sqrt(z.z * z.z + z.x * z.x);
		z.z = native_cos(psi) * len;
		z.x = native_sin(psi) * len;
	}

	z += fractal->transformCommon.offset000;
	z *= fractal->transformCommon.scale1;
	aux->DE *= fabs(fractal->transformCommon.scale1);

	REAL temp;
	temp = z.y;
	z.y = z.z;
	z.z = temp;
	temp = z.x;
	z.x = z.y;
	z.y = temp;

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	// sphere grid
	REAL4 zc = z;

	if (fractal->transformCommon.functionEnabledKFalse)
	{
		// polyfold
		zc.x = fabs(zc.x);
		REAL psi = M_PI_F / fractal->transformCommon.int1;
		psi = fabs(fmod(atan2(zc.x, zc.y) + psi, 2.0f * psi) - psi);
		REAL len = native_sqrt(zc.y * zc.y + zc.x * zc.x);
		zc.y = native_cos(psi) * len;
		zc.x = native_sin(psi) * len;
	}

	if (fractal->transformCommon.rotation2EnabledFalse)
	{
		zc = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix2, zc);
	}

	REAL T1 = native_sqrt(zc.y * zc.y + zc.x * zc.x) - fractal->transformCommon.offsetR1;
	if (!fractal->transformCommon.functionEnabledJFalse)
		T1 = native_sqrt(T1 * T1 + zc.z * zc.z) - fractal->transformCommon.offsetp01;
	else
		T1 = max(fabs(T1), fabs(zc.z)) - fractal->transformCommon.offsetp01;

	REAL T2 = 1000.0f;
	if (fractal->transformCommon.functionEnabledMFalse)
	{
		T2 = native_sqrt(zc.y * zc.y + zc.x * zc.x) - fractal->transformCommon.offsetR1;
		if (!fractal->transformCommon.functionEnabledNFalse)
			T2 = native_sqrt(T2 * T2 + zc.z * zc.z) - fractal->transformCommon.offsetAp01;
		else
			T2 = max(fabs(T2), fabs(zc.z)) - fractal->transformCommon.offsetAp01;
	}

	REAL T3 = 1000.0f;
	if (fractal->transformCommon.functionEnabledOFalse)
	{
		REAL z2 = fractal->transformCommon.offset05;
		REAL z1 = fabs(zc.z) - z2;
		T3 = native_sqrt(zc.y * zc.y + zc.x * zc.x)
				 - native_sqrt(
					 fractal->transformCommon.offsetR1 * fractal->transformCommon.offsetR1 - z2 * z2);

		if (!fractal->transformCommon.functionEnabledPFalse)
			T3 = native_sqrt(T3 * T3 + z1 * z1) - fractal->transformCommon.offsetBp01;
		else
			T3 = max(fabs(T3), fabs(z1)) - fractal->transformCommon.offsetBp01;
	}

	REAL torD = min(T1, T2);
	torD = min(torD, T3);

	REAL colorDist = aux->dist; // for color

	if (!fractal->analyticDE.enabledFalse)
		aux->dist = min(aux->dist, torD / (aux->DE + fractal->analyticDE.offset1));
	else
		aux->dist = torD / (aux->DE + fractal->analyticDE.offset1);

	if (fractal->foldColor.auxColorEnabledFalse)
	{
		REAL colorAdd = 0.0f;
		if (T1 == torD) colorAdd += fractal->foldColor.difs0000.x;
		if (T2 == torD) colorAdd += fractal->foldColor.difs0000.y;
		if (T3 == torD) colorAdd += fractal->foldColor.difs0000.z;
		if (colorDist != aux->dist) colorAdd += fractal->foldColor.difs0000.w;

		if (!fractal->transformCommon.functionEnabledCFalse)
			aux->color = colorAdd;
		else
			aux->color += colorAdd;
	}

	if (fractal->transformCommon.functionEnabledYFalse) z = zc;
	return z;
}