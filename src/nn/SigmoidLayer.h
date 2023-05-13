
#pragma once

#include "../globals.h"
#include "../util/connect.h"
#include "../util/util.cuh"
#include "Layer.h"
#include "SigmoidConfig.h"

extern int partyNum;

template <typename T, template <typename, typename...> typename Share>
class SigmoidLayer : public Layer<T, Share> {
   private:
    SigmoidConfig conf;

    Share<T> activations;
    Share<T> deltas;

   public:
    // Constructor and initializer
    SigmoidLayer(SigmoidConfig *conf, int _layerNum, int seed);

    // Functions
    void loadSnapshot(std::string path) override;
    void saveSnapshot(std::string path) override;
    void printLayer() override;
    void forward(const Share<T> &input) override;
    void backward(const Share<T> &delta, const Share<T> &forwardInput) override;

    // Getters
    Share<T> *getActivation() { return &activations; };
    Share<T> *getWeights() { return nullptr; };
    Share<T> *getBiases() { return nullptr; };
    Share<T> *getDelta() { return &deltas; };

    static Profiler sigmoid_profiler;
};
