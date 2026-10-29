module

public import Causalean.Mathlib.Analysis.Fourier.AngularFourier
public import Mathlib.MeasureTheory.Function.LocallyIntegrable
public import Mathlib.Probability.Distributions.Gaussian.Multivariate
public import StatLean.AsymptoticStatistics.ForMathlib.MultivariateGaussianDensity

/-!
# Weak Gaussian integration by parts

The distributional derivative predicate is reused from Causalean. Local integrability of
the function and derivative is imposed explicitly, avoiding any interpretation of a divergent
Bochner integral as a distributional identity. Only compactly supported smooth tests appear
in the definition; global Gaussian identities must be derived by cutoff limits.
-/

public section

open MeasureTheory ProbabilityTheory
open Causalean.Mathlib.Analysis.Fourier
open scoped ContDiff

namespace Toolkit.Tricks.Probability.Moments

/-- If [a real function and its proposed coordinate derivative are locally integrable]
(hyp:hLocal) and [satisfy weak differentiation against compact smooth tests](hyp:hWeak),
then for [any smooth](hyp:hSmooth) [compactly supported test](hyp:hSupport),
[Gaussian integration by parts transfers the coordinate derivative to the test and
adds the Gaussian coordinate weight](goal). -/
theorem gaussian_weak_coordinate_ibp_test {n : ℕ}
    (u du : EuclideanSpace ℝ (Fin n) → ℝ) (i : Fin n)
    (hLocal : LocallyIntegrable u volume ∧ LocallyIntegrable du volume)
    (hWeak : HasWeakCoordinateDerivative (complexify u) (complexify du) i)
    (φ : EuclideanSpace ℝ (Fin n) → ℝ)
    (hSmooth : ContDiff ℝ ∞ φ) (hSupport : HasCompactSupport φ) :
    (∫ x, du x * φ x ∂(stdGaussian (EuclideanSpace ℝ (Fin n)))) =
      ∫ x, u x * (x i * φ x - fderiv ℝ φ x (coordinateVector i))
        ∂(stdGaussian (EuclideanSpace ℝ (Fin n))) := by
  -- Reuse AsymptoticStatistics.multivariateGaussian_eq_smul_withDensity at S=1
  -- (multivariateGaussian_zero_one), rather than rebuilding the Gaussian density.
  -- Its positive finite normalization constant cancels from the IBP equality.
  -- Apply hWeak to the complexification of φ times exp(-‖x‖²/2), then take real parts.
  sorry

/-- If [a locally integrable real function and derivative](hyp:hLocal) [satisfy weak
coordinate differentiation](hyp:hWeak), and [the function](hyp:hu), [its derivative]
(hyp:hdu), and [its coordinate-weighted value](hyp:hxu) are Gaussian integrable, then
[the expected derivative equals the expected coordinate-weighted value](goal). -/
theorem gaussian_weak_coordinate_ibp {n : ℕ}
    (u du : EuclideanSpace ℝ (Fin n) → ℝ) (i : Fin n)
    (hLocal : LocallyIntegrable u volume ∧ LocallyIntegrable du volume)
    (hWeak : HasWeakCoordinateDerivative (complexify u) (complexify du) i)
    (hu : Integrable u (stdGaussian (EuclideanSpace ℝ (Fin n))))
    (hdu : Integrable du (stdGaussian (EuclideanSpace ℝ (Fin n))))
    (hxu : Integrable (fun x => x i * u x) (stdGaussian (EuclideanSpace ℝ (Fin n)))) :
    (∫ x, du x ∂(stdGaussian (EuclideanSpace ℝ (Fin n)))) =
      ∫ x, x i * u x ∂(stdGaussian (EuclideanSpace ℝ (Fin n))) := by
  -- Apply gaussian_weak_coordinate_ibp_test with smooth cutoffs tending to one,
  -- uniformly bounded by one, with gradients uniformly tending to zero.
  -- The three L¹ assumptions justify dominated convergence; no smoothness of u is added.
  sorry

end Toolkit.Tricks.Probability.Moments
