# Substrate requirement: Toolkit.Tricks.Probability.Moments.gaussian_cross_quadratic_covariance_bound

## Goal
Build "Gaussian covariance bound for cross-dependent quadratic forms" as a general result of the Tricks division of the toolkit.

## Provides (API contract)
- `Toolkit.Tricks.Probability.Moments.gaussian_cross_quadratic_covariance_bound` — the main declaration, placed in `Toolkit/Tricks/Probability/Moments/GaussianStein.lean` (a new module: Gaussian integration-by-parts bounds for data-dependent quadratic forms and vector-field divergences.). Its docstring opens with the statement below in plain words.
- Any definition the statement needs, in the same module, with supporting lemmas as the proof requires.

## Statement / milestones
Let n be a positive integer, [let z and w be independent standard Gaussian vectors in ℝⁿ](hyp:hGaussian), and let f,h:ℝⁿ → ℝⁿ [have weakly differentiable components](hyp:hWeakDiff). Write ∇f and ∇h for their Jacobian matrices, Iₙ for the identity matrix, tr for matrix trace, ‖·‖ for the Euclidean norm, and ‖·‖F for the Frobenius norm; define A = ((zᵀf(w))Iₙ + f(w)zᵀ)∇f(w)ᵀ and B = ((wᵀh(z))Iₙ + h(z)wᵀ)∇h(z)ᵀ. If [𝔼‖f(w)‖⁴ + 𝔼‖h(z)‖⁴ + 𝔼‖A‖F² + 𝔼‖B‖F² is finite](hyp:hMoments), then [𝔼(((zᵀf(w))² − ‖f(w)‖²)((wᵀh(z))² − ‖h(z)‖²)) = 𝔼(tr(AB)), and 𝔼|tr(AB)| ≤ 4√(𝔼(‖∇f(w)‖F²‖f(w)‖²))√(𝔼(‖∇h(z)‖F²‖h(z)‖²))](goal), where every expectation is under the joint law of z and w.

The cited work states it as follows (excerpt):

