module

public import Mathlib.Analysis.Matrix.Normed
public import Mathlib.MeasureTheory.Integral.Prod
public import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# Gaussian second moments of the cross-quadratic derivative matrix

These estimates concern fixed vectors and matrices, without any differentiability assumption.
The lower estimate is needed as well as the upper one: it recovers finite weighted derivative
energy from the matrix moment hypothesis, so no additional energy assumption is imposed.
All matrix norms are Frobenius norms.
-/

public section

open MeasureTheory ProbabilityTheory Matrix
open scoped InnerProductSpace Matrix.Norms.Frobenius RealInnerProductSpace

namespace Toolkit.Tricks.Probability.Moments

/-- [The squared Frobenius norm of the cross-quadratic derivative matrix formed from a fixed
vector, a fixed matrix, and a standard Gaussian vector has finite expectation](goal). -/
theorem integrable_gaussian_cross_matrix_sq {n : ℕ}
    (v : EuclideanSpace ℝ (Fin n)) (M : Matrix (Fin n) (Fin n) ℝ) :
    Integrable (fun z : EuclideanSpace ℝ (Fin n) =>
      ‖((⟪z, v⟫_ℝ • (1 : Matrix (Fin n) (Fin n) ℝ)) +
        Matrix.of (fun i j => v i * z j)) * M.transpose‖ ^ 2)
      (stdGaussian (EuclideanSpace ℝ (Fin n))) := by
  -- Entries are linear polynomials in z; Gaussian laws have all finite moments.
  sorry

/-- [The expected squared Frobenius norm of the cross-quadratic derivative matrix lies
between twice and four times the squared Frobenius norm of its fixed matrix times the
squared Euclidean norm of its fixed vector](goal). -/
theorem gaussian_cross_matrix_sq_bounds {n : ℕ}
    (v : EuclideanSpace ℝ (Fin n)) (M : Matrix (Fin n) (Fin n) ℝ) :
    let a := ∫ z : EuclideanSpace ℝ (Fin n),
      ‖((⟪z, v⟫_ℝ • (1 : Matrix (Fin n) (Fin n) ℝ)) +
        Matrix.of (fun i j => v i * z j)) * M.transpose‖ ^ 2
        ∂(stdGaussian (EuclideanSpace ℝ (Fin n)))
    2 * (‖M‖ ^ 2 * ‖v‖ ^ 2) ≤ a ∧ a ≤ 4 * (‖M‖ ^ 2 * ‖v‖ ^ 2) := by
  -- In fact the integral is 2‖M‖²‖v‖² + 2‖M v‖². Expand entries and use the
  -- identity covariance of stdGaussian, then bound ‖M v‖² by ‖M‖²‖v‖².
  sorry

end Toolkit.Tricks.Probability.Moments
