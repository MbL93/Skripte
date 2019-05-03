#pragma once

#ifndef TICTACTOEPLAYER_H
#define TICTACTOEPLAYER_H
#endif TICTACTOEPLAYER_H

#include <cassert>

#include "TicTacToe.h"

// TODO
// Set the dimensionality of your feature vector here!
#define NBFEATURES 7

//! Generates a random integer between an interval.
/*!
Generates a random integer number larger in the specified
interval.
\param lower The lower bound.
\param upper The upper bound.
\return The randomly generated integer number.
*/
inline int randInt(int lower, int upper)
{
	assert(lower <= upper);
	const int range=(upper-lower)+1;

	return lower + static_cast<int>(range*rand()/(RAND_MAX + 1.0));
}

//! Clones a play field
/*!
Copies the state of the specified play field to another one.
\param src The play field to copy the field states from.
\param dst the play field to copy the field states to.
*/
inline void clonePlayField(const TicTacToePlayField& src, TicTacToePlayField& dst)
{
	assert(src.getNCol() == dst.getNCol());
	assert(src.getNRow() == dst.getNRow());

	for(int r=0; r<src.getNRow(); r++)
		for(int c=0; c<src.getNRow(); c++)
			dst.setVal(r, c, src.getVal(r, c));
}

//! Returns the winner of the game.
/*!
Returns the color of the winning player (cross or circle) or
empty if the game ended in a draw.
Note: The game has to have ended before this function can be called.
\param playfield The playfield to determine the winning color for.
\return The color of the winner or empty if the game ended in a draw.
*/
inline PlayFieldState gameOutcome(TicTacToePlayField& playfield)
{
	int ncol = playfield.getNCol();
	int nrow = playfield.getNRow();

	// Check for three in a row
	for(int i=0; i<nrow; i++)
	{
		if(playfield.getVal(i,0) != empty && playfield.getVal(i,0) == playfield.getVal(i,1) && playfield.getVal(i,0) == playfield.getVal(i,2))
			return playfield.getVal(i,0);
	}

	// Check for three in a column
	for(int i=0; i<nrow; i++)
	{
		if(playfield.getVal(0,i) != empty && playfield.getVal(0,i) == playfield.getVal(1,i) && playfield.getVal(0,i) == playfield.getVal(2,i))
			return playfield.getVal(0,i);
	}

	// Check for three in a diagonal
	if(playfield.getVal(0,0) != empty && playfield.getVal(0,0) == playfield.getVal(1,1) && playfield.getVal(0,0) == playfield.getVal(2,2))
		return playfield.getVal(0,0);
	if(playfield.getVal(2,0) != empty && playfield.getVal(2,0) == playfield.getVal(1,1) && playfield.getVal(2,0) == playfield.getVal(0,2))
		return playfield.getVal(2,0);

	return empty;
}

//! This class represents a specific TicTacToe Player.
class TicTacToePlayer_Student : public TicTacToePlayer
{
private:
	float weights[NBFEATURES];	//!< The weights of the features.

	//! Computes the score of a specific board state
	/*!
	Computes the score of a board state that is given through
	its feature values. The score is a linear function of each
	feature value and its weight.
	\param features The feature values of the board state.
	\return The score of the board state.
	*/
	float evalApprox(int features[]);

	//! Gets the feature values of a board state.
	/*!
	According the the specified board state, calculates the value for each
	feature.
	\param board The board state to calculate feature values for.
	\param features The where featurevalues are stored.
	*/
	void getBoardFeatures(TicTacToePlayField& board, int features[]);

public:
	//! Default constructor.
	/*!
	Initializes the feature weights with random numbers.
	*/
	TicTacToePlayer_Student(void);

	//! Constructor.
	/*!
	Uses the specified weights to initialize the feature weights.
	\param weights The weights.
	*/
	TicTacToePlayer_Student(float* weights);

	//! Destructor.
	~TicTacToePlayer_Student(void);

	//! Learns by playing games against itself.
	/*!
	Learns the weights of the features by playing games against itself.

	NOTE: THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\param noOfGamesToPlay The number of games to play against itself.
	*/
	void learn(int noOfGamesToPlay);

	//! Performs the best possible move on the play field.
	/*!
	Chooses the best move out of all possible moves and performs it by setting
	the state of the desired field to the corresponding color.

	NOTE: THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\param playField The playfield on which to perform the move.
	\sa TicTacToePlayField::setVal()
	*/
	void makeMove(TicTacToePlayField& playField);
};

//! This class represents a specific TicTacToe Player.
class TicTacToePlayer_Random : public TicTacToePlayer
{
public:
	//! Default constructor.
	/*!
	Initializes the feature weights with random numbers.
	*/
	TicTacToePlayer_Random(void){}

	//! Destructor.
	~TicTacToePlayer_Random(void){}

	//! Learns by playing games against itself.
	/*!
	Learns the weights of the features by playing games against itself.

	NOTE: THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\param noOfGamesToPlay The number of games to play against itself.
	*/
	void learn(int noOfGamesToPlay){}

	//! Performs the best possible move on the play field.
	/*!
	Chooses the best move out of all possible moves and performs it by setting
	the state of the desired field to the corresponding color.

	NOTE: THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\param playField The playfield on which to perform the move.
	\sa TicTacToePlayField::setVal()
	*/
	void makeMove(TicTacToePlayField& board){
		
		int nbEmpty = 0;
		
		std::vector <int> x,y;

		for(int r = 0; r<board.getNRow(); r++)
			for(int c=0; c<board.getNCol(); c++)
			{
				if(board.getVal(r,c) == empty) // A possible move found
				{
					nbEmpty++;
					y.push_back(r);
					x.push_back(c);
				}
			}

			int r = randInt(0, nbEmpty-1);
			board.setVal(y[r], x[r], getColor());
	}
};
