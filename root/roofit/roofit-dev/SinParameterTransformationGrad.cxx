// @(#)root/minuit2:$Id$
// Authors: M. Winkler, F. James, L. Moneta, A. Zsenei, E.G.P. Bos   2003-2017

/**********************************************************************
 *                                                                    *
 * Copyright (c) 2005 LCG ROOT Math team,  CERN/PH-SFT                *
 * Copyright (c) 2017 Patrick Bos, Netherlands eScience Center        *
 *                                                                    *
 **********************************************************************/

#include "SinParameterTransformationGrad.h"
#include "Minuit2/MnMachinePrecision.h"

#include <math.h>

namespace ROOT {

  namespace Minuit2 {



    long double SinParameterTransformationGrad::Int2ext(long double Value, long double Upper, long double Lower) const {
      // transformation from  to internal (unlimited) to external values (limited by Lower/Upper )
      return Lower + 0.5*(Upper - Lower)*(sin(Value) + 1.);
    }

    long double SinParameterTransformationGrad::Ext2int(long double Value, long double Upper, long double Lower, const MnMachinePrecision& prec) const {
      // transformation from external (limited by Lower/Upper )  to internal (unlimited) values given the lower/upper limits

      long double piby2 = 2.*atan(1.);
      long double distnn = 8.*sqrt(prec.Eps2());
      long double vlimhi = piby2 - distnn;
      long double vlimlo = -piby2 + distnn;

      long double yy = 2.*(Value - Lower)/(Upper - Lower) - 1.;
      long double yy2 = yy*yy;
      if(yy2 > (1. - prec.Eps2())) {
        if(yy < 0.) {
          // Lower limit
          //       std::cout<<"SinParameterTransformationGrad warning: is at its Lower allowed limit. "<<Value<<std::endl;
          return vlimlo;
        } else {
          // Upper limit
          //       std::cout<<"SinParameterTransformationGrad warning: is at its Upper allowed limit."<<std::endl;
          return vlimhi;
        }

      } else {
        return asin(yy);
      }
    }

    long double SinParameterTransformationGrad::DInt2Ext(long double Value, long double Upper, long double Lower) const {
      // return the derivative of the transformation d Ext/ d Int
      return 0.5*((Upper - Lower)*cos(Value));
    }

    long double SinParameterTransformationGrad::D2Int2Ext(long double Value, long double Upper, long double Lower) const {
      // return the second derivative of the transformation d^2 Ext/ {d Int}^2
      return 0.5 * ( (Lower - Upper) * sin(Value) );
    }

    long double SinParameterTransformationGrad::GStepInt2Ext(long double /*Value*/, long double /*Upper*/, long double /*Lower*/) const {
      return 1.;
    }

  }  // namespace Minuit2

}  // namespace ROOT
