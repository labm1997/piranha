
#pragma once

#include "../globals.h"
#include "LayerConfig.h"

class SigmoidConfig : public LayerConfig {
   public:
    size_t inputDim = 0;
    size_t batchSize = 0;

    SigmoidConfig(size_t _inputDim, size_t _batchSize)
        : LayerConfig("Sigmoid"),
          inputDim(_inputDim),
          batchSize(_batchSize){
              // nothing
          };
};
