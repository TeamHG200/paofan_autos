#include "sillychis.h"

namespace chis {
	won_item silly_chis::won_map[WON_MAP_SIZE] = {};
	int silly_chis::max_min_search(int alpha, int beta, U8 ply) {
		
		auto &who_win = won_map[bod.hash_value() % WON_MAP_SIZE];
		if(bod.have_winner()) {//上家已经赢了
			who_win.key = bod.hash_value();
			who_win.steps = bod.moves_size();
			who_win.value = NEGA_LOS;
			return NEGA_LOS;
		}
		if(who_win.key == bod.hash_value() && (who_win.steps == bod.moves_size())
			&& (who_win.value == NEGA_LOS || who_win.value == NEGA_WON)) {
			return who_win.value;
		}
		if(ply <= 0) {
			return bod.evaluation();
		}
		std::vector<_point_with_value> moves(bod.get_turn() == BLK
			? bod.get_pruned_moves_black()
			: bod.get_pruned_moves_white());
		auto max_v = NEGA_LOS;
		for(auto &i : moves) {
			const Point &p = i.first;
			bod.make_move(p, bod.get_turn());
			int child_value;
			//pvs
			child_value = -max_min_search(-alpha - 1, -alpha, ply - 1);
			if(child_value >= alpha && child_value < beta) {
				child_value = -max_min_search(-beta, -alpha, ply - 1);
			}
			bod.unmove();
			if(child_value > max_v) {
				max_v = child_value;
				if(child_value > alpha) {
					alpha = (alpha = child_value);
					if(alpha >= beta) {//m持续变大而last_m取小，剪枝
						break;
					}
				}
			}
		}
		if(max_v == NEGA_LOS || max_v == NEGA_WON) {
			who_win.key = bod.hash_value();
			who_win.steps = bod.moves_size();
			who_win.value = max_v;
		}
		return max_v;
	}
	Point silly_chis::chis_move() {
		if(!bod.moves_size()) {
			return Point((U8)conf.SIZE / 2 + 5, conf.SIZE / 2 + 5);
		}
		std::vector<_point_with_value> moves(bod.get_turn() == BLK
			? bod.get_pruned_moves_black_root()
			: bod.get_pruned_moves_white_root());
		Point good_move;
		for(int depth = 2, alpha = NEGA_LOS; depth == 2 ||
			depth <= conf.search_depth; ++depth, alpha = NEGA_LOS) {
			
			std::sort(moves.begin(), moves.end());
			good_move = moves[0].first;
			while(moves.size() > 1 && moves.back().value == NEGA_LOS) {
				moves.pop_back();
			}
			if(moves[0].value == (NEGA_WON)) {
				return good_move;
			}
			for(auto &i : moves) {
				const Point &p = i.first;
				bod.make_move({ p.x, p.y }, bod.get_turn());
				int child_value;
				if(alpha == NEGA_LOS) {
					child_value = i.value = -max_min_search(NEGA_LOS, -alpha, depth);
				}
				else {
					child_value = i.value = -max_min_search(-alpha - 1, -alpha, depth);
					if(child_value >= alpha && child_value != NEGA_WON) {
						child_value = i.value = -max_min_search(NEGA_LOS, -alpha, depth);
					}
				}
				bod.unmove();
				if(child_value > alpha) {
					if(child_value == NEGA_WON) {
						return p;
					}
					alpha = child_value;
					good_move = p;
					
				}
			}
		}
		return good_move;
	}
}