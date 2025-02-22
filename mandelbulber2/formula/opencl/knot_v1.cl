/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * knotv1
 * Based on DarkBeam formula from this thread:
 * http://www.fractalforums.com/new-theories-and-research/not-fractal-but-funny-trefoil-knot-routine

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_knot_v1.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 KnotV1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL polyfoldOrder = fractal->transformCommon.int2;

	if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
	if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
	if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	z += fractal->transformCommon.offset000;

	REAL4 zc = z;
	zc.z *= fractal->transformCommon.scaleA1;
	REAL mobius =
		(1.0f * fractal->transformCommon.intA1 + fractal->transformCommon.intB1 / polyfoldOrder)
		* atan2(zc.y, zc.x);

	zc.x = native_sqrt(zc.x * zc.x + zc.y * zc.y) - fractal->transformCommon.offsetA2;
	REAL temp = zc.x;
	REAL c = native_cos(mobius);
	REAL s = native_sin(mobius);
	zc.x = c * zc.x + s * zc.z;
	zc.z = -s * temp + c * zc.z;

	REAL m = 1.0f * polyfoldOrder * M_PI_2x_INV_F;
	REAL angle1 = floor(0.5f + m * (M_PI_2 - atan2(zc.x, zc.z))) / m;

	temp = zc.x;
	c = native_cos(angle1);
	s = native_sin(angle1);
	zc.x = c * zc.x + s * zc.z;
	zc.z = -s * temp + c * zc.z;

	zc.x -= fractal->transformCommon.offset05;

	REAL len = native_sqrt(zc.x * zc.x + zc.z * zc.z);

	if (fractal->transformCommon.functionEnabledCFalse) len = min(len, max(fabs(zc.x), fabs(zc.z)));

	aux->DE0 = len - fractal->transformCommon.offset01;

	if (fractal->transformCommon.functionEnabledJFalse)
	{
		if (fractal->transformCommon.functionEnabledDFalse) aux->DE0 = min(aux->dist, aux->DE0);
		if (fractal->transformCommon.functionEnabledKFalse) aux->DE0 /= aux->DE;
		if (fractal->transformCommon.functionEnabledEFalse) z = zc;
	}
	REAL colorDist = aux->dist;
	aux->dist = aux->DE0;

	// aux->color
	if (fractal->foldColor.auxColorEnabled)
	{
		REAL colorAdd = 0.0f;
		REAL ang = (M_PI_F - 2.0f * fabs(atan(zc.x / zc.z))) * 2.0f / M_PI_F;

		if (fmod(ang, 2.0f) < 1.0f) colorAdd += fractal->foldColor.difs0000.x;
		colorAdd += fractal->foldColor.difs0000.y * fabs(ang);
		colorAdd += fractal->foldColor.difs0000.z * fabs(ang * zc.x);
		colorAdd += fractal->foldColor.difs0000.w * angle1;

		colorAdd += fractal->foldColor.difs1;
		if (fractal->foldColor.auxColorEnabledA)
		{
			if (colorDist != aux->dist) aux->color += colorAdd;
		}
		else
			aux->color += colorAdd;
	}

	// DE tweak
	if (fractal->analyticDE.enabledFalse) aux->dist = aux->dist * fractal->analyticDE.scale1;
	return z;
}
