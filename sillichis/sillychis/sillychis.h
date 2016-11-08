#ifndef SILLY_CHIS
#define SILLY_CHIS
#include "chis_board.h"
namespace chis {
	struct won_item {
		U64 key = 0;
		U16 steps = 999;
		U8 value = 0;
	};
	const size_t WON_MAP_SIZE = (1024 * 1024 * 100) / sizeof(won_item);
	class silly_chis {
		
	public:
		_board bod;
		Point chis_move();
		
		silly_chis() :bod(15) {}
		silly_chis(size_t bsize): bod(bsize) {
			conf.SIZE = bsize;
		}
	private:
		int max_min_search(int alpha, int beta, U8 ply);
		static won_item won_map[WON_MAP_SIZE];
		config conf;

	};
}
#endif