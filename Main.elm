module Go where

import Array
import String
import Window

-- start with offline implementation where two players
-- use the same computer.
-- then online (peer-to-peer connection via webtrtc?)
-- then AI
-- unit test... https://github.com/deadfoxygrandpa/Elm-Test

type UserInput = {}

userInput : Signal UserInput
userInput = constant {}

type Input = { timeDelta:Float, userInput:UserInput }


-- we have 2 players, white and black
-- a board can be a 1D Array
-- we can store an array of boards
-- and the current player
-- that should be sufficient

-- indicate valid board sizes
boardSize = 11
data Stone = Black | White | Empty

type GameBoard = (Array.Array Stone)

type GameState = { board:GameBoard,
                   turn:Int}

GameState.asText =

defaultGame : GameState
defaultGame = { board = Array.initialize (boardSize^2) (always Empty),
                turn = 0 }

isBlackTurn game = ((game.turn) `mod` 2) == 0
isWhiteTurn game = ((game.turn) `mod` 2) == 1

-- before user places piece, validate move

-- if valid:
-- transform the board
-- given capture rules
-- then change turn

stepGame : Input -> GameState -> GameState
stepGame {timeDelta,userInput} gameState = gameState


-- can do display in layers
-- first, simple ascii display
-- with textbox for board input
-- then graphical with canvas, nice gestural mouse/touch drag input
-- that previews where your piece will be placed


display : (Int,Int) -> GameState -> Element
display (w,h) gameState = asText gameState



delta = fps 30
input = sampleOn delta (lift2 Input delta userInput)

gameState = foldp stepGame defaultGame input

main = lift2 display Window.dimensions gameState
