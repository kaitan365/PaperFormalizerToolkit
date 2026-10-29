# randomsketch — formalization note (bridge; rendered from core + plan)

_Auto-generated from the typed core + F1 plan. The structural source of truth is the formalization graph; this note is the human-readable bridge._

## Environment (S)

**S-1 (A probability space carrying observations…).** A probability space carrying observations \(y_i=x_i^\top\beta^*+\varepsilon_i\), an independent full-row-rank sketch \(S\in\mathbb R^{m\times n}\), and an independent test observation. The dimensions, covariance and coefficient are deterministic. The prediction risk integrates the test observation for the realized fitted coefficient. In the Gaussian setting, the coefficient may be any measurable function of \((SX,Sy,S)\). — Measure type signature verified by lean_hover_info at Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean:77. Reuse a standard Borel coordinate space and probability measure; all stochastic restrictions are exactly the named core atoms, never fields assuming conclusions. Matrix indices are Fin; vector coordinates are Fin p -> real, interpreted in EuclideanSpace via WithLp.toLp 2 for every norm/inner product. Operator norms always use Matrix.toEuclideanCLM, never the default matrix sup norm. Causalean/StatLean linear-model structures lack the random independent sketch and both noise regimes, so use their primitives. All generated files: optional copyright, module, contiguous public import, module docstring, exactly one @[expose] public section if any data declaration (assumption Prop defs included), otherwise public section. Declarations bare; no import all. Helpers.lean and run barrels are public-import-only. Def bodies needed downstream must remain exposed. No kernel certificate via well-founded recursion. Source roots: Causalean=.lake/packages/Causalean; StatLean=/Users/kaitan9/PaperFormalizer/third_party/StatLean; Mathlib=.lake/packages/mathlib. Basic.lean holds shared model and scalar definitions; split helpers by the subsystems below, projected <=600 lines each, splitting only independent chains before ~900.
**required modules.** Mathlib.MeasureTheory.Measure.MeasureSpaceDef, Mathlib.Analysis.InnerProductSpace.PiL2, Mathlib.Probability.Distributions.Gaussian.Multivariate, Causalean.Mathlib.Probability.Independence.Pair, Causalean.Mathlib.LinearAlgebra.NormalEquations, Mathlib.Probability.Kernel.Condexp

**S-2 (The balanced Gaussian-design setting \(X=Z\Sigma^{1/2}\)…).** The balanced Gaussian-design setting \(X=Z\Sigma^{1/2}\) with independent standard Gaussian entries of \(Z\), independent of \((S,\varepsilon)\), and centered iid sub-Gaussian structural errors. The trace-normalized representative satisfies \(\operatorname{tr}(A)=n\); its positive eigenvalues have fixed positive bounds and eventually \(m-d\geq\kappa n\). Design derivatives hold \((S,\Sigma,\beta^*,\varepsilon)\) fixed. — Search: rg -ni 'iid|covariance|IndepFun|rank' Causalean.Stat.GaussianCovariance, Causalean.Mathlib.Probability.Independence.Pair, StatLean.PointEstimation.LinearModel.RandomDesign, StatLean.HighDimensionalStatistics.LinearModel.Defs + Toolkit/{Foundations,Tricks} (empty); lean_leansearch('Independent Gaussian coordinates covariance eigenvalue positive definite matrix') => Matrix.PosDef / covariance primitives; no combined random-sketch model. Local object: BalancedCoordinates, a deterministic view of S1 constructed by normalizedSketch and the whitened/ridge definitions, with named atom hypotheses kept separate. No new statistical assumptions or theorem-valued fields. Realize subGaussianNorm with StatLean's exact threshold-2 Luxemburg convention; do not substitute an MGF bound without proving the bridge. The corrected-accuracy theorem starts at natural scale and must prove rescaling invariance. All constants and dimension-gap bounds are uniform over n and the sketch; fix moment order before choosing n0. The spectral decomposition's measurable selection and weak-derivative/ridge limit are local proof work, not new ambient premises.
**required modules.** Mathlib.Probability.Distributions.Gaussian.Multivariate, StatLean.ConcentrationInequalities.Orlicz.Defs, Mathlib.Analysis.Matrix.Order, Mathlib.Analysis.Calculus.FDeriv.Mul, Mathlib.LinearAlgebra.Matrix.Trace

**S-3 (A sequence of Gaussian observation experiments with integ…).** A sequence of Gaussian observation experiments with integer dimensions \(1\leq d_n<m_n\leq n\) and \((d_n/n,m_n/n)\to(\gamma,\rho)\), where \(0<\gamma<\rho\leq1\). Sketches are either scaled orthogonal or have independent \(N(0,1/m_n)\) entries, independently of the data. Finite MSE comparisons use \(d_n+3<m_n<n\), \(\sigma^2>0\), and natural sketch scale. The local crossover extends the finite formulas to real \(m=n\rho\). — Reuse n-indexed probability measures on dimension-dependent coordinate spaces; Measure signature verified by hover. No common coupling across n is required: convergence in probability is the limit of each experiment's deviation probabilities. Define the finite formula functions also for real m when constructing rhoSharp; actual sketches always have integer m. k=m-d and q=n-m here; complementary-law k=n-m and moment-order k have independent binders. SO and Gaussian hypotheses occur in separate implications, never a conjunction imposed on one sketch. The dense Gaussian proof's U,K,B,T are locally rebound thin-polar, rectangular map and chi-square variables; marginal representations do not assert joint equality. Define the displayed limiting risks and GCV gaps as scalar functions, not free target values.
**required modules.** Mathlib.MeasureTheory.Measure.MeasureSpaceDef, Mathlib.Probability.Distributions.Gaussian.Multivariate, Mathlib.MeasureTheory.Function.ConvergenceInMeasure, Mathlib.Analysis.Calculus.ImplicitContDiff

**S-4 (Finite-dimensional real random vector and matrix fields \…).** Finite-dimensional real random vector and matrix fields \(q\in\mathbb R^d\), \(r\in\mathbb R^n\), \(K\in\mathbb R^{d\times d}\), \(L\in\mathbb R^{n\times d}\) under an arbitrary probability law, with the stated almost-sure derivative identity. The influence vectors are \(\ell=Lq\) and \(v=Zq-tr\); no Gaussian or least-squares law is needed for their direct mixed-moment inequalities. — Measure signature verified by hover. Generic field binders are distinct from the regression specialization; do not impose normal equations or identify K with a Gram inverse. Frobenius squared norm is the explicit sum of squared entries, and the operator norm is the Euclidean CLM norm. Nonnegative expectations without an established finite moment use ENNReal lintegrals, including the generic derivative-energy and influence comparisons; finite hypotheses yield real integrals afterward. Conditional refinements remain implications in their own clauses, preserving the unconditional general inequalities. Source analogy: Mathlib/Analysis/InnerProductSpace/Basic.lean:norm_add_sq and Bochner/Basic.lean:integral_mul_norm_le_Lp_mul_Lq.
**required modules.** Mathlib.MeasureTheory.Measure.MeasureSpaceDef, Mathlib.Analysis.InnerProductSpace.PiL2, Mathlib.Analysis.Matrix.Normed, Mathlib.MeasureTheory.Integral.Bochner.Basic

**S-5 (An iid standard Gaussian design matrix \(Z\) independent…).** An iid standard Gaussian design matrix \(Z\) independent of a conditioning sigma-field \(\mathcal F\). Conditional on that information, the fields \(f:\mathbb R^{n\times d}\to\mathbb R^d\) and \(\psi:\mathbb R^{n\times d}\to\mathbb R^n\) are smooth, with the specified normalized derivative integrability. Ratios are zero at zero energy. The Stein-remainder setting takes \(\mathcal F=\sigma(S,\varepsilon)\) and a general coefficient field. — stdGaussian signature verified by hover at Mathlib/Probability/Distributions/Gaussian/Multivariate.lean:66; use the Euclidean coordinate space indexed by Fin n x Fin d. Gaussian integration uses the design fiber with conditioning information fixed, not a joint derivative. Conditional nonnegative energy is a kernel lintegral (possibly infinite); ordinary condExp alone is unsuitable since it returns zero on nonintegrable inputs. finiteness of the core normalized integral justifies the finite conversions. u is the generic bounded smooth field only in the one-vector cited gate; it is not the regression residual. All three cited inequalities have logical carriers Sort 0. Local paired-field normalization, transpose, cutoff and limit arguments are paper proofs; gates assert only their source inequalities.
**required modules.** Mathlib.Probability.Distributions.Gaussian.Multivariate, Mathlib.Analysis.InnerProductSpace.PiL2, Mathlib.Probability.Kernel.Condexp, Mathlib.Analysis.Calculus.FDeriv.Mul

