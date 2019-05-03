#include "TicTacToe.h"

void showPlayField ( const TicTacToePlayField& playField )
{
	printf("+---+---+---+\n");
	for (int r=0 ; r<playField.getNRow() ; r++) {
		for (int c=0 ; c<playField.getNCol() ; c++) {
			printf("| %c ", playField.getVal(r,c) );
		}
		printf("|\n");
	}
	printf("+---+---+---+\n");
}