#include <iostream>
#include <fstream>
#include <ctime>
#include <vector>

#include "TicTacToe.h"
#include "TicTacToePlayer.h"

using namespace std;

int main()
{
	srand((unsigned)time(0));

	// two players
	TicTacToePlayer *player[2];
	//float fixed_weights[7] = { 0.5f, 1.0f, -1.0f, 0.6f, 0.7f, 0.5f, 1.0f };
	float fixed_weights[7] = { 1.0f, 1.0f, -1.0f, 1.0f, 1.0f, 1.0f, 1.0f };

	for(int training_games = 0; training_games <= 2000; training_games += 200)
	{
		cout << training_games << " training games" << endl;

		player[0] = new TicTacToePlayer_Student(fixed_weights);
		player[1] = new TicTacToePlayer_Student(fixed_weights);

		player[0]->learn(training_games);
		player[1]->learn(training_games);

		// Set which player uses crosses or circles
		player[0]->setColor(cross);
		player[1]->setColor(circle);

		int wins = 0;
		int losses = 0;
		for(int g = 0; g < 1000; g++)
		{
			TicTacToePlayField playField;

			// Select one player randomly to start
			int index = randInt(0,1);

			//index = 0;

			while ( !playField.gameFinished() ) {
				player[index]->makeMove ( playField );
				// switch player for next round
				index = (index+1) % 2;
			}

			PlayFieldState outcome = gameOutcome(playField);

			if(outcome == cross)
				wins++;
			else if(outcome == circle)
				losses++;
		}

		cout << "wins: " << wins*0.1f << "%, losses: " << losses*0.1f
			<< "%, draws: " << (1000-wins-losses)*0.1f << "%" << endl;

		delete player[0]; player[0]=0;
		delete player[1]; player[1]=0;

		cout << endl;
	}

	getchar();
	return 0;
}
