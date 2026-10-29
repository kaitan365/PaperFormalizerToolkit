module

public import Mathlib.Analysis.Matrix.Normed
public import Mathlib.LinearAlgebra.Matrix.Trace
public import Mathlib.MeasureTheory.Function.L2Space
public import Mathlib.MeasureTheory.Integral.MeanInequalities

/-!
# Frobenius trace estimates

Pointwise and integrated Cauchy–Schwarz inequalities for the trace of a matrix product.
Every matrix norm in this module is the Frobenius norm, selected explicitly by its scope.
-/

public section

open MeasureTheory Matrix
open scoped Matrix.Norms.Frobenius

namespace Toolkit.Tricks.Probability.Moments

/-- [The absolute trace of the product of two real square matrices is at most the product
of their Frobenius norms](goal). -/
theorem abs_trace_mul_le_frobenius {n : ℕ} (M N : Matrix (Fin n) (Fin n) ℝ) :
    |Matrix.trace (M * N)| ≤ ‖M‖ * ‖N‖ := by
  -- Expand trace as the inner product of the entries of M and the transpose of N,
  -- then use finite-dimensional Cauchy–Schwarz and invariance under transposition.
  sorry

/-- If [two measurable random matrices have finite second Frobenius moments](hyp:hM,hN),
then [their trace product is integrable and its expected absolute value is bounded by
the geometric mean of those moments](goal). -/
theorem integrable_trace_mul_and_bound {Ω : Type*} [MeasurableSpace Ω]
    {μ : Measure Ω} {n : ℕ} (M N : Ω → Matrix (Fin n) (Fin n) ℝ)
    (hM : MemLp M 2 μ) (hN : MemLp N 2 μ) :
    Integrable (fun x => Matrix.trace (M x * N x)) μ ∧
      (∫ x, |Matrix.trace (M x * N x)| ∂μ) ≤
        Real.sqrt (∫ x, ‖M x‖ ^ 2 ∂μ) * Real.sqrt (∫ x, ‖N x‖ ^ 2 ∂μ) := by
  -- Dominate by the product of the norms and apply integral Cauchy–Schwarz.
  sorry

end Toolkit.Tricks.Probability.Moments
