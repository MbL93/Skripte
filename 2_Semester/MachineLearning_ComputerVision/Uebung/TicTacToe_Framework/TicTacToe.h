#pragma once

#ifndef TICTACTOE_H
#define TICTACTOE_H
#endif TICTACTOE_H

#include <cstdio>
#include <cstdlib>

/*!
Three possible states of each field on the playfield.
*/
enum PlayFieldState { empty=' ', circle='O', cross='X' };

//! Represents the TicTacToe play field
/*!
This class represents the TicTacToe playfield with three rows and three
columns. Each field is represented through its row and column.
*/
class TicTacToePlayField
{
private:
	const int		ncol;		//!< The number of columns
	const int		nrow;		//!< The number of rows
	PlayFieldState*	data;		//!< The state of each field (size: ncol*nrow)

public:
	//! Default constructor.
	/*!
	The default constructor initializes all member variables and sets every
	field state to empty.
	*/
	TicTacToePlayField() : ncol(3), nrow(3), data(new PlayFieldState[nrow*ncol])
	{
		for(int i=0; i<ncol*nrow; i++)
			data[i]=empty;
	}

	//! Destructor.
	~TicTacToePlayField()
	{
		delete[] data; data=0;
	}

	//! Returns the number of columns of the play field.
	int getNCol() const
	{
		return ncol;
	}

	//! Returns the number of rows of the play field.
	int getNRow() const
	{
		return nrow;
	}

	//! Returns the state of the specified field.
	/*!
	Returns the state of the field represented by row and column.
	\param row The row of the field.
	\param col The column of the field.
	\return The state of the specified field.
	*/
	PlayFieldState getVal(int row, int col) const
	{
		return data[row*ncol + col];
	}

	//! Sets the state of the specified field.
	/*!
	Sets the state of the field represented by row and column according to the
	specified state.
	\param row The row of the field.
	\param col The column of the field.
	\param state The state of the specified field.
	\return True if the field was empty and its value was set to the specified
	state. False otherwise.
	*/
	bool setVal(int row, int col, PlayFieldState state)
	{
		if (getVal(row, col) != empty) // Field not empty
			return false;

		data[row*ncol + col] = state;
		return true;
	}

	//! Clears the play field.
	/*!
	Clears the play field i.e. sets every field to state empty.
	*/
	void clearField()
	{
		for(int i=0; i<nrow; i++)
			for(int j=0; j<ncol; j++)
				data[i*ncol + j] = empty;
	}

	//! Checks whether or not the play field is empty.
	/*!
	Checks every field whether or not it is empty.
	\return True if all fields are empty. False otherwise.
	*/
	bool emptyGame()
	{
		/*PlayFieldState state1;
		for(int i=0; i < 3; i++)
		for(int j=0; j < 3; j++)
		if(state1 != empty)return false;
		return true;*/

		//-----------------------------------------------------------
		// @Simon:
		// Changed:
		//	(1) The states of the fields (i,j) were not retrieved.
		// Author: Thomas Greif
		//-----------------------------------------------------------

		for(int i=0; i<nrow; i++)
			for(int j=0; j<ncol; j++)
				if(getVal(i,j) != empty)
					return false;

		return true;
	}

	//! Determines whether or not the game has ended.
	/*!
	According to the state of each field determines whether or not the game has
	ended i.e. one player won the game or it ended in a draw.

	NOTE: THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\return True if and only if one player has won the game or it has ended
	in a draw. False otherwise.
	*/
	bool gameFinished()
	{
		PlayFieldState state1;
		PlayFieldState state2;
		PlayFieldState state3;

		// Check for three in a row
		for(int i=0; i<nrow; i++)
		{
			state1 = getVal(i,0);
			state2 = getVal(i,1);
			state3 = getVal(i,2);
			if(state1 == state2 && state1 != empty && state2 == state3)
				return true;
		}

		// Check for three in a column
		for(int i=0; i<ncol; i++)
		{
			state1 = getVal(0,i);
			state2 = getVal(1,i);
			state3 = getVal(2,i);
			if(state1 == state2 && state1 != empty && state2 == state3)
				return true;
		}

		// Check for three in a diagonal
		state1 = getVal(0,0);
		state2 = getVal(1,1);
		state3 = getVal(2,2);
		if(state1 == state2 && state1 != empty && state2 == state3)
			return true;

		state1 = getVal(0,2);
		state3 = getVal(2,0);
		if(state1 == state2 && state1 != empty && state2 == state3)
			return true;

		// Check for a draw
		for(int j=0; j<ncol; j++)
		{
			for(int i=0; i<nrow; i++)
			{
				state1 = getVal(i,j);
				if(state1 == empty) // Empty field exists, no draw
					return false;
			}
		}

		return true;
	}
};

//! Displays the specified play field in text mode.
/*
Displays the state of the specified playfield in text modus.
\param playField The play field to display.
*/
void showPlayField ( const TicTacToePlayField& playField );

//! Prototype class for a TicTacToe player.
/*!
This class represents the prototype of a TicTacToe player. Every derived
class has to implement learn() and makeMove().
*/
class TicTacToePlayer {
private:
	PlayFieldState color;	//!< The color of the player (i.e. circle or cross).

public:

	//! Default constructor.
	TicTacToePlayer() {}

	//! Sets the color of the player.
	/*!
	Sets the player's color to the specified one.
	\param _color The color of the player.
	*/
	void setColor(PlayFieldState _color)
	{
		color =_color;
	}

	//! Gets the color of the player.
	/*!
	Returns the player's color.
	\return The color of the player.
	*/
	PlayFieldState getColor () const
	{
		return color;
	}

	//! Learns by playing games against itself.
	/*!
	Learns the weights of the features by playing games against itself.
	NOTE: Every derived class has to implement this method.

	THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\param noOfGamesToPlay The number of games to play against itself.
	*/
	virtual void learn(int noOfGamesToPlay)
	{
		printf("ERROR: TicTacToePlayer::learn not implemented\n");
	};

	//! Performs the best possible move on the play field.
	/*!
	Chooses the best move out of all possible moves and performs it by setting
	the state of the desired field to the corresponding color.
	NOTE: Every derived class has to implement this method.

	THIS METHOD HAS TO BE IMPLEMENTED BY YOU

	\param playField The playfield on which to perform the move.
	\sa TicTacToePlayField::setVal()
	*/
	virtual void makeMove (TicTacToePlayField& playField)
	{
		printf("ERROR: TicTacToePlayer::makeMove not implemented\n");
	};
};
