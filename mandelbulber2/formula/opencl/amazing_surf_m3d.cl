/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * amazing surf from Mandelbulber3D. Formula proposed by Kali, with features added by DarkBeam
 *
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_amazing_surf_m3d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 AmazingSurfM3dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledSwFalse
			&& aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations1)
	{
		if (fractal->transformCommon.functionEnabledxFalse) z.x = -z.x;
		if (fractal->transformCommon.functionEnabledyFalse) z.y = -z.y;
		if (fractal->transformCommon.functionEnabledzFalse) z.z = -z.z;
	}

	// update aux->actualScale
	aux->actualScale = fractal->transformCommon.scale015
										 + fractal->mandelboxVary4D.scaleVary * (fabs(aux->actualScale) - 1.0f);
	REAL4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	REAL4 zCol = z;
	// no z fold

	REAL rr;
	if (!fractal->transformCommon.functionEnabledFalse)
		rr = dot(z, z);
	else
		rr = z.x * z.x + z.y * z.y;

	REAL m = aux->actualScale;
	REAL MinR = fractal->mandelbox.mR2;
	if (rr < MinR)
		m = m / MinR;
	else if (rr < 1.0f)
		m = m / rr;

	z *= m;
	aux->DE = aux->DE * fabs(m) + fractal->analyticDE.offset1;

	if (fractal->transformCommon.addCpixelEnabled)
		z += aux->const_c * fractal->transformCommon.constantMultiplier111;

	z += fractal->transformCommon.offsetA000;

	REAL temp = 0.0f;
	if (fractal->transformCommon.angleDegC != 0.0f)
	{
		temp = z.x;
		z.x = z.x * fractal->transformCommon.cosC - z.y * fractal->transformCommon.sinC;
		z.y = temp * fractal->transformCommon.sinC + z.y * fractal->transformCommon.cosC;
	}

	if (fractal->transformCommon.angleDegB != 0.0f)
	{
		temp = z.z;
		z.z = z.z * fractal->transformCommon.cosB - z.x * fractal->transformCommon.sinB;
		z.x = temp * fractal->transformCommon.sinB + z.x * fractal->transformCommon.cosB;
	}

	if (fractal->transformCommon.angleDegA != 0.0f)
	{
		temp = z.y;
		z.y = z.y * fractal->transformCommon.cosA - z.z * fractal->transformCommon.sinA;
		z.z = temp * fractal->transformCommon.sinA + z.z * fractal->transformCommon.cosA;
	}

	if (fractal->foldColor.auxColorEnabledFalse)
	{
		REAL colorAdd = 0.0f;
		if (aux->i >= fractal->foldColor.startIterationsA
				&& aux->i < fractal->foldColor.stopIterationsA)
		{
			zCol = fabs(zCol - oldZ);
			if (zCol.x > 0.0f) colorAdd += fractal->foldColor.difs0000.x * zCol.x;
			if (zCol.y > 0.0f) colorAdd += fractal->foldColor.difs0000.y * zCol.y;
			colorAdd += fractal->foldColor.difs0000.z * fabs(z.z);
			colorAdd += fractal->foldColor.difs0000.w * m;
		}
		aux->color += colorAdd;
	}
	return z;
}