-- =========================================================================
-- FieldPositionsCheck.hs - STANDALONE LOCAL FIELD LAW VERIFIER
-- Executes branchless algebraic law assertions over the coordinate surface.
-- =========================================================================

module Main where

import Control.Monad (unless)
import Data.Bits ((.&.))
import System.Exit (exitFailure, exitSuccess)

import FieldPositions

-- Law 1: Involutive Antipodal Mirror (a . a == id)
checkAntipodalInvolutive :: Bool
checkAntipodalInvolutive =
  all
    ( \w ->
        let pos = BytePlanePosition w
         in getBytePos (antipodalOrientationMirror (antipodalOrientationMirror pos)) == w
    )
    [0x00 .. 0xFF]

-- Law 2: 32-Position Chart Edge Case Extractions
checkChartExtractions :: Bool
checkChartExtractions =
  let c00 = extractChart32 (BytePlanePosition 0x00)
      c1F = extractChart32 (BytePlanePosition 0x1F)
      c20 = extractChart32 (BytePlanePosition 0x20)
      cFF = extractChart32 (BytePlanePosition 0xFF)
   in chartIndex c00 == 0 && chartPosition c00 == 0
        && chartIndex c1F == 0 && chartPosition c1F == 31
        && chartIndex c20 == 1 && chartPosition c20 == 0
        && chartIndex cFF == 7 && chartPosition cFF == 31

-- Law 3: Local/Remote Plane Discreteness and Boundaries
checkLocalRemotePlanes :: Bool
checkLocalRemotePlanes =
  localRemotePlane (BytePlanePosition 0x7F) == LocalPlane
    && localRemotePlane (BytePlanePosition 0x80) == RemotePlane

-- Law 4: Transition Determinism and 16-bit Footprint Squeezing
checkTransformInvariants :: Bool
checkTransformInvariants =
  let initialContext = TangentialBlackboardContext 0x1337133713371337 0x0000
      token = 0xDEADBEEFDEADBEEF
      (ctx1, coord1) = evaluateTangentialBlockField initialContext token
      (ctx2, coord2) = evaluateTangentialBlockField initialContext token
      isDeterministic =
        coord1 == coord2
          && activeFieldAxis ctx1 == activeFieldAxis ctx2
      isMaskedWord =
        currentWordContext ctx1 == (coord1 .&. 0xFFFF)
   in isDeterministic && isMaskedWord

main :: IO ()
main = do
  putStrLn "Executing Local Field Positions Invariant Scan..."
  let assertions =
        [ (checkAntipodalInvolutive, "Involutive Antipodal Mirror (a . a == id)")
        , (checkChartExtractions, "Finite Product 32-Position Chart Extraction Boundary")
        , (checkLocalRemotePlanes, "Discrete Plane Separation Boundaries")
        , (checkTransformInvariants, "Single-Cycle O(1) Torque Step Determinism & Masking")
        ]

  mapM_
    ( \(passed, label) ->
        if passed
          then putStrLn $ "  [PASS] " ++ label
          else putStrLn $ "  [FAIL] " ++ label
    )
    assertions

  unless (all fst assertions) $ do
    putStrLn "ERROR: Field law assertion mismatch detected."
    exitFailure

  putStrLn "All local field laws verified successfully."
  exitSuccess
