# Cited results from randomsketch proposed for your toolkit

Created 2026-10-29T15:33:00.403Z. The paper relies on 3 cited result(s) it does not prove that could join your toolkit.
Unbuilt, each stays an assumption of the paper. Decide each by editing the `decision:` line in its
`decision` block:

- `accept` — build it in your toolkit (proved and reviewed before the paper's proofs); the paper then
  uses it instead of assuming it. Building a deep result takes a while.
- `accept_with_edits` — the same, with your changes: add an `edits:` line, then one `<field>: <value>`
  line per change (fields: division, target_module, proposed_name, title, reference, content; indented lines continue a value).
- `decline` — it stays a cited assumption of the paper.
- `defer` — not now; it stays an assumption and may be proposed again.
- Any decision may carry a `note: <text>` line; it is kept in the ledger.

Then run:

    paperformalizer propose randomsketch --round A --apply --toolkit /Users/kaitan9/PaperFormalizerToolkit

## a-lem-rowwise-gaussian-covariance-cited · Gaussian covariance bound for cross-dependent quadratic forms

**Goes to.** Tricks › Probability › Moments — Judgement bar: a general covariance technique for Gaussian quadratic forms with coefficients depending on the other Gaussian vector. (The dependency graph reads it as Foundations-shaped: it leans on Mathlib alone.)

**First sighting.** A technique seen in one paper only; deferring it keeps it on record, and it returns when another of your papers proves the same pattern.

**Reference.** Pierre C. Bellec, Out-of-sample error estimation for M-estimators with convex penalty (2023), Lemma 7.1, equations (7.2)–(7.3).

**Content.**

> Let n be a positive integer, [let z and w be independent standard Gaussian vectors in ℝⁿ](hyp:hGaussian), and let f,h:ℝⁿ → ℝⁿ [have weakly differentiable components](hyp:hWeakDiff). Write ∇f and ∇h for their Jacobian matrices, Iₙ for the identity matrix, tr for matrix trace, ‖·‖ for the Euclidean norm, and ‖·‖F for the Frobenius norm; define A = ((zᵀf(w))Iₙ + f(w)zᵀ)∇f(w)ᵀ and B = ((wᵀh(z))Iₙ + h(z)wᵀ)∇h(z)ᵀ. If [𝔼‖f(w)‖⁴ + 𝔼‖h(z)‖⁴ + 𝔼‖A‖F² + 𝔼‖B‖F² is finite](hyp:hMoments), then [𝔼(((zᵀf(w))² − ‖f(w)‖²)((wᵀh(z))² − ‖h(z)‖²)) = 𝔼(tr(AB)), and 𝔼|tr(AB)| ≤ 4√(𝔼(‖∇f(w)‖F²‖f(w)‖²))√(𝔼(‖∇h(z)‖F²‖h(z)‖²))](goal), where every expectation is under the joint law of z and w.

**In the paper.** The paper applies this result after conditioning on all but two Gaussian design rows, then integrates and uses Cauchy–Schwarz to obtain its unconditional rowwise covariance bound.

**Why it is reusable.** No recurrence is recorded; offered on judgement as a technique for controlling dependence between Gaussian quadratic errors in risk estimation and random-design statistics. Building weak-derivative Gaussian integration by parts and its approximation arguments is substantial.

**In your other papers.** first time — no other paper of yours states it.

**Closest existing results.**
  - Computes covariance under a linear Gaussian transformation; it does not control quadratic forms whose coefficient fields depend on the other Gaussian vector. (Causalean: Causalean.Stat.gaussian_pushforward_covariance)
  - Identifies the distribution of a fixed Gaussian quadratic form; it provides neither this cross-dependent covariance identity nor its derivative bound. (StatLean: StatLean.HypothesisTesting.map_quadraticForm_multivariateGaussian_eq_chiSquared)

**If accepted.** It is built in your toolkit from scratch (stated as above, proved and reviewed); the paper then uses it instead of assuming it.

**Independent check.** agrees — Matches Lemma 7.1’s hypotheses, matrix definitions, identity and constant 4. No supplied declaration duplicates it. This specialized Gaussian covariance technique fits Tricks and Probability/Moments/GaussianStein.

<details><summary>Lean details</summary>

- Name in the toolkit: `Toolkit.Tricks.Probability.Moments.gaussian_cross_quadratic_covariance_bound` in `Toolkit/Tricks/Probability/Moments/GaussianStein.lean` (Tricks) — a new module: Gaussian integration-by-parts bounds for data-dependent quadratic forms and vector-field divergences.
- Cited by the paper as `lem:rowwise-gaussian-covariance-cited` (Pierre~C. Bellec. \newblock Out-of-sample error estimation for {$M$}-estimators with convex penalty. \newblock \emph{Information and Inference: A Journal of the IMA}, 12\penalty0 (4):\penalty0 2782--2817, 2023. \newblock \doi{10.1093/imaiai/iaad031}., Lemma 7.1); assumed until built

</details>

```decision
decision: accept
```

## a-lem-matrix-gaussian-divergence-cited · Gaussian divergence bound for a product of vector fields

**Goes to.** Tricks › Probability › Moments — Judgement bar: a reusable Gaussian divergence estimate for bilinear statistics with data-dependent vector fields. (The dependency graph reads it as Foundations-shaped: it leans on Mathlib alone.)

**First sighting.** A technique seen in one paper only; deferring it keeps it on record, and it returns when another of your papers proves the same pattern.

**Reference.** Pierre C. Bellec and Yiwei Shen, Derivatives and residual distribution of regularized M-estimators with application to adaptive tuning (2022), Appendix C, proof of Proposition 14, equation (C.3).

**Content.**

> Let n and p be positive integers, [let G be a real n × p random matrix with independent standard Gaussian entries](hyp:hGaussian), and let η and ρ map real n × p matrices into ℝᵖ and ℝⁿ, respectively, [with both fields locally Lipschitz](hyp:hLocalLip). Evaluate all fields and their almost-everywhere partial derivatives at G, and use Euclidean norms. If [𝔼(‖ρ‖²‖η‖²) and 𝔼(∑ᵢ₌₁ⁿ ∑ⱼ₌₁ᵖ (‖η‖²‖∂ρ/∂gᵢⱼ‖² + ‖ρ‖²‖∂η/∂gᵢⱼ‖²)) are finite](hyp:hIntegrability), then [𝔼((ρᵀGη − ∑ᵢ₌₁ⁿ ∑ⱼ₌₁ᵖ ∂(ρᵢηⱼ)/∂gᵢⱼ)²) ≤ 𝔼(‖ρ‖²‖η‖²) + 2𝔼(∑ᵢ₌₁ⁿ ∑ⱼ₌₁ᵖ (‖η‖²‖∂ρ/∂gᵢⱼ‖² + ‖ρ‖²‖∂η/∂gᵢⱼ‖²))](goal).

**In the paper.** The paper uses smooth fields and applies this deterministic-field inequality conditionally on an independent sigma-field.

**Why it is reusable.** No recurrence is recorded; offered on judgement because the estimate controls Gaussian bilinear estimation errors using only field sizes and first derivatives. Building the multivariate Gaussian divergence identity and extending it to locally Lipschitz fields requires substantial infrastructure.

**In your other papers.** first time — no other paper of yours states it.

**Closest existing results.**
  - Describes the law of a standard Gaussian squared norm; it does not estimate divergences of fields depending on a Gaussian matrix. (Causalean: Causalean.Mathlib.stdGaussian_map_normSq_eq_pi)
  - Bounds sub-Gaussian norms of sums; it does not supply the derivative correction or the second-moment divergence estimate. (StatLean: StatLean.ConcentrationInequalities.subGaussianNorm_sum_le)

**If accepted.** It is built in your toolkit from scratch (stated as above, proved and reviewed); the paper then uses it instead of assuming it.

**Independent check.** agrees — Matches equation (C.3), including local Lipschitz regularity and the factor 2. No supplied declaration duplicates it. The specialized product-field estimate supports Tricks despite the Foundations signal; its topic is appropriate.

<details><summary>Lean details</summary>

- Name in the toolkit: `Toolkit.Tricks.Probability.Moments.gaussian_product_divergence_sq_le` in `Toolkit/Tricks/Probability/Moments/GaussianStein.lean` (Tricks) — a new module: Gaussian integration-by-parts bounds for data-dependent quadratic forms and vector-field divergences.
- Cited by the paper as `lem:matrix-gaussian-divergence-cited` (Pierre~C. Bellec and Yiwei Shen. \newblock Derivatives and residual distribution of regularized {$M$}-estimators with application to adaptive tuning. \newblock In \emph{Proceedings of the 35th Conference on Learning Theory}, volume 178 of \emph{Proceedings of Machine Learning Research}, pages 1912--1947. PMLR, 2022. \newblock URL \url{https://proceedings.mlr.press/v178/bellec22a.html}., Proposition 14); assumed until built

</details>

```decision
decision: accept
```

## a-lem-one-vector-second-order-cited · Second-order Gaussian divergence bound for a bounded vector field

**Goes to.** Tricks › Probability › Moments — Judgement bar: a general technique for approximating squared Gaussian divergences by dimension times vector-field energy. (The dependency graph reads it as Foundations-shaped: it leans on Mathlib alone.)

**First sighting.** A technique seen in one paper only; deferring it keeps it on record, and it returns when another of your papers proves the same pattern.

**Reference.** Pierre C. Bellec and Yiwei Shen, Derivatives and residual distribution of regularized M-estimators with application to adaptive tuning (2022), Appendix C, proof of Proposition 16, equation (C.6).

**Content.**

> Let n and p be positive integers, [let G be a real n × p random matrix with independent standard Gaussian entries](hyp:hGaussian), and let ρ map real n × p matrices into ℝⁿ [as a locally Lipschitz vector field](hyp:hLocalLip). Suppose [‖ρ(g)‖ ≤ 1 for every real n × p matrix g](hyp:hBound), and [the derivative energy D = 𝔼(∑ᵢ₌₁ⁿ ∑ⱼ₌₁ᵖ ‖∂ρ/∂gᵢⱼ‖²) is finite](hyp:hEnergy), where the norm is Euclidean and all fields and almost-everywhere derivatives inside expectations are evaluated at G. Writing eⱼ for the jth coordinate vector in ℝᵖ, [𝔼|p‖ρ‖² − ∑ⱼ₌₁ᵖ (ρᵀGeⱼ − ∑ᵢ₌₁ⁿ ∂ρᵢ/∂gᵢⱼ)²| ≤ C√p√(1 + D) + CD for a single absolute constant C > 0 that works for every n, p and such field ρ](goal).

**In the paper.** The paper applies this result conditionally to smooth bounded fields and weakens √(1 + D) to 1 + √D; it also applies the result with the matrix dimensions transposed.

**Why it is reusable.** No recurrence is recorded; offered on judgement for estimating residual energies and squared errors when coefficients depend on Gaussian data. Proving the dimension-uniform second-order bound and its locally Lipschitz extension is substantial work beyond the supplied library hits.

**In your other papers.** first time — no other paper of yours states it.

**Closest existing results.**
  - Gives a Gaussian norm distribution, without a data-dependent vector field, divergence corrections or a derivative-energy error bound. (Causalean: Causalean.Mathlib.stdGaussian_map_normSq_eq_pi)
  - Controls tail probabilities through sub-exponential norms; it does not establish this absolute-mean approximation for Gaussian divergences. (StatLean: StatLean.ConcentrationInequalities.measure_sum_ge_le_of_subExponentialNorm_le)

**If accepted.** It is built in your toolkit from scratch (stated as above, proved and reviewed); the paper then uses it instead of assuming it.

**Independent check.** agrees — Matches equation (C.6), preserving the bounded-field assumption, √(1 + D) term and absolute constant. No supplied declaration duplicates it. This specialized second-order estimate fits Tricks and the proposed GaussianStein module.

<details><summary>Lean details</summary>

- Name in the toolkit: `Toolkit.Tricks.Probability.Moments.gaussian_bounded_field_divergence_sq_error_le` in `Toolkit/Tricks/Probability/Moments/GaussianStein.lean` (Tricks) — a new module: Gaussian integration-by-parts bounds for data-dependent quadratic forms and vector-field divergences.
- Cited by the paper as `lem:one-vector-second-order-cited` (Pierre~C. Bellec and Yiwei Shen. \newblock Derivatives and residual distribution of regularized {$M$}-estimators with application to adaptive tuning. \newblock In \emph{Proceedings of the 35th Conference on Learning Theory}, volume 178 of \emph{Proceedings of Machine Learning Research}, pages 1912--1947. PMLR, 2022. \newblock URL \url{https://proceedings.mlr.press/v178/bellec22a.html}., Proposition 16); assumed until built

</details>

```decision
decision: accept
```
