// @(#)root/minuit2:$Id$
// Authors: M. Winkler, F. James, L. Moneta, A. Zsenei, E.G.P. Bos   2003-2017

/**********************************************************************
 *                                                                    *
 * Copyright (c) 2005 LCG ROOT Math team,  CERN/PH-SFT                *
 * Copyright (c) 2017 Patrick Bos, Netherlands eScience Center        *
 *                                                                    *
 **********************************************************************/

// Project   : LCG
// Package   : Minuit
// Author    : Lorenzo.MONETA@cern.ch
// Created by: moneta  at Thu Apr  8 10:26:22 2004


#ifndef ROOT_Minuit2_SqrtLowParameterTransformationGrad
#define ROOT_Minuit2_SqrtLowParameterTransformationGrad

#include "Minuit2/SqrtLowParameterTransformation.h"

namespace ROOT {

  namespace Minuit2 {

    class MnMachinePrecision;


/**
 * Transformation from external to internal Parameter based on  sqrt(1 + x**2)
 *
 * This transformation applies for the case of single side Lower Parameter limits
 */

    class SqrtLowParameterTransformationGrad : public SqrtLowParameterTransformation/* : public ParameterTransformation */ {

    public:

      SqrtLowParameterTransformationGrad() {}

      ~SqrtLowParameterTransformationGrad() {}

      // transformation from internal to external
      long double Int2ext(long double Value, long double Lower) const;

      // transformation from external to internal
      long double Ext2int(long double Value, long double Lower, const MnMachinePrecision&) const;

      // derivative of transformation from internal to external
      long double DInt2Ext(long double Value, long double Lower) const;

      long double D2Int2Ext(long double Value, long double Lower) const;
      long double GStepInt2Ext(long double Value, long double Lower) const;

    private:
    };

  }  // namespace Minuit2

}  // namespace ROOT

#endif
