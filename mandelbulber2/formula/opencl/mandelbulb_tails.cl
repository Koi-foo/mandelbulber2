/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2022 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Mandelbulb fractal.
 * @reference http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_mandelbulb_sin_cos.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbTailsIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL th = z.z / aux->r;
	if (!fractal->transformCommon.functionEnabledBFalse)
	{
		if (!fractal->transformCommon.functionEnabledAFalse)
			th = asin(th);
		else
			th = acos(th);
	}
	else
	{
		th = acos(th) * (1.0f - fractal->transformCommon.scale1)
				 + asin(th) * fractal->transformCommon.scale1;
	}
	th = (th + fractal->bulb.betaAngleOffset) * fractal->bulb.power;
	REAL ph = (atan2(z.y, z.x) + fractal->bulb.alphaAngleOffset) * fractal->bulb.power;
	REAL rp = native_powr(aux->r, fractal->bulb.power - 1.0f);
	aux->DE = rp * aux->DE * fractal->bulb.power + 1.0f;
	rp *= aux->r;
	REAL cth = native_cos(th);
	z.x = cth * native_cos(ph) * rp;
	z.y = cth * native_sin(ph) * rp;
	z.z = native_sin(th) * rp;
	z += fractal->transformCommon.offsetA000;

	z.z *= fractal->transformCommon.scaleA1;

	// calculate 'Tails' part Z=(Z+1/Z)/2+C
	// calculate 1/Z
	// radius squared

	// 1/z = conj(z)/r^2
	REAL4 t = z;
	aux->r = 1.0 / dot(t, t);
	t.x = -t.x;
	//t.y = t.y;
	t.z = -t.z;

	REAL4 g = fractal->transformCommon.scale3D111;
	t *= g * aux->r;
	aux->DE += native_recip(aux->DE);
	// puting z, 1/z and C together.
	z = (z + t) * fractal->transformCommon.scaleB1;
	aux->DE *= fractal->transformCommon.scaleB1;

	if (fractal->analyticDE.enabledFalse)
	{
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	}

	if (fractal->transformCommon.functionEnabledCFalse)
	{
		aux->DE0 = length(z);
		if (aux->DE0 > 1.0f)
			aux->DE0 = 0.5f * log(aux->DE0) * aux->DE0 / aux->DE;
		else
			aux->DE0 = 0.01f; // 0.0f artifacts in openCL

		if (aux->i >= fractal->transformCommon.startIterationsO
				&& aux->i < fractal->transformCommon.stopIterationsO)
			aux->dist = min(aux->dist, aux->DE0);
		else
			aux->dist = aux->DE0;
	}
	return z;
}