**S-6 (The auxiliary response experiment preserves the joint mar…).** The auxiliary response experiment preserves the joint marginal law of \((X,S)\), sets \(\beta^*=0\), and uses independent standard Gaussian noise in \(\mathbb R^n\). Every response-dependent fit, error, residual and trace-calibration quantity is recomputed. The design-only quantities \(b\) and \(t_\Sigma\) retain their original values. — Search: rg -ni 'condExp|comap|conditional|map_pair' Causalean.Mathlib.Probability.Independence.Pair, Causalean.Mathlib.Probability.Independence.Conditional.ShiftedBlockCrossMoment, StatLean.PointEstimation.LinearModel.RandomDesign, StatLean.ComputationalStatistics.Partitioning.Holdout + Toolkit/{Foundations,Tricks} (empty); lean_leansearch('generate sigma algebra by random variable comap measurable') => MeasurableSpace.comap_eq_generateFrom; paper conditioning maps need composition. Local object: auxiliaryResponseLaw = original (X,S) marginal product stdGaussian(EuclideanSpace real (Fin n)). Use a response-parameterized deterministic fit bundle for both laws; do not reuse a random variable fitted under the original response. EStar is a choice between these two explicit measures, never an arbitrary expectation oracle. Prove auxiliary G>0 a.s., equality of design marginals, and equality of design-only b,t locally. C_Q,C_QB are whole-sequence witnesses of eventual bounds proved by balancedTraceSteinBounds, not new assumptions or n-dependent chosen bounds. Layout: TraceFields -> AuxiliaryResponse -> TraceBoundsData; the constants definition never supplies its existence proof.
**required modules.** Mathlib.MeasureTheory.Measure.MeasureSpaceDef, Mathlib.Probability.Distributions.Gaussian.Multivariate, Mathlib.MeasureTheory.Measure.Prod, Mathlib.MeasureTheory.Integral.Bochner.Basic

**S-7 (For distinct rows \(i,k\) of an iid standard Gaussian mat…).** For distinct rows \(i,k\) of an iid standard Gaussian matrix, condition on all remaining rows together with \((S,\varepsilon)\). The two remaining rows are independent standard Gaussian vectors. The row-conditional means \(a_i\), centered quantities \(\eta_i,\chi_i\), and cross-row Jacobians are computed in that experiment; the weights \(b_{ik}=\mathbb E[\|D_k a_i\|_F^2\|a_i\|^2]\) average the original law. — Search: rg -ni 'condExp|comap|conditional|map_pair' Causalean.Mathlib.Probability.Independence.Pair, Causalean.Mathlib.Probability.Independence.Conditional.ShiftedBlockCrossMoment, StatLean.PointEstimation.LinearModel.RandomDesign, StatLean.ComputationalStatistics.Partitioning.Holdout + Toolkit/{Foundations,Tricks} (empty); lean_leansearch('generate sigma algebra by random variable comap measurable') => MeasurableSpace.comap_eq_generateFrom; paper conditioning maps need composition. Local object: rowConditioning, constructed from coordinate deletion/comap and Gaussian product integration. E_i integrates one row only and a_i does not depend on that row. Prove weak differentiation through row integration under the stated finite moments; D_i a_i=0 and b_ii=0 are derived facts. Apply the cited covariance inequality conditionally and perform the outer Holder/Jensen steps in the consumer; do not add these bridges to the bibliographic premise. No extra error law. Every symbol's scoped rebinding is implemented with separate local parameters, including row k versus dimension difference or moment order.
**required modules.** Mathlib.Probability.Distributions.Gaussian.Multivariate, Causalean.Mathlib.Probability.Independence.Pair, Mathlib.Probability.Kernel.Condexp, Mathlib.Analysis.Calculus.FDeriv.Mul

## Assumptions (A)

**A-1 (assumption).** The feature vectors are independent and identically distributed, with mean zero and covariance $\bSigma$, whose eigenvalues lie between fixed positive constants.

**A-2 (assumption).** The errors are independent and identically distributed, independent of the features, with mean zero and variance $\sigma^2$.

**A-3 (assumption).** A sketch $\bS\in\R^{m\times n}$, $1\leq m\leq n$, is independent of the data and has full row rank almost surely.

**A-4 (assumption).** Let $(\bx_{\rm new},y_{\rm new})$ be an independent observation from the same model.

**A-5 (assumption).** We assume $\rank(\bS\bX)=d$

**A-6 (assumption).** $\bS\bS^\top=c_n\bI_m$ for $c_n>0$;

**A-7 (assumption).** We compare scaled orthogonal sketches with dense Gaussian sketches, whose independent entries satisfy $S_{ki}\sim\calN(0,1/m)$.

**A-8 (assumption).** In the \emph{noninterpolating proportional regime}, $(\gamma_n,\rho_n):=(d/n,m/n)\to(\gamma,\rho)$ with $0<\gamma<\rho\leq1$.

**A-9 (assumption).** We use the notation and derivative convention of Section~\ref{app:balanced-transfer-setup} on the domain where $\widetilde{\bM}$ is invertible;

**A-10 (assumption).** \label{assu:model-sketch} The observations, covariance bounds, errors, sketch and independent test pair satisfy the model conditions of Section~\ref{sec:meth}.

**A-11 (assumption).** Write $0<c_{\bSigma}\leq C_{\bSigma}<\infty$ for the fixed constants, independent of $n$, satisfying $c_{\bSigma}\bI_d\preceq\bSigma\preceq C_{\bSigma}\bI_d$.

**A-12 (assumption).** In addition to Assumption~\ref{assu:model-sketch}, suppose $1\leq d<m\leq n$

**A-13 (assumption).** $\rank(\bS\bX)=d$ almost surely.

**A-14 (assumption).** \label{assu:Gaussian-Stein-design} In addition to Assumption~\ref{assu:noninterpolating}, suppose $\bX=\bZ\bSigma^{1/2}$, where $\bZ$ has independent standard Gaussian entries and is independent of $(\bS,\bep)$.

**A-15 (assumption).** The errors are uniformly sub-Gaussian: there exists a constant $K_\varepsilon<\infty$, independent of $n$, such that $\sup_n\norm{\varepsilon_1}_{\psi_2}\leq K_\varepsilon$, where \begin{align*} \norm{W}_{\psi_2} :=\inf\left\{t>0:\E\exp(W^2/t^2)\leq2\right\}. \end{align*}

**A-16 (assumption).** Use the normalization $\trace(\bA)=n$

**A-17 (assumption).** There exist deterministic constants $n_0\geq1$, $0<c_-\leq c_+<\infty$, and $\kappa>0$, independent of $n$, such that, for every $n\geq n_0$, almost surely, \begin{align} c_-\bI_m\preceq\bLambda\preceq c_+\bI_m, \qquad m-d\geq\kappa n. \label{eq:balanced-sketch-conditions} \end{align}

**A-18 (assumption).** Under the model above with Gaussian data

**A-19 (assumption).** $m<n$

**A-20 (assumption).** any $\calF_{\bS}$-measurable $\hbbeta\in\R^d$

**A-21 (assumption).** Assume Gaussian design

**A-22 (assumption).** uniformly sub-Gaussian errors, meaning that their tails admit a uniform Gaussian bound.

**A-23 (assumption).** For all sufficiently large $n$, suppose almost surely that the positive eigenvalues of $n\bA/\trace(\bA)$ lie in $[c_-,c_+]$, with fixed $0<c_-\leq c_+<\infty$, and $m-d\geq\kappa n$ for a fixed $\kappa>0$.

**A-24 (assumption).** Under Gaussian data

**A-25 (assumption).** with $\sigma^2>0$

**A-26 (assumption).** Under the model of Section~\ref{sec:meth}, suppose Gaussian data,

**A-27 (assumption).** $\sigma^2>0$

**A-28 (assumption).** a scaled orthogonal sketch

**A-29 (assumption).** $1\leq d$ with $d+3<m<n$.

**A-30 (assumption).** For Gaussian data

**A-31 (assumption).** with $\sigma^2>0$

**A-32 (assumption).** a scaled orthogonal sketch

**A-33 (assumption).** $d+3<m<n$

**A-34 (assumption).** suppose $(\gamma_n,\rho_n)\to(\gamma,\rho)$ with $0<\gamma<\rho<1$.

