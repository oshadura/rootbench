// @(#)root/minuit2:$Id$
// Authors: M. Winkler, F. James, L. Moneta, A. Zsenei, E.G.P. Bos   2003-2017

/**********************************************************************
 *                                                                    *
 * Copyright (c) 2005 LCG ROOT Math team,  CERN/PH-SFT                *
 * Copyright (c) 2017 Patrick Bos, Netherlands eScience Center        *
 *                                                                    *
 **********************************************************************/

#ifndef ROOT_Minuit2_SinParameterTransformationGrad
#define ROOT_Minuit2_SinParameterTransformationGrad

#include "Minuit2/SinParameterTransformation.h"

namespace ROOT {

  namespace Minuit2 {


    class MnMachinePrecision;

/**
   class for the transformation for double-limited parameter
   Using a sin function one goes from a double-limited parameter range to
   an unlimited one
 */
    class SinParameterTransformationGrad : public SinParameterTransformation {

    public:

      SinParameterTransformationGrad() {}

      ~SinParameterTransformationGrad() {}

      long double Int2ext(long double Value, long double Upper, long double Lower) const;
      long double Ext2int(long double Value, long double Upper, long double Lower,
                     const MnMachinePrecision&) const;
      long double DInt2Ext(long double Value, long double Upper, long double Lower) const;

      long double D2Int2Ext(long double Value, long double Upper, long double Lower) const;
      long double GStepInt2Ext(long double Value, long double Upper, long double Lower) const;

    private:

    };

  }  // namespace Minuit2

}  // namespace ROOT

#endif  // ROOT_Minuit2_SinParameterTransformation
