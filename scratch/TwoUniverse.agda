{-# OPTIONS --without-K #-}
module TwoUniverse where

open import UnivalentTypeTheory
open import PropositionalTruncation


is-𝟚 = λ X → ∥ X == 𝟚 ∥

U : Type₁
U = Σ Type₀ is-𝟚

El : U → Type₀
El X = 𝟚

Ũ = Σ U El

-- Labels for some of the pertinent terms
`𝟚 : U
`𝟚 = (𝟚 , ∣ refl 𝟚 ∣)

`id : `𝟚 == `𝟚
`id = dpair= (refl 𝟚 , identify _ _)

`not : `𝟚 == `𝟚
`not = dpair= (ua not-eqv , identify _ _)

`ρ : `not ◾ `not == `id
`ρ = {!!}



module _ {ℓ : Level} {X : Type ℓ} where

  -- General lemma about identity under truncation (migrate up)
  lem1 : (P : (x : X) → Type ℓ) → ((x : X) → is-prop (P x))
         → {x x' : X} → (y : P x) → (y' : P x')
         → ∥ x == x' ∥ → ∥ (x , y) == (x' , y') ∥
  lem1 P φ {x} {x'} y y' = indTrunc _ f (λ p → identify)
    where f : x == x' → ∥ (x , y) == (x' , y') ∥
          f p = ∣ dpair= (p , φ x' (tpt P p y) y') ∣


module ZeroDimensionalTerms where

  -- TODO: generalize to any singleton subuniverse (trivial)
  sing-path-conn : (x : U) → ∥ x == `𝟚 ∥
  sing-path-conn (X , p) = lem1 is-𝟚 (λ p → identify) p ∣ refl 𝟚 ∣ p



