#ifndef CHIS_TYPES
#define CHIS_TYPES
#include <vector>
#include <algorithm>
#include "pattern_map.h"

/* Limits of integral types.  */
/* Minimum of signed integral types.  */
# define INT8_MIN               (-128)
# define INT16_MIN              (-32767-1)
# define INT32_MIN              (-2147483647-1)
# define INT64_MIN              (-__INT64_C(9223372036854775807)-1)
/* Maximum of signed integral types.  */
# define INT8_MAX               (127)
# define INT16_MAX              (32767)
# define INT32_MAX              (2147483647)
# define INT64_MAX              (__INT64_C(9223372036854775807))

/* Maximum of unsigned integral types.  */
# define UINT8_MAX              (255)
# define UINT16_MAX             (65535)
# define UINT32_MAX             (4294967295U)
# define UINT64_MAX             (__UINT64_C(18446744073709551615))

namespace chis {
	using U64 = unsigned int64_t;
	using U32 = unsigned int32_t;
	using U16 = unsigned int16_t;
	using U8 = unsigned char;
	struct Parameters;
	struct _depth_with_value_;
	struct _point_with_value;
	struct Point;
	struct chis_config;
	class _board;
	const U64 EMP = (0); //00
	const U64 BLK = (1); //01
	const U64 WHI = (2); //10
	const U64 SID = (3); //11
	const int NEGA_WON = (INT32_MAX - 1);
	const int NEGA_LOS = (INT32_MIN + 2);
	const U8 HASH_GAMEOVER = 0;
	const U8 HASH_ALPHA = 1;
	const U8 HASH_PV = 2;
	const U8 HASH_BETA = 3;
	struct config {
		size_t SIZE = 15;//棋盘大小
		int RULE = 0;//规则类型（只支持freestyle
		//time ms
		time_t search_time = 29900;//一次搜索时间
		time_t timeout_match = 180000;//总搜索时间上限
		time_t time_left = 180000;//剩下的时间

		size_t hash_max_size = 1024*100;//100MB
		size_t search_depth = 8;
	};
}
#endif