```
PRIMARY-SOURCE EVIDENCE: BELLEC (2023), LEMMA 7.1

Purpose: support the rowwise Gaussian covariance inequality cited in main.tex lines 1868–1876. No manuscript, toolkit, or verification-run record was modified.

Published citation: Pierre C. Bellec, Out-of-sample error estimation for M-estimators with convex penalty, Information and Inference 12(4):2782–2817 (2023), doi:10.1093/imaiai/iaad031.
Publisher metadata: https://academic.oup.com/imaiai/article/12/4/2782/7330496
Primary author preprint: https://arxiv.org/abs/2008.11840v5
Author PDF: https://arxiv.org/pdf/2008.11840v5
Author source: https://arxiv.org/src/2008.11840v5
Retrieved 2026-10-28 from unversioned arXiv URLs; saved metadata identifies version 5, revised 30 March 2023. The exact retrieved files are identified by SHA-256 hashes below. The publisher redirect could not be read with the web tool; the saved PDF is the author's primary preprint, not a purported publisher PDF.

Location: author PDF page 26 (PDF index 25), Lemma 7.1, equations (7.2) and (7.3). Its exact source label is lemma:f-g-z_j-z_k in bellec-2023-Out-Of-Sample-Error-estimate.tex lines 3906–3958. The equation numbering and constant 4 agree between the extracted TeX and author PDF.

ASSUMPTIONS (paraphrase)
Two independent standard Gaussian vectors z_j,z_k in R^n are given. Deterministic f,h:R^n -> R^n have weakly differentiable components. Define random matrices by the following exact mathematical source block:

    $\bA = \bigl(
            \bz_j^\top f(\bz_k) \bI_n
            + f(\bz_k)\bz_j^\top
        \bigr)
        \nabla f(\bz_k)^\top
    $ and
    $\bB =
         \bigl(
         \bz_k^\top h(\bz_j) \bI_n
        + h(\bz_j) \bz_k^\top
        \bigr)
    \nabla h(\bz_j)^\top
    $.

The sum of E||f(z_k)||^4, E||h(z_j)||^4, E||A||_F^2, and E||B||_F^2 must be finite. Verbatim mathematical statements for the conclusion:

\begin{equation}
    \label{eq:equality-correlation-lemma}
\E\big[
    \big\{(\bz_j^{\pb{\top}} f(\bz_k))^2-\|f (\bz_k)\|^2 \big\}
    \big\{(\bz_k^{\pb{\top}} h(\bz_j))^2-\|h (\bz_j)\|^2 \big\}
    \big]
    =
    \E[
    \trace
    \{
        \bA \bB
    \}
    ]
    \end{equation}
holds and
$\E|\trace[\bA\bB]| \le
        4
        \E\bigl[\|\nabla f(\bz_k)\|_F^2\|f(\bz_k)\|^2\bigr]^{\frac12}
        \E\bigl[\|\nabla h(\bz_j)\|_F^2\|h(\bz_j)\|^2\bigr]^{\frac12}
$.

APPLICATION TO THE MANUSCRIPT
1. Condition on C = sigma(Z_{-{i,k}}, S, epsilon). The two unfixed design rows z_i,z_k are independent N(0,I_d), because the design has independent standard Gaussian entries and is independent of (S,epsilon).
2. Source dimension n is manuscript dimension d. Use f(z_k)=a_i=E_i[q] and h(z_i)=a_k=E_k[q], with the remaining rows fixed by C. These fields are deterministic under C and have the orientations required by Lemma 7.1. Their derivatives are D_k a_i and D_i a_k.
3. The lemma gives, conditionally,
   |E[chi_i chi_k | C]| <= 4 sqrt(b_{ik,C} b_{ki,C}),
   where b_{ik,C}=E[||D_k a_i||_F^2 ||a_i||^2 | C].
   Integrating and applying Cauchy–Schwarz gives
   |E[chi_i chi_k]| <= 4 sqrt(b_{ik} b_{ki}),
   with b_{ik}=E[b_{ik,C}], exactly the quantity defined at main.tex lines 1865–1867. This is the displayed bound at main.tex lines 1868–1872.
4. The source's required moments are available. Conditional Jensen gives E||a_i||^4 <= E||q||^4 and
   sum_{i,k} E[||D_k a_i||_F^2 ||a_i||^2]
       <= n sqrt(E||q||^4 * E energy_q^2).
   The manuscript establishes these moment assumptions at lines 1810–1815 and uses exactly this summed bound at lines 1883–1888. The source proof also shows E||A||_F^2 <= 4 E[||D_k a_i||_F^2 ||a_i||^2], and analogously for B (author TeX lines 4012–4031), so the lemma's matrix-integrability assumptions follow. Smooth cutoffs and the manuscript's ridge-limit step justify the coefficient-field approximation and derivative/conditional-expectation interchange.
5. The source proof of Theorem 7.2 itself applies Lemma 7.1 to conditional expectation fields E_j[rho], E_k[rho] after c
[… later source text omitted …]
```

## Standard reference
Pierre C. Bellec, Out-of-sample error estimation for M-estimators with convex penalty (2023), Lemma 7.1, equations (7.2)–(7.3).

## Intended reuse
Proposed from paper randomsketch (round-A proposal a-lem-rowwise-gaussian-covariance-cited); the paper uses it instead of assuming it. No recurrence is recorded; offered on judgement as a technique for controlling dependence between Gaussian quadratic errors in risk estimation and random-design statistics. Building weak-derivative Gaussian integration by parts and its approximation arguments is substantial.

## May assume / must derive
Assume exactly the hypotheses the statement lists — none that the proof does not use; derive everything else from the base libraries and the toolkit. No new axioms, no sorry.

## Non-goals (optional)
Nothing specific to paper randomsketch: no paper notation, types, readings or special cases in the toolkit declaration.

## Known building blocks (optional)
- `Causalean.Stat.gaussian_pushforward_covariance` (Causalean): Computes covariance under a linear Gaussian transformation; it does not control quadratic forms whose coefficient fields depend on the other Gaussian vector.
- `StatLean.HypothesisTesting.map_quadraticForm_multivariateGaussian_eq_chiSquared` (StatLean): Identifies the distribution of a fixed Gaussian quadratic form; it provides neither this cross-dependent covariance identity nor its derivative bound.
