#include <ctime>
#include <cfloat>
#include <vector>
#include <utility>
#include <iostream>

#include "TicTacToePlayer.h"

using namespace std;

float TicTacToePlayer_Student::evalApprox(int features[])
{
	float val = 0.f;
	for(int i=0; i<NBFEATURES; i++)
		val += weights[i] * features[i];

	return val;
}

TicTacToePlayer_Student::TicTacToePlayer_Student(void) : TicTacToePlayer()
{
	// init weights
	for(int i = 0; i < NBFEATURES; i++)
	{
		weights[i] = randInt(1,10) * 0.1f;

		//weights[i] = 0.1f;
	}
}

TicTacToePlayer_Student::TicTacToePlayer_Student(float* weights_) : TicTacToePlayer()
{
	// Initialize the feature weights
	for(int i = 0; i < NBFEATURES; i++)
		weights[i] = weights_[i];
}

TicTacToePlayer_Student::~TicTacToePlayer_Student(void)
{
}

// TODO
// Implement the following three functions
void TicTacToePlayer_Student::learn(int noOfGamesToPlay)
{
	// TODO: implementation here
}

void TicTacToePlayer_Student::makeMove(TicTacToePlayField& board)
{
	// TODO: implementation here
}

void TicTacToePlayer_Student::getBoardFeatures(TicTacToePlayField& board, int features[])
{
	// TODO: implementation here
}