**A-35 (assumption).** If $\gamma_n$ stays in a compact subset of $(0,1)$

**A-36 (assumption).** If the sub-Gaussian condition is expressed in the relative form $\norm{\varepsilon_1}_{\psi_2}\leq K_\varepsilon\sigma$

**A-37 (assumption).** \label{lem:derivative-energy-from-inverse-moments} Suppose that random matrices $\bK\in\R^{d\times d}$ and $\bL\in\R^{n\times d}$ and random vectors $\bq\in\R^d$ and $\br\in\R^n$ satisfy, almost everywhere, \begin{align*} \pdv{\bq}{z_{ij}} =\bK\be_jr_i-\bL^\top\be_iq_j. \end{align*}

**A-38 (assumption).** If also $\norm{\bSigma^{1/2}\bbeta^*}\leq B$

**A-39 (assumption).** \label{lem:Stein-remainders-from-moments} Suppose that $\bZ$ has i.i.d. standard Gaussian entries and is independent of $(\bS,\bep)$.

**A-40 (assumption).** Conditional on $(\bS,\bep)$, let $\bq=\bq(\bZ,\bS,\bep)$ be $C^\infty$ in $\bZ$.

**A-41 (assumption).** If, for a constant $C_1<\infty$ independent of $n$, \begin{align*} \E\left[\norm{\bep}^2 \bigl(\norm{\bq}^2+\calE_{\bq}\bigr)\right] \leq C_1n, \end{align*}

**A-42 (assumption).** Independently, if for constants $C_q,C_D<\infty$ independent of $n$, \begin{align*} \E\norm{\bq}^4\leq C_q, \qquad \E\calE_{\bq}^2\leq C_D, \end{align*}

**A-43 (assumption).** If $\bZ^\top\br=0$

**A-44 (assumption).** \label{lem:normalized-Gaussian-Stein} Let $\mathcal F$ be a sigma-field independent of $\bZ\in\R^{n\times d}$, whose entries are i.i.d. standard Gaussian.

**A-45 (assumption).** Conditional on $\mathcal F$, let $\bff=\bff(\bZ)\in\R^d$ and $\boldsymbol\psi=\boldsymbol\psi(\bZ)\in\R^n$ be $C^\infty$.

**A-46 (assumption).** Assume, almost surely, \begin{align*} \E\left[ \left(1+\frac{\norm{\bZ}_{\rm op}^2}{n}\right) \frac{\calE_{\bff,\boldsymbol\psi}} {G_{\bff,\boldsymbol\psi}} \mathrel{\Big|}\mathcal F \right]<\infty. \end{align*}

**A-47 (assumption).** For the inverse-defined field $\bq$, the direct remainder hypotheses mean the displayed moment hypotheses, with the smooth-field inequalities applied to $\bq_\eta$ before taking $\eta\downarrow0$.

**A-48 (assumption).** The identity $\pdv{\bq}{z_{ij}}=\bK\be_jr_i-\bL^\top\be_iq_j$ holds almost surely under the joint law of the random fields, for every $i=1,\ldots,n$ and $j=1,\ldots,d$.

**A-49 (assumption).** In the balanced-sketch calculations, $(\bS,\bA)$ denote the normalized quantities $(\overline{\bS},\overline{\bA})$ defined in Section~\ref{app:proof-setup}, so $\trace(\bA)=n$ almost surely.

**A-50 (assumption).** There exists a deterministic $K_\varepsilon<\infty$, independent of $n$, such that $\sup_n\norm{\varepsilon_1}_{\psi_2}\leq K_\varepsilon$, where $\norm{W}_{\psi_2}:=\inf\{t>0:\E\exp(W^2/t^2)\leq2\}$.

**A-51 (assumption).** There exists a deterministic $n_0\geq1$ such that, for every $n\geq n_0$, almost surely every positive eigenvalue of $n\bA/\trace(\bA)$ belongs to $[c_-,c_+]$ and $m-d\geq\kappa n$, with $c_-,c_+,\kappa$ deterministic and independent of $n$.

**A-52 (assumption).** For the derivative versions defining $\calE_{\bq}$, the identity $\pdv{\bq}{z_{ij}}=\bK\be_jr_i-\bL^\top\be_iq_j$ holds almost surely under the law used by $\E$, simultaneously for $1\leq i\leq n$ and $1\leq j\leq d$.

**A-53 (assumption).** The expectation in $\E[\norm{\bep}^2(\norm{\bq}^2+\calE_{\bq})]\leq C_1n$ is unconditional over the joint law of $(\bZ,\bS,\bep)$.

**A-54 (assumption).** On the almost-sure event $\rank(\bS)=m$, $(\bS\bS^\top)^{-1/2}$ denotes the unique symmetric positive definite square root of $(\bS\bS^\top)^{-1}$.

## Definitions (P)

**P-1 (For $i=1,\ldots,n$, let…).** For $i=1,\ldots,n$, let $y_i=\bx_i^\top\bbeta^*+\varepsilon_i$, with a fixed coefficient vector $\bbeta^*\in\R^d$.

**P-2 (Write $\bX=(\bx_1,\ldots,\bx_n)^\top\in\R^{n\times d}$,…).** Write $\bX=(\bx_1,\ldots,\bx_n)^\top\in\R^{n\times d}$, $\by=(y_1,\ldots,y_n)^\top$, and $\bep=(\varepsilon_1,\ldots,\varepsilon_n)^\top$.

