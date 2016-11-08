#include "sillychis.h"
#include <iostream>
#include <time.h>
using namespace std;
using namespace chis;

Point chisPoint(int x, int y){
    return Point(x+5, y+5);
}

int main() {
	silly_chis sc(11);
    sc.bod.make_move(chisPoint(4,8), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(3,6), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(4,7), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(3,8), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(4,6), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(3,4), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(4,5), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(3,5), sc.bod.get_turn());
    sc.bod.make_move(chisPoint(4,4), sc.bod.get_turn());
    for(int i = 0; i < 11; ++i) {
			for(int j = 0; j < 11; ++j) {
				cout << (sc.bod[i+5][j+5] ? (sc.bod[i+5][j+5] == BLK ? "+" : "-") : ("*"));
			}
			cout << endl;
	}
	
    cout << (sc.bod.get_patterns().first.won  ? "true" : "false") << endl;
    cout << (sc.bod.get_patterns().second.won ? "true" : "false") << endl;
    /*
    while(!(sc.bod.get_patterns().first.won || sc.bod.get_patterns().second.won)) {
		
		auto t = time(NULL);
		sc.bod.make_move(sc.chis_move(), sc.bod.get_turn());
		t = time(NULL) - t;
		cout << "  0 1 2 3 4 5 6 7 8 9 1011121314" << endl;
		for(int i = 0; i < 15; ++i) {
			for(int j = 0; j < 15; ++j) {
				cout << (sc.bod[i + 5][j + 5] ? (sc.bod[i + 5][j + 5] == BLK ? "+" : "-") : ("*"));
			}
			cout << endl;
		}
		cout << t << "s" << endl;
	}
    */
}
