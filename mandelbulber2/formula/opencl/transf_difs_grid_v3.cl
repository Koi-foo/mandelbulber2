/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * transfDIFSGridV2Iteration  fragmentarium code, mdifs by knighty (jan 2012)
 * and Buddhi

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_grid_v2.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSGridV3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux.const_c;
	REAL4 zc = c;
	if (fractal->transformCommon.functionEnabledyFalse)
		zc = z;
	zc.z += fractal->transformCommon.offsetR0;

	if (fractal->transformCommon.functionEnabledTFalse)
	{
		zc.x -= round(zc.x / fractal->transformCommon.offset2) * fractal->transformCommon.offset2;
		zc.y -= round(zc.y / fractal->transformCommon.offsetA2) * fractal->transformCommon.offsetA2;
	}

	if (fractal->transformCommon.functionEnabledRFalse)
	{
		for (int m = 0; m < fractal->transformCommon.int8Y; m++)
		{
			double t;
			zc.x = fabs(zc.x);
			zc.y = fabs(zc.y);
			if (fractal->transformCommon.functionEnabledSwFalse
				&& m >= fractal->transformCommon.startIterationsN
				&& m < fractal->transformCommon.stopIterationsN)
			{
				t = zc.x;
				zc.x = zc.y;
				zc.y = t;
			}
			t = zc.x;
			zc.x = zc.x + zc.y - fractal->transformCommon.offset0;
			zc.y = t - zc.y - fractal->transformCommon.offsetC0;
			if (fractal->transformCommon.functionEnabledCxFalse
					&& m >= fractal->transformCommon.startIterationsO
					&& m < fractal->transformCommon.stopIterationsO)
						zc.x = -fabs(zc.x);
			if (fractal->transformCommon.functionEnabledCx
					&& m >= fractal->transformCommon.startIterationsP
					&& m < fractal->transformCommon.stopIterationsP)
						zc.y = -fabs(zc.y);

			double foldX = fractal->transformCommon.offset1;
			double foldY = fractal->transformCommon.offsetA1;

			t = zc.x;
			zc.x = (zc.x + zc.y) * 0.5;
			zc.y = (t - zc.y) * 0.5;
			if (fractal->transformCommon.functionEnabledCy
					&& m >= fractal->transformCommon.startIterationsR
					&& m < fractal->transformCommon.stopIterationsR)
						zc.x = foldX - fabs(zc.x + foldX);
			if (fractal->transformCommon.functionEnabledCyFalse
					&& m >= fractal->transformCommon.startIterationsRV
					&& m < fractal->transformCommon.stopIterationsRV)
						zc.y = foldY - fabs(zc.y + foldY);
		}
	}

	if (fractal->transformCommon.functionEnabledFalse)
	{
		for (int n = 0; n < fractal->transformCommon.int8X; n++)
		{
			REAL4 limit = fractal->transformCommon.offset111;
	
			if (fractal->transformCommon.functionEnabledAx
					&& n >= fractal->transformCommon.startIterationsA
					&& n < fractal->transformCommon.stopIterationsA)
				zc.x = fabs(zc.x + limit.x) - fabs(zc.x - limit.x) - zc.x;
	
			if (fractal->transformCommon.functionEnabledAy
					&& n >= fractal->transformCommon.startIterationsB
					&& n < fractal->transformCommon.stopIterationsB)
				zc.y = fabs(zc.y + limit.y) - fabs(zc.y - limit.y) - zc.y;
	
			if (fractal->transformCommon.functionEnabledAzFalse
					&& n >= fractal->transformCommon.startIterationsC
					&& n < fractal->transformCommon.stopIterationsC)
				zc.z = fabs(zc.z + limit.z) - fabs(zc.z - limit.z) - zc.z;
		}
	}

	if (fractal->transformCommon.functionEnabledIFalse)
	{
		REAL sinan = native_sin(fractal->transformCommon.offsetA000.z);
		REAL cosan = native_cos(fractal->transformCommon.offsetA000.z);
		REAL temp = zc.x;
		zc.x = zc.x * cosan - zc.y * sinan;
		zc.y = temp * sinan + zc.y * cosan;
	}

	// abs offset x
	if (fractal->transformCommon.functionEnabledMFalse)
	{
		zc.x += fractal->transformCommon.offsetA000.x;
		zc.x = fabs(z.x) - fractal->transformCommon.offsetA000.x;
	}
	// abs offset y
	if (fractal->transformCommon.functionEnabledNFalse)
	{
		zc.y += fractal->transformCommon.offsetA000.y;
		zc.y = fabs(z.y) - fractal->transformCommon.offsetA000.y;
	}

	if (fractal->transformCommon.functionEnabledAFalse)
		zc.x = zc.x + sign(zc.y) * 0.5f * fractal->transformCommon.offsetD0;

	if (fractal->transformCommon.functionEnabledBFalse)
		zc.y = zc.y + sign(zc.x) * 0.5f * fractal->transformCommon.offsetE0;

	zc.x *= fractal->transformCommon.scale3D111.x;
	zc.y *= fractal->transformCommon.scale3D111.y;
	// zc.z *= fractal->transformCommon.scale3D111.z;

	if (fractal->transformCommon.functionEnabledFFalse)
		zc.x = zc.x + sin(zc.y) * fractal->transformCommon.scale3D000.x;
	if (fractal->transformCommon.functionEnabledGFalse)
		zc.y = zc.y + sin(zc.x) * fractal->transformCommon.scale3D000.y;

	// square
	if (fractal->transformCommon.functionEnabledBx) zc.x = max(fabs(zc.x), fabs(zc.y));
	// circle
	if (fractal->transformCommon.functionEnabledOFalse) zc.x = sqrt((zc.x * zc.x) + (zc.y * zc.y));

	if (fractal->transformCommon.functionEnabledKFalse)
		zc.x = zc.x + sin(zc.y) * fractal->transformCommon.scale3D000.z;


	// DE
	REAL tD = 1000.0;
	REAL bb = zc.x - round(zc.x);
	if (fractal->transformCommon.functionEnabledXFalse)
		bb = fabs(bb) - fractal->transformCommon.offsetA0;
	zc.z /= fractal->transformCommon.scale3D111.z;

	if (!fractal->transformCommon.functionEnabledDFalse)
	{
		tD = sqrt(bb * bb + zc.z * zc.z) - fractal->transformCommon.offsetp05;
		if (fractal->transformCommon.functionEnabledYFalse)
			tD = max(
				fabs(tD) - fractal->transformCommon.offsetA0,
					fabs(zc.z) - fractal->transformCommon.offsetB0);
	}
	else
	{
		tD = max(
			fabs(bb) - fractal->transformCommon.offsetp05, fabs(zc.z) - fractal->transformCommon.offsetB0);
	}

	// plane
	REAL plD = 1000.0f;
	if (fractal->transformCommon.functionEnabledPFalse)
		plD = fabs(c.z - fractal->transformCommon.offsetF0);

	REAL d = min(plD, tD / (aux->DE + fractal->analyticDE.offset0));

	// aux->color
	if (fractal->foldColor.auxColorEnabled)
	{
		if (d == plD) aux->color = fractal->foldColor.difs0000.x;
		else
		{
			REAL addColor = fractal->foldColor.difs0000.y
				+ fractal->foldColor.difs0000.z * zc.z + fractal->foldColor.difs0000.w * zc.z * zc.z;
			if (!fractal->transformCommon.functionEnabledJFalse)
				aux->color = addColor;
			else
				aux->color += addColor;
		}
	}

	// clip
	if (fractal->transformCommon.functionEnabledCFalse)
	{
		REAL e = fractal->transformCommon.offset4;
		if (!fractal->transformCommon.functionEnabledSFalse)
		{
			REAL4 f = fabs(c);
			f -= (REAL4)(e, e, e, 0.0);
			e = max(f.x, max(f.y, f.z));
		}
		else
		{
			e = clamp(native_sqrt(c.x * c.x + c.y * c.y) - e, 0.0f, 100.0); // circle
		}
		d = max(d, e);
	}

	if (fractal->transformCommon.functionEnabledzFalse) z = zc;
	if (!fractal->analyticDE.enabledFalse)
		aux->dist = d;
	else
		aux->dist = min(aux->dist, d);
	return z;
}