**P-3 (\begin{align} R&:=\E[(y_{\rm new}-\bx_{\rm new}^\top\hbbe…).** \begin{align} R&:=\E[(y_{\rm new}-\bx_{\rm new}^\top\hbbeta)^2 \mid\bX,\by,\bS]\notag\\ &=\sigma^2+(\hbbeta-\bbeta^*)^\top\bSigma(\hbbeta-\bbeta^*). \label{eq:cpal-prediction-risk} \end{align}

**P-4 (We estimate this risk using the residuals on the original…).** We estimate this risk using the residuals on the original observations, $\bu=\by-\bX\hbbeta$.
**reuse.** Causalean.Mathlib.LinearAlgebra.NormalEquations.lstsqResidual

**P-5 (\begin{align} \bF&=(\bS\bS^\top)^{-1/2}\bS,\qquad \bP_{\b…).** \begin{align} \bF&=(\bS\bS^\top)^{-1/2}\bS,\qquad \bP_{\bS}=\bF^\top\bF,\qquad \bQ_{\bS}=\bI_n-\bP_{\bS}. \label{eq:cpal-observation-geometry} \end{align}

**P-6 (\begin{align*} \widehat R_c=\frac{\norm{\bQ_{\bS}\bu}^2}{…).** \begin{align*} \widehat R_c=\frac{\norm{\bQ_{\bS}\bu}^2}{n-m}. \end{align*}

**P-7 (To study this estimator, condition on…).** To study this estimator, condition on $\calF_{\bS}=\sigma(\bS\bX,\bS\by,\bS)$,

**P-8 (\begin{align*} \hbbeta_{\bS} :=\argmin_{\bbeta}\norm{\bS(…).** \begin{align*} \hbbeta_{\bS} :=\argmin_{\bbeta}\norm{\bS(\by-\bX\bbeta)}^2 =\bM^{-1}\bX^\top\bA\by,\quad \bA=\bS^\top\bS,\quad \bM=\bX^\top\bA\bX. \end{align*}

**P-9 (Let $\bu=\by-\bX\hbbeta_{\bS}$ and $\br=\bA\bu$.).** Let $\bu=\by-\bX\hbbeta_{\bS}$ and $\br=\bA\bu$.

**P-10 (\begin{align*} b_{\bA}&=\trace(\bA) -\trace(\bA\bX\bM^{-1…).** \begin{align*} b_{\bA}&=\trace(\bA) -\trace(\bA\bX\bM^{-1}\bX^\top\bA),& t_{\bSigma}&=\trace(\bSigma\bM^{-1}), \end{align*}

**P-11 (\begin{align*} \hR_u=\frac{\norm{\bu+t_{\bSigma}\br}^2}{n…).** \begin{align*} \hR_u=\frac{\norm{\bu+t_{\bSigma}\br}^2}{n}, \qquad \hR_o=\frac{\norm{\bu+(d/b_{\bA})\br}^2}{n}. \end{align*}

**P-12 (\begin{align*} \hR_{\GCV}=\frac{\norm{\bu}^2/n}{(1-d/n)^2}).** \begin{align*} \hR_{\GCV}=\frac{\norm{\bu}^2/n}{(1-d/n)^2}. \end{align*}

**P-13 (For a risk estimate $T$, define its mean squared estimati…).** For a risk estimate $T$, define its mean squared estimation error (MSE) as $\operatorname{MSE}(T)=\E[(T-R)^2]$, where the expectation averages over the training data and sketch randomness.

**P-14 (For $d+3<m<n$, set $k=m-d$ and $q=n-m$, and define \begin…).** For $d+3<m<n$, set $k=m-d$ and $q=n-m$, and define \begin{align*} e_{m,d}&:=\frac{(m-1)(m-3)}{(k-1)(k-3)}, \notag\\ a_{m,d}&:=\frac{2m^2}{k^3} +\frac{2d(m-1)}{(k-1)^2(k-3)} +\frac{d^2}{k^2(k-1)^2}. \end{align*}

**P-15 (\begin{align*} \rho_*(\gamma)=\frac{3\gamma}{1+2\gamma}).** \begin{align*} \rho_*(\gamma)=\frac{3\gamma}{1+2\gamma}. \end{align*}

**P-16 (Let $\rho_n^{\#}$ denote the local continuous solution of…).** Let $\rho_n^{\#}$ denote the local continuous solution of $\operatorname{MSE}(\hR_o)=\operatorname{MSE}(\widehat R_c)$ near $\rho_*(\gamma_n)$, using the finite-sample expressions in \eqref{eq:tight-frame-exact-mse-comparison}. The finite ratio $\rho_n=m/n$ is treated as continuous for this definition.

**P-17 (\begin{align*} \bB&:=\bS\bX, &\bM&=\bB^\top\bB, &\bh&:=\h…).** \begin{align*} \bB&:=\bS\bX, &\bM&=\bB^\top\bB, &\bh&:=\hbbeta_{\bS}-\bbeta^*. \end{align*}

**P-18 (\begin{align*} \overline{\bS} &:=\left\{\frac{n}{\trace(\…).** \begin{align*} \overline{\bS} &:=\left\{\frac{n}{\trace(\bA)}\right\}^{1/2}\bS, &\overline{\bA}&:=\overline{\bS}^{\top}\overline{\bS}. \end{align*}

**P-19 (In the balanced-sketch calculations from Section~\ref{app…).** In the balanced-sketch calculations from Section~\ref{app:balanced-transfer-setup} through Section~\ref{app:proof-trace-calibration-general}, we reuse $(\bS,\bA,b_{\bA},\br,t_{\bSigma})$ for the normalized quantities, so $\trace(\bA)=n$ almost surely.

**P-20 (Unless stated otherwise, derivatives are pathwise with re…).** Unless stated otherwise, derivatives are pathwise with respect to $\bZ$, with $\bS$, $\bSigma$, $\bbeta^*$, and the structural noise $\bep=\by-\bX\bbeta^*$ held fixed.

**P-21 (\begin{align*} b&:=b_{\bA}, & \bq&:=\bSigma^{1/2}\bh,\\ \…).** \begin{align*} b&:=b_{\bA}, & \bq&:=\bSigma^{1/2}\bh,\\ \widetilde{\bM}&:=\bZ^\top\bA\bZ, & \bL&:=\bA\bZ\widetilde{\bM}^{-1}, & \bell&:=\bL\bq,\\ \bv&:=\bZ\bq-t_{\bSigma}\br, & G_{\bSigma}&:=\norm{\bq}^2+\frac{1}{n}\norm{\br}^2 =\norm{\bSigma^{1/2}\bh}^2+\frac{1}{n}\norm{\br}^2. \end{align*}

**P-22 (\begin{align*} t_{\bSigma}=\trace(\bSigma\bM^{-1}) =\trac…).** \begin{align*} t_{\bSigma}=\trace(\bSigma\bM^{-1}) =\trace(\widetilde{\bM}^{-1}). \end{align*}

**P-23 (Also write $\bG_0:=\bU^\top\bZ\in\R^{m\times d}$, where…).** Also write $\bG_0:=\bU^\top\bZ\in\R^{m\times d}$, where $\bU$ comes from the standing spectral decomposition of $\bA$.

**P-24 (We use $[d]:=\{1,\ldots,d\}$ and let $\be_j$ denote a sta…).** We use $[d]:=\{1,\ldots,d\}$ and let $\be_j$ denote a standard basis vector, with its ambient dimension determined by context.
**reuse.** EuclideanSpace.single

**P-25 (For any weakly differentiable map…).** For any weakly differentiable map $\bff:\R^{n\times d}\to\R^p$, define its derivative energy by \begin{equation*} \calE_{\bff}:=\sum_{i=1}^n\sum_{j=1}^d \norm{\pdv{\bff}{z_{ij}}}^2. \end{equation*}

**P-26 (\begin{align*} \Xi_1 &:=\bep^\top\bZ\bq -\sum_{i=1}^n\sum…).** \begin{align*} \Xi_1 &:=\bep^\top\bZ\bq -\sum_{i=1}^n\sum_{j=1}^d \pdv{(\varepsilon_i q_j)}{z_{ij}},\\ \Xi_2 &:=n\norm{\bq}^2 -\sum_{i=1}^n\left( \bz_i^\top\bq-\sum_{j=1}^d\pdv{q_j}{z_{ij}} \right)^2. \end{align*}

**P-27 (Write $\bz_i^\top$ for the $i$th row of $\bZ$.).** Write $\bz_i^\top$ for the $i$th row of $\bZ$.

**P-28 (\begin{align*} Q_{1,\bSigma} &:= \br^\top\bX\bh +b\norm{\…).** \begin{align*} Q_{1,\bSigma} &:= \br^\top\bX\bh +b\norm{\bSigma^{1/2}\bh}^2 -t_{\bSigma}\norm{\br}^2,\\ Q_{2,\bSigma} &:= \bh^\top\bX^\top\bX\bh -t_{\bSigma}\br^\top\bX\bh -(n-d)\norm{\bSigma^{1/2}\bh}^2,\\ Q_{3,\bSigma} &:= \frac{1}{n}\br^\top\bX\bSigma^{-1}\bX^\top\br +\frac{b}{n}\bh^\top\bX^\top\br,\\ Q_{4,\bSigma} &:= \frac{d}{n}\norm{\br}^2 -\frac{1}{n}\norm{ \bSigma^{-1/2}\bX^\top\br+b\bSigma^{1/2}\bh }^2,\\ Q_{5,\bSigma} &:= n\norm{\bSigma^{1/2}\bh}^2 -\norm{\bX\bh-t_{\bSigma}\br}^2. \end{align*}

**P-29 (For trace calibration, introduce an auxiliary probability…).** For trace calibration, introduce an auxiliary probability law under which $\bbeta^*=\boldzero$ and $\bep\sim\calN(\boldzero,\bI_n)$ independently of $(\bX,\bS)$, while leaving the joint law of $(\bX,\bS)$ unchanged.

**P-30 (Write $\E_{\rm aux}$ for expectation under this law.).** Write $\E_{\rm aux}$ for expectation under this law.

**P-31 (Recompute all response-dependent quantities…).** Recompute all response-dependent quantities $(\hbbeta,\bh,\bu,\br,\bq,Q_{1,\bSigma},\ldots,Q_{5,\bSigma})$ under the auxiliary law, whereas $b$ and $t_{\bSigma}$ are unchanged.

**P-32 (\begin{align*} B_{\bA} &:=\frac{2|\bu^\top\br|}{n} +\left…).** \begin{align*} B_{\bA} &:=\frac{2|\bu^\top\br|}{n} +\left(|t_{\bSigma}|+\frac{d}{b}\right) \frac{\norm{\br}^2}{n},\\ \mathcal T_{\bA} &:=\frac{n}{b}\left\{ \left|\frac{b}{n}-t_{\bSigma}\right| \frac{|Q_{1,\bSigma}|}{G_{\bSigma}} +\sum_{k=2}^5\frac{|Q_{k,\bSigma}|}{G_{\bSigma}} \right\}. \end{align*}

**P-33 (Under the original law, every ratio in $\mathcal T_{\bA}$…).** Under the original law, every ratio in $\mathcal T_{\bA}$ is defined to be zero on $\{G_{\bSigma}=0\}$;

**P-34 (For maps $\bff:\R^{n\times d}\to\R^d$ and…).** For maps $\bff:\R^{n\times d}\to\R^d$ and $\boldsymbol\psi:\R^{n\times d}\to\R^n$, write \begin{align*} G_{\bff,\boldsymbol\psi} &:=\norm{\bff}^2+\frac{\norm{\boldsymbol\psi}^2}{n}, & \calE_{\bff,\boldsymbol\psi} &:=\calE_{\bff}+\frac1n\calE_{\boldsymbol\psi}, \end{align*}

**P-35 (\begin{align*} \Gamma_1 &:={} \boldsymbol\psi^\top\bZ\bff…).** \begin{align*} \Gamma_1 &:={} \boldsymbol\psi^\top\bZ\bff -\sum_{i=1}^n\sum_{j=1}^d \pdv{(\psi_i f_j)}{z_{ij}},\\ \Gamma_2 &:={} \norm{\bZ\bff}^2 -\sum_{i=1}^n\sum_{j=1}^d \pdv{\{f_j\be_i^\top\bZ\bff\}}{z_{ij}},\\ \Gamma_3 &:={} \frac1n\norm{\bZ^\top\boldsymbol\psi}^2 -\frac1n\sum_{i=1}^n\sum_{j=1}^d \pdv{\{\psi_i\be_j^\top\bZ^\top\boldsymbol\psi\}}{z_{ij}},\\ \Gamma_4 &:={} \frac dn\norm{\boldsymbol\psi}^2 -\frac1n\sum_{j=1}^d\left( \boldsymbol\psi^\top\bZ\be_j -\sum_{i=1}^n\pdv{\psi_i}{z_{ij}} \right)^2,\\ \Gamma_5 &:={} n\norm{\bff}^2 -\sum_{i=1}^n\left( \bff^\top\bZ^\top\be_i -\sum_{j=1}^d\pdv{f_j}{z_{ij}} \right)^2. \end{align*}

**P-36 (For a sigma-field $\mathcal F$, also write \begin{align*}…).** For a sigma-field $\mathcal F$, also write \begin{align*} \Theta_{\mathcal F} :=\E\left[ \frac{\calE_{\bff,\boldsymbol\psi}} {G_{\bff,\boldsymbol\psi}} \mathrel{\Big|}\mathcal F \right], \end{align*} where the ratio is interpreted as zero when $G_{\bff,\boldsymbol\psi}=0$.

**P-37 (\begin{align*} \Delta_1&:=-2\br^\top\bL\bq, & \Delta_2&:=…).** \begin{align*} \Delta_1&:=-2\br^\top\bL\bq, & \Delta_2&:=-\norm{\bq}^2,\\ \Delta_4&:=\norm{\bL^\top\br}^2 +2b\bq^\top\bL^\top\br, & \Delta_5&:=\norm{\bL\bq}^2+2\norm{\bq}^2 -2t_{\bSigma}\br^\top\bL\bq. \end{align*}

**P-38 (\begin{equation} \zeta_s:=\left.\Gamma_s\right|_{(\bff,\b…).** \begin{equation} \zeta_s:=\left.\Gamma_s\right|_{(\bff,\boldsymbol\psi)=(\bq,\br)}, \qquad s=1,\ldots,5. \label{eq:zeta-definitions} \end{equation}

**P-39 (For a constant $C_0>0$, define \begin{align*} \Omega_n:=\…).** For a constant $C_0>0$, define \begin{align*} \Omega_n:=\left\{ n\norm{(\bG_0^\top\bG_0)^{-1}}_{\rm op}\leq C_0,\quad \norm{\bZ}_{\rm op}\leq C_0\sqrt n,\quad \norm{\bep}\leq C_0\sqrt n \right\}. \end{align*}

**P-40 (let $\bA=\bU\bLambda\bU^\top$ be an $\bS$-measurable spec…).** let $\bA=\bU\bLambda\bU^\top$ be an $\bS$-measurable spectral decomposition, where $\bU\in\R^{n\times m}$ satisfies $\bU^\top\bU=\bI_m$ and $\bLambda$ contains the positive eigenvalues of $\bA$.

**P-41 (All ratios below are defined to be zero on…).** All ratios below are defined to be zero on $\{G_{\bff,\boldsymbol\psi}=0\}$.

**P-42 (For $\eta>0$, put \begin{align*} \bK_\eta&=(\widetilde{\b…).** For $\eta>0$, put \begin{align*} \bK_\eta&=(\widetilde{\bM}+\eta\bI_d)^{-1}, & \bq_\eta&=\bK_\eta\bZ^\top\bA\bep,\\ \bL_\eta&=\bA\bZ\bK_\eta, & \br_\eta&=\bA(\bep-\bZ\bq_\eta). \end{align*}

**P-43 (There are constants $C_Q,C_{QB}<\infty$, independent of…).** There are constants $C_Q,C_{QB}<\infty$, independent of $n$, such that \begin{align} \E_{\rm aux}[\mathcal T_{\bA}]&\leq C_Q\sqrt n, \label{eq:normalized-Q-bounds}\\ \E[B_{\bA}\mathcal T_{\bA}]&\leq C_{QB}\sqrt n, \label{eq:weighted-Q-bounds} \end{align} where the second expectation is under the original response law.

**P-44 (For the second claim, let $\E_i$ denote expectation over…).** For the second claim, let $\E_i$ denote expectation over the row $\bz_i$, conditional on $(\bZ_{-i},\bS,\bep)$, and set \begin{align*} \ba_i&:=\E_i[\bq], & \eta_i&:=\bz_i^\top(\bq-\ba_i) -\sum_{j=1}^d\pdv{q_j}{z_{ij}},\\ \chi_i&:=(\bz_i^\top\ba_i)^2-\norm{\ba_i}^2. \end{align*}

**P-45 (To verify the derivative term, let $D_k\ba_i$ be the Jaco…).** To verify the derivative term, let $D_k\ba_i$ be the Jacobian of $\ba_i$ with respect to the row $\bz_k$ and put $b_{ik}=\E[\norm{D_k\ba_i}_{\rm F}^2\norm{\ba_i}^2]$.

**P-46 (For this step, condition first on…).** For this step, condition first on $(\bZ_{-\{i,k\}},\bS,\bep)$ so that only the two Gaussian rows remain random.

## Lemmas (L)

**L-1 (\label{lem:dot-beta} Recall $\br=\bA(\bep-\bZ\bq)$).** \label{lem:dot-beta} Recall $\br=\bA(\bep-\bZ\bq)$. Then $\bZ^\top\br=0$, and \begin{align*} \pdv{\bq}{z_{ij}} &=\widetilde{\bM}^{-1}\be_jr_i-\bL^\top\be_iq_j,\\ \sum_{j=1}^d\pdv{q_j}{z_{ij}} &=t_{\bSigma}r_i-\be_i^\top\bL\bq. \end{align*}

**L-2 (\label{lem:dot-r} For every $j\in[d]$, \begin{align*} \su…).** \label{lem:dot-r} For every $j\in[d]$, \begin{align*} \sum_{i=1}^n\pdv{r_i}{z_{ij}} =-bq_j-\be_j^\top\bL^\top\br. \end{align*}

**L-3 (\label{lem:dot-rh} The first product divergence satisfies…).** \label{lem:dot-rh} The first product divergence satisfies \begin{align*} \sum_{i=1}^n\sum_{j=1}^d\pdv{r_iq_j}{z_{ij}} =-b\norm{\bq}^2+t_{\bSigma}\norm{\br}^2 -2\br^\top\bL\bq. \end{align*}

**L-4 (\label{lem:dot-hxh} The second product divergence satisfi…).** \label{lem:dot-hxh} The second product divergence satisfies \begin{align*} \sum_{i=1}^n\sum_{j=1}^d \pdv{q_j\be_i^\top\bZ\bq}{z_{ij}} =t_{\bSigma}\br^\top\bZ\bq+(n-d-1)\norm{\bq}^2. \end{align*}

**L-5 (\label{lem:dot-rxr} The normal equations imply \begin{ali…).** \label{lem:dot-rxr} The normal equations imply \begin{align*} \sum_{i=1}^n\sum_{j=1}^d \pdv{r_i\be_j^\top\bZ^\top\br}{z_{ij}}=0. \end{align*}

**L-6 (\label{lem:dot-rxxr} The residual squared-divergence iden…).** \label{lem:dot-rxxr} The residual squared-divergence identity is \begin{align*} \sum_{j=1}^d\left( \br^\top\bZ\be_j-\sum_{i=1}^n\pdv{r_i}{z_{ij}} \right)^2 =\norm{b\bq+\bL^\top\br}^2. \end{align*}

**L-7 (\label{lem:dot-hxxh} The coefficient squared-divergence i…).** \label{lem:dot-hxxh} The coefficient squared-divergence identity is \begin{align*} \sum_{i=1}^n\left( \bq^\top\bZ^\top\be_i-\sum_{j=1}^d\pdv{q_j}{z_{ij}} \right)^2 =\norm{\bZ\bq-t_{\bSigma}\br+\bL\bq}^2. \end{align*}

**L-8 (\label{lem:opnorm-X-bound} Suppose Assumption~\ref{assu:G…).** \label{lem:opnorm-X-bound} Suppose Assumption~\ref{assu:Gaussian-Stein-design} holds. For every fixed integer $k\geq1$, there is a constant $C_k<\infty$, independent of $n$, such that \begin{align} \E\left(\frac{\norm{\bZ}_{\rm op}}{\sqrt n}\right)^k +\E\left(\frac{\norm{\bX}_{\rm op}}{\sqrt n}\right)^k \leq C_k. \label{eq:opnorm-XZ-moments} \end{align} More precisely, for every $s\geq0$, \begin{align} \P\left\{ \frac{\norm{\bX}_{\rm op}}{\sqrt n} >\sqrt{C_{\bSigma}}(16+s) \right\} \leq e^{-ns^2/16}. \label{eq:opnorm-X-tail} \end{align} For every fixed integer $k\geq1$, the error-energy bounds are \begin{align} \E\left(\frac{\norm{\bep}^2}{n}\right)^k &\leq C_k, & \E\left|\norm{\bep}^2-n\sigma^2\right|^k &\leq C_kn^{k/2}. \label{eq:noise-energy-moments} \end{align} If the sub-Gaussian condition is expressed in the relative form $\norm{\varepsilon_1}_{\psi_2}\leq K_\varepsilon\sigma$, the first bound in \eqref{eq:noise-energy-moments} becomes $\E(\norm{\bep}^2/n)^k\leq C(k,K_\varepsilon)(\sigma^2)^k$. Moreover, there are constants $c,C>0$, independent of $n$, such that \begin{align} \P\left( \norm{\bZ}_{\rm op}>C\sqrt n \ \text{or}\ \norm{\bX}_{\rm op}>C\sqrt n \ \text{or}\ \norm{\bep}>C\sqrt n \right) \leq Ce^{-cn}. \label{eq:design-noise-tail} \end{align} The constants in the design bounds depend only on the fixed moment order and $C_{\bSigma}$; the noise bounds may additionally depend on $K_\varepsilon$ and $\sigma^2$. All these bounds also hold conditionally on the independent sketch $\bS$. [Hypotheses: ass:opnorm-x-bound-relative-tail]

**L-9 (\label{lem:M-inverse-bound} Suppose Assumption~\ref{assu:…).** \label{lem:M-inverse-bound} Suppose Assumption~\ref{assu:Gaussian-Stein-design} holds, and use the trace-normalized representative and spectral decomposition from Assumption~\ref{assu:Gaussian-Stein-design}, together with the standing notation above. For every fixed integer $k\geq1$, there are $n_0(k,\kappa)\geq1$ and $C_k<\infty$, independent of $n$ and uniform over all sketch matrices satisfying \eqref{eq:balanced-sketch-conditions}, such that, for $n\geq n_0(k,\kappa)$, \begin{align} \E\left[\norm{\bM^{-1}}_{\rm op}^k\mid\bS\right] &\leq \frac{C_k}{n^k}, & \E\left[\norm{\bM^{-1}\bX^\top\bA}_{\rm op}^k\mid\bS\right] &\leq \frac{C_k}{n^{k/2}}. \label{eq:M-inverse-moments} \end{align} Moreover, \begin{align} \norm{\bM^{-1}\bX^\top\bA\bX}_{\rm op} =\norm{\bI_d}_{\rm op}=1 \qquad\text{almost surely}, \label{eq:M-inverse-normal-equation} \end{align} and the corresponding whitened envelope is \begin{align} \E\left[ \left(n\norm{\widetilde{\bM}^{-1}}_{\rm op}\right)^k +\left(\sqrt n\norm{\bL}_{\rm op}\right)^k +t_{\bSigma}^k +\left\{\trace(\bM^{-1})\right\}^k \mathrel{\Big|}\bS \right] \leq C_k. \label{eq:M-inverse-whitened-envelope} \end{align} The same inequalities hold for unconditional expectations. Their constants depend only on $k$, the fixed constants in \eqref{eq:balanced-sketch-conditions}, and the covariance bounds; in particular, they do not depend on the value of $\bS$.

**L-10 (\label{lem:derivative-energy-from-inverse-moments} Suppos…).** \label{lem:derivative-energy-from-inverse-moments} Suppose that random matrices $\bK\in\R^{d\times d}$ and $\bL\in\R^{n\times d}$ and random vectors $\bq\in\R^d$ and $\br\in\R^n$ satisfy, almost everywhere, \begin{align*} \pdv{\bq}{z_{ij}} =\bK\be_jr_i-\bL^\top\be_iq_j. \end{align*} Then \begin{align*} \calE_{\bq} &\leq2\norm{\bK}_{\rm F}^2\norm{\br}^2 +2\norm{\bL}_{\rm F}^2\norm{\bq}^2,\\ \E\calE_{\bq}^2 &\leq8\E\left[\norm{\bK}_{\rm F}^4\norm{\br}^4\right] +8\E\left[\norm{\bL}_{\rm F}^4\norm{\bq}^4\right]. \end{align*} Consequently, boundedness of the two mixed moments on the right is sufficient for $\E\calE_{\bq}^2=O(1)$. [Hypotheses: ass:derivative-energy-from-inverse-moments]

**L-11 (\label{lem:balanced-Stein-sufficient-conditions} Suppose…).** \label{lem:balanced-Stein-sufficient-conditions} Suppose Assumption~\ref{assu:Gaussian-Stein-design} holds, using the trace-normalized representative. Then there are $n_0\geq1$ and $C<\infty$, independent of $n$, such that, for $n\geq n_0$, the map $\bq$ is weakly differentiable and \begin{align} \E\norm{\bq}^{8} +n^{-4}\E\norm{\br}^{8} +\E\calE_{\bq}^{2} &\leq C,\notag\\ \E\left[ \norm{\bep}^{2} \bigl(\norm{\bq}^{2}+\calE_{\bq}\bigr) \right] &\leq Cn,\notag\\ \E\left[ \norm{\bL}_{\rm op}^{2}\norm{\bq}^{2} \right] &\leq \frac{C}{n},\notag\\ \E\left[ \norm{\bZ}_{\rm op}^{2}\norm{\bq}^{2} +t_{\bSigma}^{2}\norm{\br}^{2} \right] &\leq Cn. \label{eq:balanced-Stein-sufficient-conditions} \end{align} In particular, Lyapunov's inequality also gives $\E\norm{\bq}^{4}\leq C$ and $\E\norm{\br}^{4}\leq Cn^2$. Thus the direct hypotheses of the remainder and influence lemmas below hold as well.

**L-12 (\label{lem:balanced-moment-bounds} Under Assumption~\ref{…).** \label{lem:balanced-moment-bounds} Under Assumption~\ref{assu:Gaussian-Stein-design}, the maps $\bq$ and $\br$ are weakly differentiable with respect to $\bZ$ for all sufficiently large $n$. For every fixed integer $k\geq1$, there are $n_0(k)\geq1$ and $C_k<\infty$, independent of $n$, such that, for $n\geq n_0(k)$, \begin{align} \E\norm{\bq}^{2k}&\leq C_k, & \E\norm{\br}^{2k}&\leq C_kn^k,\notag\\ \E\calE_{\bq}^{k}&\leq C_k, & \E\calE_{\br}^{k}&\leq C_kn^k. \label{eq:balanced-explicit-moment-bounds} \end{align} If also $\norm{\bSigma^{1/2}\bbeta^*}\leq B$, then \begin{align*} \E\norm{\bSigma^{1/2}\hbbeta}^{2k} +\E\norm{\hbbeta}^{2k} \leq C_k(B). \end{align*} Moreover, the uniform lower spectral bound in Assumption~\ref{assu:model-sketch} implies \begin{align*} \E\norm{\bh}^{2k}\leq C_k. \end{align*} [Hypotheses: ass:balanced-moment-bounds-signal]

**L-13 (\label{lem:Stein-remainders-from-moments} Suppose that…).** \label{lem:Stein-remainders-from-moments} Suppose that $\bZ$ has i.i.d. standard Gaussian entries and is independent of $(\bS,\bep)$. Conditional on $(\bS,\bep)$, let $\bq=\bq(\bZ,\bS,\bep)$ be $C^\infty$ in $\bZ$. If, for a constant $C_1<\infty$ independent of $n$, \begin{align*} \E\left[\norm{\bep}^2 \bigl(\norm{\bq}^2+\calE_{\bq}\bigr)\right] \leq C_1n, \end{align*} then \begin{align*} \E\Xi_1^2\leq C_1n. \end{align*} Independently, if for constants $C_q,C_D<\infty$ independent of $n$, \begin{align*} \E\norm{\bq}^4\leq C_q, \qquad \E\calE_{\bq}^2\leq C_D, \end{align*} then $\E|\Xi_2|\leq C(C_q,C_D)\sqrt n$. [Hypotheses: ass:stein-remainders-from-moments-gaussian, ass:stein-remainders-from-moments-smooth, ass:stein-remainders-from-moments-first, ass:stein-remainders-from-moments-second]

**L-14 (\label{lem:influence-from-moments} For the influence vect…).** \label{lem:influence-from-moments} For the influence vectors $\bell$ and $\bv$ in the standing notation, the direct bounds are \begin{align*} \E\norm{\bell}^2 &\leq\E\left[\norm{\bL}_{\rm op}^2\norm{\bq}^2\right],\\ \E\norm{\bv}^2 &\leq2\E\left[\norm{\bZ}_{\rm op}^2\norm{\bq}^2\right] +2\E\left[t_{\bSigma}^2\norm{\br}^2\right]. \end{align*} If $\bZ^\top\br=0$, the second inequality sharpens to \begin{align*} \E\norm{\bv}^2 =\E\norm{\bZ\bq}^2+\E[t_{\bSigma}^2\norm{\br}^2]. \end{align*} Thus each influence vector inherits the rate of its corresponding mixed moment. In particular, $O(1)$ and $O(n)$ mixed-moment bounds give the same respective rates for $(\bell,\bv)$; balanced sketches satisfy the stronger rate $\E\norm{\bell}^2=O(n^{-1})$. [Hypotheses: ass:influence-from-moments-orthogonality]

**L-15 (\label{lem:normalized-Gaussian-Stein} Let $\mathcal F$ be…).** \label{lem:normalized-Gaussian-Stein} Let $\mathcal F$ be a sigma-field independent of $\bZ\in\R^{n\times d}$, whose entries are i.i.d. standard Gaussian. Conditional on $\mathcal F$, let $\bff=\bff(\bZ)\in\R^d$ and $\boldsymbol\psi=\boldsymbol\psi(\bZ)\in\R^n$ be $C^\infty$. All ratios below are defined to be zero on $\{G_{\bff,\boldsymbol\psi}=0\}$. Assume, almost surely, \begin{align*} \E\left[ \left(1+\frac{\norm{\bZ}_{\rm op}^2}{n}\right) \frac{\calE_{\bff,\boldsymbol\psi}} {G_{\bff,\boldsymbol\psi}} \mathrel{\Big|}\mathcal F \right]<\infty. \end{align*} Then, for an absolute constant $C<\infty$, \begin{align} &\E\left[ \frac{\Gamma_1^2+\Gamma_2^2+\Gamma_3^2} {G_{\bff,\boldsymbol\psi}^2} \mathrel{\Big|}\mathcal F \right]\notag\\ &\qquad\leq C\E\left[ n+d+\norm{\bZ}_{\rm op}^2 +(n+d)\left(1+\frac{\norm{\bZ}_{\rm op}^2}{n}\right) \frac{\calE_{\bff,\boldsymbol\psi}} {G_{\bff,\boldsymbol\psi}} \mathrel{\Big|}\mathcal F \right]. \label{eq:conditional-normalized-first-order} \end{align} Moreover, \begin{align} \E\left[ \frac{|\Gamma_4|+|\Gamma_5|} {G_{\bff,\boldsymbol\psi}} \mathrel{\Big|}\mathcal F \right] \leq C\left\{ \sqrt{n+d}\left(1+\Theta_{\mathcal F}^{1/2}\right) +\Theta_{\mathcal F} \right\}. \label{eq:conditional-normalized-second-order} \end{align} [Hypotheses: ass:normalized-gaussian-stein-independence, ass:normalized-gaussian-stein-smooth, ass:normalized-gaussian-stein-integrability]

**L-16 (\label{lem:balanced-remainder-bounds} Under Assumption~\r…).** \label{lem:balanced-remainder-bounds} Under Assumption~\ref{assu:Gaussian-Stein-design}, for every fixed integer $k\geq1$, there are $n_0(k)\geq1$ and $C_k<\infty$ such that, for $n\geq n_0(k)$, \begin{align} \E\left( |\Delta_1|^k+|\Delta_2|^k+|\Delta_5|^k +n^{-k}|\Delta_4|^k \right)\leq C_k. \label{eq:balanced-unnormalized-remainders} \end{align} Define every normalized ratio below to be zero on $\{G_{\bSigma}=0\}$. Then the stronger response-normalized bounds \begin{align} \E\left[ \sum_{s\in\{1,2,5\}} \left|\frac{\Delta_s}{G_{\bSigma}}\right|^k +\left|\frac{\Delta_4}{nG_{\bSigma}}\right|^k \right] \leq C_k \label{eq:balanced-normalized-remainders} \end{align} hold. In particular, at $k=2$, \begin{align*} \E\left[ \sum_{s\in\{1,2,5\}} \frac{\Delta_s^2}{nG_{\bSigma}^2} +\frac{\Delta_4^2}{n^3G_{\bSigma}^2} \right]\leq\frac{C_2}{n}. \end{align*} Thus the normalized estimate also yields the displayed $O(n^{-1})$ scaled $L^2$ bound. No third remainder is needed because $Q_{3,\bSigma}=0$ by the sketched normal equations.

**L-17 (\label{lem:balanced-trace-Stein-bounds} Under Assumption~…).** \label{lem:balanced-trace-Stein-bounds} Under Assumption~\ref{assu:Gaussian-Stein-design}, there are $n_0\geq1$ and $C<\infty$, independent of $n$, such that, for $n\geq n_0$, \begin{align} \E\zeta_1^2&\leq Cn, & \E\zeta_2^2&\leq Cn, & \zeta_3&=0,\notag\\ \E|\zeta_4|&\leq C\sqrt n, & \E|\zeta_5|&\leq C\sqrt n. \label{eq:balanced-unnormalized-zeta-bounds} \end{align} Every ratio below is defined to be zero on $\{G_{\bSigma}=0\}$. Moreover, if $\E_\star$ denotes either expectation under the auxiliary response law defined above or expectation under the original response law, then \begin{align} \E_\star\left[ \frac{\zeta_1^2+\zeta_2^2} {nG_{\bSigma}^2} +\frac{|\zeta_4|+|\zeta_5|} {\sqrt n\,G_{\bSigma}} \right]\leq C. \label{eq:balanced-normalized-zeta-bounds} \end{align} The exact decompositions are \begin{align} Q_{1,\bSigma}&=\zeta_1+\Delta_1, & Q_{2,\bSigma}&=\zeta_2+\Delta_2,\notag\\ Q_{3,\bSigma}&=\zeta_3=0, & Q_{4,\bSigma}&=\zeta_4+\frac{\Delta_4}{n}, & Q_{5,\bSigma}&=\zeta_5+\Delta_5. \label{eq:balanced-Q-zeta-Delta} \end{align} Together with Lemma~\ref{lem:balanced-remainder-bounds}, these estimates imply the trace bounds \eqref{eq:normalized-Q-bounds}-- \eqref{eq:weighted-Q-bounds}.

**L-18 (\label{lem:balanced-exceptional-weight} Suppose Assumptio…).** \label{lem:balanced-exceptional-weight} Suppose Assumption~\ref{assu:Gaussian-Stein-design} holds. The constant $C_0$ can be chosen sufficiently large so that there are constants $c,C>0$, uniform over all balanced sketch matrices, such that, for all sufficiently large $n$, \begin{align} \P(\Omega_n^c\mid\bS)\leq Ce^{-cn}\quad\text{almost surely}, \qquad \P(\Omega_n^c)\leq Ce^{-cn}. \label{eq:balanced-exceptional-tail} \end{align} On the whole sample space, using the zero convention for the ratios in $\mathcal T_{\bA}$, \begin{align} \frac{B_{\bA}\mathcal T_{\bA}}{n} \leq{}&8\frac nb \left(1+\frac{\norm{\bZ}_{\rm op}^2}{n}\right) (1+t_{\bSigma})^2\notag\\ &\quad\times\left\{ \frac{2(\norm{\bep}+\norm{\bZ}_{\rm op}\norm{\bq})\norm{\br}}{n} +\left(t_{\bSigma}+\frac nb\right)\frac{\norm{\br}^2}{n} \right\}. \label{eq:balanced-explicit-BT-polynomial} \end{align} Consequently, for every fixed $N>0$, there is $C_N<\infty$ such that, for all sufficiently large $n$, \begin{align} \E\left[ B_{\bA}\mathcal T_{\bA}\boldsymbol{1}_{\Omega_n^c} \right] \leq C_Nn^{-N}. \label{eq:balanced-exceptional-BT} \end{align}

## Theorems (T)

### T-block: t1 — \label{thm:cpal-complementary-law} \label{thm:complementa…
**Statement.** \label{thm:cpal-complementary-law} \label{thm:complementary-validation} Under the model above with Gaussian data and $m<n$, any $\calF_{\bS}$-measurable $\hbbeta\in\R^d$ satisfies \begin{align} \mathcal L(\bQ_{\bS}\bu\mid\calF_{\bS}) &=\calN(\boldzero,R\bQ_{\bS}),\notag\\ \frac{(n-m)\widehat R_c}{R}\,\bigg|\,\calF_{\bS} &\sim\chi^2_{n-m}\quad\text{on }R>0. \label{eq:cpal-complementary-law} \end{align} Under this regular conditional law, $\E[\widehat R_c\mid\calF_{\bS}]=R$ and $\operatorname{Var}(\widehat R_c\mid\calF_{\bS})=2R^2/(n-m)$, without requiring unconditional moments of $R$. [Hypotheses: ass:cpal-complementary-law-model, ass:cpal-complementary-law-compression, ass:cpal-complementary-law-measurability]

### T-block: t2 — \label{thm:cpal-corrected-accuracy} \label{thm:R-obs-gene…
**Statement.** \label{thm:cpal-corrected-accuracy} \label{thm:R-obs-general} \label{thm:R-sens-general} Assume Gaussian design and uniformly sub-Gaussian errors, meaning that their tails admit a uniform Gaussian bound. For all sufficiently large $n$, suppose almost surely that the positive eigenvalues of $n\bA/\trace(\bA)$ lie in $[c_-,c_+]$, with fixed $0<c_-\leq c_+<\infty$, and $m-d\geq\kappa n$ for a fixed $\kappa>0$. Under the model conditions of Section~\ref{sec:meth}, a constant $C$ independent of $n$ satisfies \begin{align} \max\{\E|\hR_o-R|,\E|\hR_u-R|\}\leq Cn^{-1/2}. \label{eq:cpal-corrected-accuracy} \end{align} [Hypotheses: ass:cpal-corrected-accuracy-gaussian, ass:cpal-corrected-accuracy-errors, ass:cpal-corrected-accuracy-spectrum]

### T-block: t3 — \label{thm:cpal-risk-benchmarks} Under Gaussian data with…
**Statement.** \label{thm:cpal-risk-benchmarks} Under Gaussian data with $\sigma^2>0$ and this regime, $R,\hR_u,\hR_o\limp\calR_j$ and $\hR_{\GCV}-R\limp\Delta_j$, where $j$ identifies the sketch family: \begin{align} \calR_{\rm SO}&=\frac{\sigma^2\rho}{\rho-\gamma},& \Delta_{\rm SO}&= \frac{\sigma^2\gamma^2(1-\rho)} {(\rho-\gamma)(1-\gamma)^2},\notag\\ \calR_{\rm G}&=\sigma^2\left\{\frac1{1-\gamma} +\frac{\gamma}{\rho-\gamma}\right\},& \Delta_{\rm G}&=\frac{\sigma^2\gamma^2} {(1-\gamma)(\rho-\gamma)}. \label{eq:cpal-risk-benchmarks} \end{align} Here SO denotes scaled orthogonal sketches and G denotes dense Gaussian sketches with the stated entry law. [Hypotheses: ass:cpal-risk-benchmarks-gaussian, ass:cpal-risk-benchmarks-positive-noise]

### T-block: t4 — \label{thm:tight-frame-mse-comparison} Under the model of…
**Statement.** \label{thm:tight-frame-mse-comparison} Under the model of Section~\ref{sec:meth}, suppose Gaussian data, $\sigma^2>0$, a scaled orthogonal sketch, and $1\leq d$ with $d+3<m<n$. The mean squared errors are \begin{align} \operatorname{MSE}(\widehat R_c) &=\frac{2\sigma^4e_{m,d}}q, \notag\\ \operatorname{MSE}(\hR_o)&= \frac{\sigma^4}{n^2}\{2qe_{m,d}+m^2a_{m,d}\}. \label{eq:tight-frame-exact-mse-comparison} \end{align} The corrected risk estimate has smaller MSE exactly when \begin{align} q^2+\frac{m^2q\,a_{m,d}}{2e_{m,d}}<n^2. \label{eq:tight-frame-finite-mse-rule} \end{align} Reversing the inequality favors the complementary risk estimate; equality gives equal MSE. [Hypotheses: ass:tight-frame-mse-comparison-model, ass:tight-frame-mse-comparison-positive-noise, ass:tight-frame-mse-comparison-sketch, ass:tight-frame-mse-comparison-dimensions]

### T-block: t5 — \label{thm:cpal-mse-comparison} \label{thm:tight-frame-as…
**Statement.** \label{thm:cpal-mse-comparison} \label{thm:tight-frame-asymptotic-mse-threshold} For Gaussian data with $\sigma^2>0$, a scaled orthogonal sketch, and $d+3<m<n$, suppose $(\gamma_n,\rho_n)\to(\gamma,\rho)$ with $0<\gamma<\rho<1$. For sufficiently large $n$, $\widehat R_c$ has smaller MSE if $\rho<\rho_*(\gamma)$, and $\hR_o$ has smaller MSE if $\rho>\rho_*(\gamma)$. At equality, their MSE ratio tends to one. If $\gamma_n$ stays in a compact subset of $(0,1)$, the local continuous crossover exists uniquely for sufficiently large $n$ and \begin{align} \rho_n^{\#} =\rho_*(\gamma_n)-\frac{5}{12n}+O(n^{-2}). \label{eq:cpal-finite-mse-threshold} \end{align} [Hypotheses: ass:cpal-mse-comparison-model, ass:cpal-mse-comparison-positive-noise, ass:cpal-mse-comparison-sketch, ass:cpal-mse-comparison-dimensions, ass:cpal-mse-comparison-proportions, ass:cpal-mse-comparison-local]

### T-block: t6 — \label{prop:Stein-risk-from-moments} Under Assumption~\re…
**Statement.** \label{prop:Stein-risk-from-moments} Under Assumption~\ref{assu:Gaussian-Stein-design}, for all sufficiently large $n$, the map $\bq=\bq(\bZ,\bS,\bep)$ is weakly differentiable with respect to $\bZ$. There are constants $C_\Xi,C_\ell,C_v<\infty$, independent of $n$, such that, for all sufficiently large $n$, \begin{align} \E[\Xi_1^2]&\leq C_\Xi n, & \E|\Xi_2|&\leq C_\Xi\sqrt n, \label{eq:Xi-control}\\ \E\norm{\bell}^2&\leq \frac{C_\ell}{n}, & \E\norm{\bv}^2&\leq C_v n. \label{eq:influence-control} \end{align}

### T-block: t7 — A direct whitening and expansion give \begin{align} \left…
**Statement.** A direct whitening and expansion give \begin{align} \left(\frac{b}{n}-t_{\bSigma}\right)Q_{1,\bSigma} +Q_{2,\bSigma}+Q_{3,\bSigma} +Q_{4,\bSigma}+Q_{5,\bSigma} = (d-bt_{\bSigma}) \left( \norm{\bSigma^{1/2}\bh}^2 +\frac{\norm{\br}^2}{n} \right). \label{eq:Q-identity-Sigma} \end{align}

### T-block: t8 — \label{prop:trace-calibration-general} Under Assumption~\…
**Statement.** \label{prop:trace-calibration-general} Under Assumption~\ref{assu:Gaussian-Stein-design}, there is a constant $C<\infty$, independent of $n$, such that, for all sufficiently large $n$, $\E_{\bX,\bS}|t_{\bSigma}-d/b|\leq C/\sqrt n$. Here $\E_{\bX,\bS}$ is expectation under the original marginal law of $(\bX,\bS)$. In particular, $t_{\bSigma}-d/b=O_{\P}(n^{-1/2})$.
