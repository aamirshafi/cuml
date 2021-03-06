/*
 * Copyright (c) 2019-2020, NVIDIA CORPORATION.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <cuda_utils.cuh>
#include <cuml/metrics/metrics.hpp>
#include <metrics/adjustedRandIndex.cuh>
#include <metrics/klDivergence.cuh>
#include <metrics/pairwiseDistance.cuh>
#include <metrics/randIndex.cuh>
#include <metrics/silhouetteScore.cuh>
#include <metrics/vMeasure.cuh>
#include <score/scores.cuh>

namespace ML {

namespace Metrics {

float r2_score_py(const cumlHandle &handle, float *y, float *y_hat, int n) {
  return MLCommon::Score::r2_score(y, y_hat, n, handle.getStream());
}

double r2_score_py(const cumlHandle &handle, double *y, double *y_hat, int n) {
  return MLCommon::Score::r2_score(y, y_hat, n, handle.getStream());
}

double randIndex(const cumlHandle &handle, const double *y, const double *y_hat,
                 int n) {
  return MLCommon::Metrics::computeRandIndex(
    y, y_hat, (uint64_t)n, handle.getDeviceAllocator(), handle.getStream());
}

double silhouetteScore(const cumlHandle &handle, double *y, int nRows,
                       int nCols, int *labels, int nLabels, double *silScores,
                       int metric) {
  return MLCommon::Metrics::silhouetteScore<double, int>(
    y, nRows, nCols, labels, nLabels, silScores, handle.getDeviceAllocator(),
    handle.getStream(), metric);
}

double adjustedRandIndex(const cumlHandle &handle, const int64_t *y,
                         const int64_t *y_hat, const int64_t n) {
  return MLCommon::Metrics::computeAdjustedRandIndex<int64_t,
                                                     unsigned long long>(
    y, y_hat, n, handle.getDeviceAllocator(), handle.getStream());
}

double adjustedRandIndex(const cumlHandle &handle, const int *y,
                         const int *y_hat, const int n) {
  return MLCommon::Metrics::computeAdjustedRandIndex<int, unsigned long long>(
    y, y_hat, n, handle.getDeviceAllocator(), handle.getStream());
}

double klDivergence(const cumlHandle &handle, const double *y,
                    const double *y_hat, int n) {
  return MLCommon::Metrics::klDivergence(
    y, y_hat, n, handle.getDeviceAllocator(), handle.getStream());
}

float klDivergence(const cumlHandle &handle, const float *y, const float *y_hat,
                   int n) {
  return MLCommon::Metrics::klDivergence(
    y, y_hat, n, handle.getDeviceAllocator(), handle.getStream());
}

double entropy(const cumlHandle &handle, const int *y, const int n,
               const int lower_class_range, const int upper_class_range) {
  return MLCommon::Metrics::entropy(y, n, lower_class_range, upper_class_range,
                                    handle.getDeviceAllocator(),
                                    handle.getStream());
}

double mutualInfoScore(const cumlHandle &handle, const int *y, const int *y_hat,
                       const int n, const int lower_class_range,
                       const int upper_class_range) {
  return MLCommon::Metrics::mutualInfoScore(
    y, y_hat, n, lower_class_range, upper_class_range,
    handle.getDeviceAllocator(), handle.getStream());
}

double homogeneityScore(const cumlHandle &handle, const int *y,
                        const int *y_hat, const int n,
                        const int lower_class_range,
                        const int upper_class_range) {
  return MLCommon::Metrics::homogeneityScore(
    y, y_hat, n, lower_class_range, upper_class_range,
    handle.getDeviceAllocator(), handle.getStream());
}

double completenessScore(const cumlHandle &handle, const int *y,
                         const int *y_hat, const int n,
                         const int lower_class_range,
                         const int upper_class_range) {
  return MLCommon::Metrics::homogeneityScore(
    y_hat, y, n, lower_class_range, upper_class_range,
    handle.getDeviceAllocator(), handle.getStream());
}

double vMeasure(const cumlHandle &handle, const int *y, const int *y_hat,
                const int n, const int lower_class_range,
                const int upper_class_range) {
  return MLCommon::Metrics::vMeasure(
    y, y_hat, n, lower_class_range, upper_class_range,
    handle.getDeviceAllocator(), handle.getStream());
}

float accuracy_score_py(const cumlHandle &handle, const int *predictions,
                        const int *ref_predictions, int n) {
  return MLCommon::Score::accuracy_score(predictions, ref_predictions, n,
                                         handle.getDeviceAllocator(),
                                         handle.getStream());
}

void pairwiseDistance(const cumlHandle &handle, const double *x,
                      const double *y, double *dist, int m, int n, int k,
                      ML::Distance::DistanceType metric, bool isRowMajor) {
  MLCommon::Metrics::pairwiseDistance(x, y, dist, m, n, k, metric,
                                      handle.getDeviceAllocator(),
                                      handle.getStream(), isRowMajor);
}

void pairwiseDistance(const cumlHandle &handle, const float *x, const float *y,
                      float *dist, int m, int n, int k,
                      ML::Distance::DistanceType metric, bool isRowMajor) {
  MLCommon::Metrics::pairwiseDistance(x, y, dist, m, n, k, metric,
                                      handle.getDeviceAllocator(),
                                      handle.getStream(), isRowMajor);
}

}  // namespace Metrics
}  // namespace ML
