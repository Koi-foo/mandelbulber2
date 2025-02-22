/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * menger poly fold
 * @reference
 * https://fractalforums.org/fragmentarium/17/polyfoldsym-pre-transform/2684

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_menger_poly_fold.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MengerPolyFoldIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 oldZ = z;
	if (aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations1)
	{
		// pre abs
		if (fractal->transformCommon.functionEnabledx) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledzFalse) z.z = fabs(z.z);

		if (fractal->transformCommon.functionEnabledCx)
		{
			if (fractal->transformCommon.functionEnabledAxFalse && z.y < 0.0f) z.x = -z.x;
			REAL psi = M_PI_F / fractal->transformCommon.int8X;
			psi = fabs(fmod(atan(z.y / z.x) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.x * z.x + z.y * z.y);
			z.x = native_cos(psi) * len;
			z.y = native_sin(psi) * len;
		}

		if (fractal->transformCommon.functionEnabledCyFalse)
		{
			if (fractal->transformCommon.functionEnabledAyFalse && z.z < 0.0f) z.y = -z.y;
			REAL psi = M_PI_F / fractal->transformCommon.int8Y;
			psi = fabs(fmod(atan(z.z / z.y) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.y * z.y + z.z * z.z);
			z.y = native_cos(psi) * len;
			z.z = native_sin(psi) * len;
		}

		if (fractal->transformCommon.functionEnabledCzFalse)
		{
			if (fractal->transformCommon.functionEnabledAzFalse && z.x < 0.0f) z.z = -z.z;
			REAL psi = M_PI_F / fractal->transformCommon.int8Z;
			psi = fabs(fmod(atan(z.x / z.z) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.z * z.z + z.x * z.x);
			z.z = native_cos(psi) * len;
			z.x = native_sin(psi) * len;
		}

		z += fractal->transformCommon.additionConstant000;

		// rotation
		if (fractal->transformCommon.rotation2EnabledFalse)
		{
			z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
		}
	}

	// Menger Sponge
	z = fabs(z);
	REAL temp;
	REAL col = 0.0f;
	if (z.x < z.y)
	{
		temp = z.y;
		z.y = z.x;
		z.x = temp;
		col += fractal->foldColor.difs0000.x;
	}
	if (z.x < z.z)
	{
		temp = z.z;
		z.z = z.x;
		z.x = temp;
		col += fractal->foldColor.difs0000.y;
	}
	if (z.y < z.z)
	{
		temp = z.z;
		z.z = z.y;
		z.y = temp;
		col += fractal->foldColor.difs0000.z;
	}
	if (fractal->foldColor.auxColorEnabledFalse && aux->i >= fractal->foldColor.startIterationsA
			&& aux->i < fractal->foldColor.stopIterationsA)
	{
		aux->color += col;
	}
	z *= fractal->transformCommon.scale3;
	z.x -= 2.0f * fractal->transformCommon.constantMultiplierA111.x;
	z.y -= 2.0f * fractal->transformCommon.constantMultiplierA111.y;
	if (z.z > 1.0f) z.z -= 2.0f * fractal->transformCommon.constantMultiplierA111.z;
	aux->DE *= fabs(fractal->transformCommon.scale3 * fractal->transformCommon.scaleA1);

	z += fractal->transformCommon.additionConstantA000;

	if (fractal->analyticDE.enabled)
	{
		if (!fractal->analyticDE.enabledFalse)
			aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
		else
		{
			REAL avgScale = length(z) / length(oldZ);
			aux->DE = aux->DE * avgScale * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
		}
	}
	return z;
}
