module

public import Mathlib.Data.PNat.Basic
public import Toolkit.Staging.RandomsketchALemRowwiseGaussianCovarianceCited.FrobeniusTrace
public import Toolkit.Staging.RandomsketchALemRowwiseGaussianCovarianceCited.GaussianMatrixMoments
public import Toolkit.Staging.RandomsketchALemRowwiseGaussianCovarianceCited.WeakGaussianIntegration

/-!
# Gaussian covariance bounds for cross-dependent quadratic forms

The main result is Bellec (2023), Lemma 7.1, equations (7.2)–(7.3).
The reference is https://arxiv.org/abs/2008.11840v5, source label
`lemma:f-g-z_j-z_k`. Its proof uses the polarized second-order Gaussian Stein identity.

Vectors carry the Euclidean norm and matrices the Frobenius norm. A weak Jacobian is
stored with coordinate directions as rows and component gradients as columns, as in the
source's gradient convention. Its transpose is the usual output-by-input derivative matrix.
Derivative witnesses are explicit: classical `fderiv` is not substituted for weak derivatives.
An arbitrary joint law is permitted, with a hypothesis identifying it as the product standard
Gaussian law. This represents precisely the independent Gaussian random vectors in the result.

All definitions used in the main statement are here. The staging path is temporary; promotion
should retain the namespace and use the module path
`Toolkit/Tricks/Probability/Moments/GaussianStein`.
-/

@[expose] public section

noncomputable section

open MeasureTheory ProbabilityTheory Matrix
open Causalean.Mathlib.Analysis.Fourier
open scoped InnerProductSpace Matrix.Norms.Frobenius RealInnerProductSpace

namespace Toolkit.Tricks.Probability.Moments

/-- [A matrix field is a weak Jacobian](goal) of [a vector field](hyp:f) with
[proposed coordinate derivatives](hyp:J) when [each component of the vector field is
locally integrable](step:1), [each matrix entry is locally integrable](step:2), and
[entry i,j is the weak derivative of component j in coordinate i](step:3).

