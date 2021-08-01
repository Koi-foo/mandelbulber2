/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * MengerV3Iteration
 * Based on a fractal proposed by Buddhi, with a DE outlined by Knighty:
 * http://www.fractalforums.com/3d-fractal-generation/revenge-of-the-half-eaten-menger-sponge/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_menger_v3.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MengerV3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// abs z
	if (fractal->transformCommon.functionEnabledAx) z.x = fabs(z.x);
	if (fractal->transformCommon.functionEnabledAy) z.y = fabs(z.y);
	if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	// folds
	if (fractal->transformCommon.functionEnabledFalse)
	{
		// polyfold
		if (fractal->transformCommon.functionEnabledPFalse)
		{
			z.x = fabs(z.x);
			REAL psi = M_PI_F / fractal->transformCommon.int6;
			psi = fabs(fmod(atan2(z.y, z.x) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.x * z.x + z.y * z.y);
			z.x = native_cos(psi) * len;
			z.y = native_sin(psi) * len;
		}
		// abs offsets
		if (fractal->transformCommon.functionEnabledCFalse)
		{
			REAL xOffset = fractal->transformCommon.offsetC0;
			if (z.x < xOffset) z.x = fabs(z.x - xOffset) + xOffset;
		}
		if (fractal->transformCommon.functionEnabledDFalse)
		{
			REAL yOffset = fractal->transformCommon.offsetD0;
			if (z.y < yOffset) z.y = fabs(z.y - yOffset) + yOffset;
		}
	}

	// scale
	z *= fractal->transformCommon.scale1;
	aux->DE *= fabs(fractal->transformCommon.scale1);

	// DE
	REAL4 zc = z;

	if (aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations1)
	{
		REAL rr = 0.0f;
		REAL4 one = (REAL4){1.0f, 1.0f, 1.0f, 0.0f};
		{
			REAL temp = zc.y;
			zc.y = zc.z;
			zc.z = temp;
		}
		zc += one;
		REAL modOff = fractal->transformCommon.offset3;
		aux->DE += fractal->analyticDE.offset0;
		int count = fractal->transformCommon.int8X;
		for (int k = 0; k < count && rr < 10.0f; k++)
		{
			REAL pax = fmod(zc.x * aux->DE, modOff) - 0.5f * modOff;
			REAL pay = fmod(zc.y * aux->DE, modOff) - 0.5f * modOff;
			REAL paz = fmod(zc.z * aux->DE, modOff) - 0.5f * modOff;
			REAL4 pp = (REAL4){pax, pay, paz, 0.0f};

			pp += fractal->transformCommon.offsetA000;
			rr = dot(pp, pp);

			// rotation
			if (fractal->transformCommon.functionEnabledRFalse
					&& k >= fractal->transformCommon.startIterationsR
					&& k < fractal->transformCommon.stopIterationsR)
			{
				pp = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, pp);
			}
			aux->DE0 = max(aux->DE0, (fractal->transformCommon.offset1 - length(pp)) / aux->DE);
			aux->DE *= fractal->transformCommon.scale3;
		}
		if (!fractal->transformCommon.functionEnabledAFalse)
		{
			// Use this to crop to a sphere:
			REAL e;
			if (!fractal->transformCommon.functionEnabledBFalse)
				e = length(z);
			else
				e = length(zc);
			e = clamp(e - fractal->transformCommon.offset2, 0.0f, 100.0f);
			aux->dist = max(aux->DE0, e);
		}
		else
		{
			aux->dist = aux->DE0;
		}
		aux->dist *= fractal->analyticDE.scale1;
	}
	return z;
}
