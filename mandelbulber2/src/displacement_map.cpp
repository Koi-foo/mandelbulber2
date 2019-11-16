/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2016-19 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * Bump Map displacement by adding effect to existing distance
 */

#include "displacement_map.hpp"

#include "compute_fractal.hpp"
#include "fractparams.hpp"
#include "render_data.hpp"
#include "texture_mapping.hpp"

double DisplacementMap(
	double oldDistance, CVector3 point, int objectId, sRenderData *data, double reduce)
{
	double distance = oldDistance;
	if (data)
	{
		const cMaterial *mat = &data->materials[data->objectData[objectId].materialId];

		if (mat->displacementTexture.IsLoaded())
		{
			CVector2<double> textureCoordinates;
			textureCoordinates =
				TextureMapping(point, CVector3(0.0, 0.0, 1.0), data->objectData[objectId], mat)
				+ CVector2<double>(0.5, 0.5);
			sRGBFloat bump3 = mat->displacementTexture.Pixel(textureCoordinates);
			double bump = double(bump3.R);
			distance -= bump * mat->displacementTextureHeight / reduce;
			if (distance < 0.0) distance = 0.0;
		}
	}
	return distance;
}

CVector3 FractalizeTexture(const CVector3 &point, sRenderData *data, const sParamRender &params,
	const cNineFractals &fractals, int objectId, double *reduceDisplacement)
{
	int forcedFormulaIndex = objectId;
	if (objectId < 0) objectId = 0;

	CVector3 pointFractalized = point;
	if (data)
	{
		const cMaterial *mat = &data->materials[data->objectData[objectId].materialId];
		if (mat->textureFractalize)
		{
			sFractalIn fractIn(point, 0, params.N, &params.common, forcedFormulaIndex, false, mat);
			sFractalOut fractOut;
			Compute<fractal::calcModeCubeOrbitTrap>(fractals, fractIn, &fractOut);
			pointFractalized = fractOut.z;
			*reduceDisplacement = pow(2.0, fractOut.iters);
		}
	}
	return pointFractalized;
}