The derivative identity uses Causalean's compact smooth test definition, after complexification.
Rows index differentiating coordinates and columns index vector components.
-/
def HasWeakJacobian {n : ℕ} (f : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  (∀ j, LocallyIntegrable (fun x => f x j) volume) ∧
  (∀ i j, LocallyIntegrable (fun x => J x i j) volume) ∧
  (∀ i j, HasWeakCoordinateDerivative (complexify (fun x => f x j))
    (complexify (fun x => J x i j)) i)

/-- [The centered quadratic error](goal) for [a coefficient field](hyp:f),
[a Gaussian input](hyp:z), and [the other input on which the coefficients depend](hyp:w)
is the squared inner product of the input and coefficient vector minus the squared
Euclidean norm of that coefficient vector. -/
def crossQuadraticError {n : ℕ}
    (f : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (z w : EuclideanSpace ℝ (Fin n)) : ℝ :=
  ⟪z, f w⟫_ℝ ^ 2 - ‖f w‖ ^ 2

/-- [The cross-quadratic derivative matrix](goal) for [a coefficient field](hyp:f),
[its weak Jacobian](hyp:J), [the Gaussian input](hyp:z), and [the coefficient input]
(hyp:w) is the inner product times the identity plus the coefficient-input outer product,
all multiplied by the transpose of the weak Jacobian at the coefficient input. -/
def crossQuadraticMatrix {n : ℕ}
    (f : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ)
    (z w : EuclideanSpace ℝ (Fin n)) : Matrix (Fin n) (Fin n) ℝ :=
  ((⟪z, f w⟫_ℝ • (1 : Matrix (Fin n) (Fin n) ℝ)) +
    Matrix.of (fun i j => f w i * z j)) * (J w).transpose

/-- [The required cross-quadratic moments are finite](goal) under [a joint law](hyp:μ)
for [two coefficient fields](hyp:f,h) and [their weak Jacobians](hyp:J,K) when
[the first coefficient's fourth moment](step:1), [the second coefficient's fourth
moment](step:2), [the first derivative matrix's second Frobenius moment](step:3), and
[the second derivative matrix's second Frobenius moment](step:4) are finite.

Integrability of these nonnegative quantities expresses the finite sum of moments in the source.
The first input in a pair is z and the second is w; the second matrix swaps the two inputs.
-/
def CrossQuadraticMoments {n : ℕ}
    (μ : Measure (EuclideanSpace ℝ (Fin n) × EuclideanSpace ℝ (Fin n)))
    (f h : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J K : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  Integrable (fun p => ‖f p.2‖ ^ 4) μ ∧
  Integrable (fun p => ‖h p.1‖ ^ 4) μ ∧
  Integrable (fun p => ‖crossQuadraticMatrix f J p.1 p.2‖ ^ 2) μ ∧
  Integrable (fun p => ‖crossQuadraticMatrix h K p.2 p.1‖ ^ 2) μ

/-- For [a vector field with a weak Jacobian](hyp:hWeak), if [the inputs have the
independent standard Gaussian joint law](hyp:hGaussian) and [the cross-quadratic
derivative matrix has a finite second Frobenius moment](hyp:hMatrix), then [the
weighted derivative energy is integrable and the matrix moment is at most four
times that energy](goal). -/
theorem gaussian_cross_matrix_energy {n : ℕ}
    (μ : Measure (EuclideanSpace ℝ (Fin n) × EuclideanSpace ℝ (Fin n)))
    (f : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ)
    (hGaussian : μ = (stdGaussian (EuclideanSpace ℝ (Fin n))).prod
      (stdGaussian (EuclideanSpace ℝ (Fin n))))
    (hWeak : HasWeakJacobian f J)
    (hMatrix : Integrable (fun p => ‖crossQuadraticMatrix f J p.1 p.2‖ ^ 2) μ) :
    Integrable (fun p => ‖J p.2‖ ^ 2 * ‖f p.2‖ ^ 2) μ ∧
      (∫ p, ‖crossQuadraticMatrix f J p.1 p.2‖ ^ 2 ∂μ) ≤
        4 * (∫ p, ‖J p.2‖ ^ 2 * ‖f p.2‖ ^ 2 ∂μ) := by
  -- Use local integrability for a.e. measurability and the existing
  -- AsymptoticStatistics.stdGaussian_absolutelyContinuous_volume. Tonelli plus
  -- gaussian_cross_matrix_sq_bounds
  -- gives finite energy from the lower bound, before using Fubini for the upper bound.
  sorry

/-- If [two vector fields have weak Jacobians](hyp:hWeakDiff) and [both the fields
and their Jacobians have finite Gaussian second moments](hyp:hL2), then [their
Gaussian divergences have finite second moments, their product is integrable, and
its expectation equals the expected inner product plus the trace of the Jacobian
product](goal). -/
theorem gaussian_second_order_stein_identity {n : ℕ}
    (F H : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J K : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ)
    (hWeakDiff : HasWeakJacobian F J ∧ HasWeakJacobian H K)
    (hL2 : MemLp F 2 (stdGaussian (EuclideanSpace ℝ (Fin n))) ∧
      MemLp H 2 (stdGaussian (EuclideanSpace ℝ (Fin n))) ∧
      MemLp J 2 (stdGaussian (EuclideanSpace ℝ (Fin n))) ∧
      MemLp K 2 (stdGaussian (EuclideanSpace ℝ (Fin n)))) :
    let δF := fun x => ⟪x, F x⟫_ℝ - Matrix.trace (J x)
    let δH := fun x => ⟪x, H x⟫_ℝ - Matrix.trace (K x)
    MemLp δF 2 (stdGaussian (EuclideanSpace ℝ (Fin n))) ∧
    MemLp δH 2 (stdGaussian (EuclideanSpace ℝ (Fin n))) ∧
    Integrable (fun x => δF x * δH x) (stdGaussian (EuclideanSpace ℝ (Fin n))) ∧
    (∫ x, δF x * δH x ∂(stdGaussian (EuclideanSpace ℝ (Fin n)))) =
      ∫ x, ⟪F x, H x⟫_ℝ + Matrix.trace (J x * K x)
        ∂(stdGaussian (EuclideanSpace ℝ (Fin n))) := by
  -- Research chain (do not assume any step as a new hypothesis):
  -- (1) derive the identity for compact smooth fields by two coordinate IBPs;
  -- (2) prove density of compact smooth fields in the Gaussian W¹,² norm using
  --     spatial cutoffs followed by mollification, retaining distributional derivatives;
  -- (3) use the identity with F=H to control Gaussian divergence in L², extend by
  --     completion, and identify that extension with x·F-tr J locally;
  -- (4) polarize. Weak derivatives alone do not license iterating classical fderiv.
  sorry

/-- For [two coefficient fields](hyp:f,h), if [the two inputs are independent standard
Gaussian vectors](hyp:hGaussian), [both fields have weak Jacobians](hyp:hWeakDiff), and [their fourth
moments and the two derivative matrices' second Frobenius moments are finite]
(hyp:hMoments), then [the product of centered quadratic errors is integrable and
its expectation equals the expected trace of the two derivative matrices' product](goal). -/
theorem gaussian_cross_quadratic_covariance_identity {n : ℕ}
    (μ : Measure (EuclideanSpace ℝ (Fin n) × EuclideanSpace ℝ (Fin n)))
    (f h : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J K : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ)
    (hGaussian : μ = (stdGaussian (EuclideanSpace ℝ (Fin n))).prod
      (stdGaussian (EuclideanSpace ℝ (Fin n))))
    (hWeakDiff : HasWeakJacobian f J ∧ HasWeakJacobian h K)
    (hMoments : CrossQuadraticMoments μ f h J K) :
    Integrable (fun p => crossQuadraticError f p.1 p.2 *
      crossQuadraticError h p.2 p.1) μ ∧
    (∫ p, crossQuadraticError f p.1 p.2 * crossQuadraticError h p.2 p.1 ∂μ) =
      ∫ p, Matrix.trace (crossQuadraticMatrix f J p.1 p.2 *
        crossQuadraticMatrix h K p.2 p.1) ∂μ := by
  -- Lift to dimension 2n: F(z,w)=((z·f(w))f(w),0),
  -- H(z,w)=(0,(w·h(z))h(z)). Their output-by-input derivatives have blocks
  -- [f fᵀ, A; 0,0] and [0,0; B,h hᵀ]. Establish weak product and lift rules,
  -- and L² bounds from hMoments, before invoking gaussian_second_order_stein_identity.
  -- Transport the product Gaussian to EuclideanSpace (Fin (n+n)) using a linear isometry.
  sorry

/-- For [two coefficient fields](hyp:f,h), if [the inputs are independent standard Gaussian
vectors](hyp:hGaussian), [the fields have weak Jacobians](hyp:hWeakDiff), and [the coefficient
fourth moments and derivative matrix second moments are finite](hyp:hMoments), then
[the expected absolute trace product is at most four times the geometric mean
of the two expected weighted derivative energies](goal). -/
theorem gaussian_cross_quadratic_trace_bound {n : ℕ}
    (μ : Measure (EuclideanSpace ℝ (Fin n) × EuclideanSpace ℝ (Fin n)))
    (f h : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J K : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ)
    (hGaussian : μ = (stdGaussian (EuclideanSpace ℝ (Fin n))).prod
      (stdGaussian (EuclideanSpace ℝ (Fin n))))
    (hWeakDiff : HasWeakJacobian f J ∧ HasWeakJacobian h K)
    (hMoments : CrossQuadraticMoments μ f h J K) :
    (∫ p, |Matrix.trace (crossQuadraticMatrix f J p.1 p.2 *
      crossQuadraticMatrix h K p.2 p.1)| ∂μ) ≤
      4 * Real.sqrt (∫ p, ‖J p.2‖ ^ 2 * ‖f p.2‖ ^ 2 ∂μ) *
        Real.sqrt (∫ p, ‖K p.1‖ ^ 2 * ‖h p.1‖ ^ 2 ∂μ) := by
  -- Apply gaussian_cross_matrix_energy twice, transporting the second use by
  -- Prod.swap and symmetry of the product Gaussian law. Obtain MemLp for A,B
  -- from their a.e. measurability and finite squared norms, then apply
  -- integrable_trace_mul_and_bound and sqrt monotonicity.
  sorry

/-- For two independent standard Gaussian vectors in a positive dimension, and two
weakly differentiable [vector fields](hyp:f,h), the covariance of their cross-dependent centered
quadratic forms equals an expected matrix trace and satisfies a bound with constant four.
Specifically, if [the inputs have the independent standard Gaussian joint law]
(hyp:hGaussian), [both coefficient fields have weak Jacobians](hyp:hWeakDiff), and
[the coefficient fourth moments and derivative matrix second Frobenius moments are finite]
(hyp:hMoments), then [the expected product of centered quadratic errors equals the
expected trace product, whose expected absolute value is bounded by four times the
geometric mean of the weighted derivative energies](goal). -/
theorem gaussian_cross_quadratic_covariance_bound {n : ℕ+}
    (μ : Measure (EuclideanSpace ℝ (Fin n) × EuclideanSpace ℝ (Fin n)))
    (f h : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin n))
    (J K : EuclideanSpace ℝ (Fin n) → Matrix (Fin n) (Fin n) ℝ)
    (hGaussian : μ = (stdGaussian (EuclideanSpace ℝ (Fin n))).prod
      (stdGaussian (EuclideanSpace ℝ (Fin n))))
    (hWeakDiff : HasWeakJacobian f J ∧ HasWeakJacobian h K)
    (hMoments : CrossQuadraticMoments μ f h J K) :
    (∫ p, crossQuadraticError f p.1 p.2 * crossQuadraticError h p.2 p.1 ∂μ) =
      (∫ p, Matrix.trace (crossQuadraticMatrix f J p.1 p.2 *
        crossQuadraticMatrix h K p.2 p.1) ∂μ) ∧
    (∫ p, |Matrix.trace (crossQuadraticMatrix f J p.1 p.2 *
      crossQuadraticMatrix h K p.2 p.1)| ∂μ) ≤
      4 * Real.sqrt (∫ p, ‖J p.2‖ ^ 2 * ‖f p.2‖ ^ 2 ∂μ) *
        Real.sqrt (∫ p, ‖K p.1‖ ^ 2 * ‖h p.1‖ ^ 2 ∂μ) := by
  exact ⟨(gaussian_cross_quadratic_covariance_identity μ f h J K
    hGaussian hWeakDiff hMoments).2,
    gaussian_cross_quadratic_trace_bound μ f h J K hGaussian hWeakDiff hMoments⟩

end Toolkit.Tricks.Probability.Moments
